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

  def request_payment_from(another_diner_id) 
    total_payment = 0.0
    ingredients.where(finished: true).each do |ingredient|
      total_payment += ingredient.payment_owed_by(another_diner_id)
    end
    total_payment
  end

  def pay_others
    who_you_owe = []
    Diner.where.not(id: id).each do |other_diner|
      who_you_owe << {diner_name: other_diner.name, diner_id: other_diner.id, owed_amount: other_diner.request_payment_from(id)}
    end
    who_you_owe
  end

  def to_s
    name
  end
end
