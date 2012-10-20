class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email,
  :password,
  :password_confirmation,
  :remember_me,
  :firstname,
  :lastname,

  # Report fields associated with user
  :contractor_name,
  :contractor_address_1,
  :contractor_address_2,
  :contractor_city,
  :contactor_state,
  :contactor_zipcode

  has_many :projects, :dependent => :destroy
  has_many :sites, :dependent => :destroy, :through => :projects

  # Implement presence of unique email
  validates :email, :presence => true
  validates_uniqueness_of :email

  def send_pop_alerts
    @name = self.firstname
    UserMailer.pop_alert(self).deliver
  end

  def has_site?
    self.projects.each do |projects|
      return true if projects.sites.count > 0
    end
    return false 
  end

end
