# == Schema Information
#
# Table name: diners
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  role                   :string(255)
#

class Diner < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_and_belongs_to_many :meals
	has_many :ingredients, :dependent => :destroy

  after_create :set_default_name

  def set_default_name
    update_attribute(:name, email) if name.empty?
  end
	
  def cost
    meals.sum { |meal| meal.cost_for_single_diner }
  end

  #calculates how much another diner owes you
  def request_payment_from(another_diner_id) 
    total_payment = 0.0
    ingredients.where(finished: true).each do |ingredient|
      total_payment += ingredient.payment_owed_by(another_diner_id)
    end
    total_payment
  end

  #calculates balance between two diners
  #if positive, another_diner owes the current diner
  def balance_between(another_diner_id)
    total_requested = request_payment_from(another_diner_id)
    total_paid = 0.0
    #another_diner pays current diner
    Payment.where(to_id: id, from_id: another_diner_id).each do |payment|
      total_paid += payment.amount
    end
    #current_diner pays another_diner
    Payment.where(from_id: id, to_id: another_diner_id).each do |payment|
      total_paid -= payment.amount
    end
    total_requested-total_paid
  end

  def pay_others
    who_you_owe = []
    Diner.where.not(id: id).each do |other_diner|
      who_you_owe << {diner_name: other_diner.name, diner_id: other_diner.id, owed_amount: other_diner.request_payment_from(id)}
    end
    who_you_owe
  end

  #this method determines how much you owe another diner and settles it by setting your 
  def settle(diner_owed)

    Payment.create()
  end

  def to_s
    name
  end
end
