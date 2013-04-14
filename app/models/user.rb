require 'pp'

class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email,
    :password,
    :password_confirmation,
    :remember_me,
    :firstname,
    :lastname,
    :projects_attributes

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

  def has_site?
    self.projects.each do |project|
      return true if project.sites.count > 0
    end
    return false
  end

  # def map_forecasts
  #   self.sites.each do |site|
  #     @forecasts_array = pp site.forecast
  #   end
  # end

  # def puts_forecasts
  #   puts @forecasts_array
  # end

  # def print_forecasts
  #   self.sites.each do |forecasts|
  #     if self.has_site? == true
  #       self.map_forecasts
  #       self.puts_forecasts
  #     end
  #     puts "No sites = no forecasts"
  #   end
  # end

  def mail_alerts
    @name = self.firstname
    AlertMailer.pop_alert(self).deliver
  end

  def get_site_zipcodes
    zipcodes = []

    self.projects.each do |project|
      self.sites.each do |site|
        zipcodes << site.zipcode
      end
    end

    return zipcodes
  end

  def get_sites
    @site_names = []

    self.projects.each do |p|
      p.sites.each do |s|
        @site_names << s.name.to_s
      end
    end

    unless @site_names.blank?
      return @site_names
    else
      'no current sites'
    end
  end
end
