class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email,
    :password,
    :password_confirmation,
    :remember_me,
    :firstname,
    :lastname

  # Report fields associated with user
  # :contractor_name,
  # :contractor_address_1,
  # :contractor_address_2,
  # :contractor_city,
  # :contactor_state,
  # :contactor_zipcode

  has_many :projects, :dependent => :destroy
  has_many :sites, :dependent => :destroy, :through => :projects

  validates :email, :presence => true
  validates_presence_of :email,
    :password
  validates_uniqueness_of :email

  def send_pop_alerts
    @name = self.firstname
    AlertMailer.pop_alert(self).deliver
  end

  def has_site?
    self.projects.each do |projects|
      return true if projects.sites.count > 0
    end
    return false 
  end

end
