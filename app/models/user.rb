class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	attr_accessor :temp_secret_number

	belongs_to :secret_code

	validate :match_secret_number

	after_create :assign_default_role

	private

	def match_secret_number
	    if secret_code.code != temp_secret_number
	      errors.add(:secret_code, ' is not matching')
	    end
	end
	def assign_default_role
		self.add_role(:user) if self.roles.blank?
	end
end
