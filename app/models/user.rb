class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :lastname
  has_many :sites, :dependent => :destroy

  has_many :projects, :dependent => :destroy

  def send_pop_alerts
    @name = self.firstname
    UserMailer.pop_alert(self).deliver
  end

end
