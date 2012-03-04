class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :lastname,
  :contractor_name, :contractor_address_1, :contractor_address_2, :contractor_city, :contactor_state, :contactor_zipcode

  has_many :sites, :dependent => :destroy

  has_many :projects, :dependent => :destroy
end
