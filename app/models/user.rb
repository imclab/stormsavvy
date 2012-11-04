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
  accepts_nested_attributes_for :projects

  has_many :sites, :dependent => :destroy, :through => :projects
  accepts_nested_attributes_for :sites

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

  def list_sites
    self.projects.each do |projects|
      if self.has_site? == true
        @projects.sites.each do |site|
          puts site
        end
        # sites_array = self.sites.map { |s| s.name }
        # puts sites_array 
      end
      return false
    end
  end

  # def build_sites
  #   @user = User.new(:email => 'foo@bar.com')
  #   @project = @user.projects.build
  #   @site = @project.sites.build
  # end

end