require 'net/http'

class VenmoController < ApplicationController
  skip_before_filter :check_group!
  skip_before_filter :authenticate_diner_with_signup!

  def pay
    if current_diner.venmo_token.nil?
      return link
    end
    diner = Diner.find(params[:to_diner_id])
    unless current_group_ids.include? diner.id
      return redirect_to root_path, alert: "Can't make payments across groups!"
    end
    amount = current_diner.balance_between(diner.id, current_group.id).abs
    if diner.venmo_token
      result_hash = use_access_token(diner.venmo_token, diner.id)
      to_venmo_id = result_hash.try(:[], 'data').try(:[], 'user').try(:[], 'id')
      if to_venmo_id.nil?
        return redirect_to root_path, alert: "Venmo payment failed! Couldn't find target user!"
      end
      payment_result_hash = make_venmo_payment(to_venmo_id, amount)
      if payment_result_hash["error"]
        return redirect_to root_path, alert: "Venmo payment failed! #{payment_result_hash["error"]["message"]}"
      end

      status = payment_result_hash.try(:[], 'data').try(:[], 'payment').try(:[], 'status')
      if status && status != "failed"
        Payment.create!(from: current_diner, to: diner, amount: amount, group: current_group)
        redirect_to root_path, notice: "Venmo payment successful!"
      else
        redirect_to root_path, alert: "Venmo payment failed. Please check your venmo balance."
      end
    else
      # send to email maybe?
      redirect_to root_path, alert: "Venmo couldn't be processed!"
    end
  end

  def link
    session['venmo_signup'] = false # if they try to do a normal venmo link make sure it doesn't think they are signing up!
    url = "https://api.venmo.com/v1/oauth/authorize?client_id=#{ENV['VENMO_CLIENT_ID']}&scope=make_payments%20access_profile%20access_email%20access_phone%20access_balance&response_type=code&state=#{CGI.escape form_authenticity_token}"
    redirect_to url
  end

  def signup
    session['venmo_signup'] = true
    url = "https://api.venmo.com/v1/oauth/authorize?client_id=#{ENV['VENMO_CLIENT_ID']}&scope=make_payments%20access_profile%20access_email%20access_phone%20access_balance&response_type=code&state=#{CGI.escape form_authenticity_token}"
    redirect_to url
  end

  def oauth
    # params['state'] = token               # good response from venmo
    # params['state'] = token?error=message # bad response from venmo
    # params['state'] = nil                 # not response from venom.
    state = params['state'].split('?')
    if state[1]
      error_message = state[1].split('=')[1]
      return redirect_to root_path, alert: "Did not link venmo."
    end
    if form_authenticity_token != params[:state]
      return redirect_to root_path, alert: "Invalid CSRF token. Venmo Link halted"
    end
    code = params[:code]
    result_hash = exchange_code(code)
    if result_hash["error"]
      return redirect_to root_path, alert: result_hash["error"]["message"]
    end

    if session['venmo_signup']
      session['name'] = result_hash['user']['display_name']
      session['email'] = result_hash['user']['email']
      session['venmo_access_token'] = result_hash["access_token"]
      session['venmo_refresh_token'] = result_hash["refresh_token"]
      redirect_to check_group_path(email: { email: result_hash['user']['email']}), notice: 'Successfully linked venmo, please proceed to signup'
    else
      current_diner.update_attributes(venmo_token: result_hash["access_token"], venmo_refresh_token: result_hash["refresh_token"])
      # TODO
      # if we save state in the request url we might be able to execute the payment that started this request
      redirect_to root_path, notice: 'Successfully linked venmo to your account'
    end
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
    if ENV['VENMO_STATUS'] == 'ACTIVE' && current_group.name != ENV['VENMO_TEST_GROUP']
      url = "https://api.venmo.com/v1/payments"
      params = {
        "access_token" => current_diner.venmo_token,
        "user_id" => to_venmo_id,
        "amount" => amount,
        "note" => "Community App Payment on #{Date.today}",
        "audience" => 'friends'
      }
    else
      url = "https://sandbox-api.venmo.com/v1/payments"
      params = {
        "access_token" => current_diner.venmo_token,
        "user_id" => 145434160922624933,
        "amount" => 0.10,
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