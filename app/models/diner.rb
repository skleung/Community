class Diner < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_and_belongs_to_many :meals
	has_many :ingredients

  after_create :set_default_name

  def set_default_name
    update_attribute(:name, email)
  end
	
end
