class VenmoController < ApplicationController
  def pay
    if current_diner.venmo_token.nil?
      return link
    end
    diner = Diner.find(params[:to_diner_id])
    amount = current_diner.balance_between(diner.id, current_group.id).abs
    if diner.venmo_token
      result_hash = use_access_token(diner.venmo_token)
      to_venmo_id = result_hash["data"]["id"]
      payment_result_hash = make_venmo_payment(to_venmo_id, amount)
      if payment_result_hash["data"]["payment"]["status"] != "failed"
        Payment.create!(from: current_diner, to: diner, amount: amount, group: current_group)
        redirect_to root_path, notice: "Venmo payment successful!"
      else
        redirect_to root_path, alert: "Venmo payment failed!"
      end
    else
      # send to email maybe?
      redirect_to root_path, alert: "Venmo couldn't be processed!"
    end
  end

  def link
    url = "https://api.venmo.com/v1/oauth/authorize?client_id=#{ENV['VENMO_CLIENT_ID']}&scope=make_payments%20access_profile%20access_email%20access_phone%20access_balance&response_type=code"
    redirect_to url
  end

  def oauth
    # TODO CHECK CSRF HERE
    code = params[:code]
    result_hash = exchange_code(code)
    current_diner.update_attributes(venmo_token: result_hash["access_token"], venmo_refresh_token: result_hash["refresh_token"])
    # if we save state in the request url we might be able to execute the payment that started this request
    redirect_to root_path, notice: 'Successfully linked venmo to your account'
  end

  def exchange_code(code)
    url = "https://api.venmo.com/v1/oauth/access_token"
    params = {
      "client_id" => ENV['VENMO_CLIENT_ID'],
      "client_secret" => ENV['VENMO_CLIENT_SECRET'],
      "code" => code
    }
    JSON.parse(Net::HTTP.post_form(URI.parse(url), params).body)
  end

  def make_venmo_payment(to_venmo_id, amount)
    if ENV['VENMO_STATUS'] == 'ACTIVE'
      url = "https://api.venmo.com/v1/payments"
      params = {
        "access_token" => current_diner.venmo_token,
        "user_id" => to_venmo_id,
        "amount" => amount,
        "note" => "Community App Payment"
      }
    else
      url = "https://sandbox-api.venmo.com/v1/payments"
      params = {
        "access_token" => current_diner.venmo_token,
        "user_id" => 145434160922624933,#to_venmo_id,
        "amount" => 0.10,#amount,
        "note" => "test community payment"
      }
    end
    JSON.parse(Net::HTTP.post_form(URI.parse(url), params).body)
  end

  def unlink
    current_diner.update_attributes(venmo_token: nil, venmo_refresh_token: nil)
    redirect_to root_path, notice: 'Successfully unlinked your venmo account'
  end
end