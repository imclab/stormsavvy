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
    # :contractor_state,
    # :contractor_zipcode

  has_many :sites, :dependent => :destroy
  # accepts_nested_attributes_for :sites

  # has_many :projects, :dependent => :destroy
  # accepts_nested_attributes_for :projects

  validates :email, :presence => true
  validates_presence_of :email,
    :password
  validates_uniqueness_of :email

  def has_site?
    return true if self.sites.count > 0
    # return true if self.sites_count > 0

    # self.projects.each do |project|
    #   return true if project.sites_count > 0
    # end
    return false
  end

  def mail_alerts
    @name = self.firstname
    AlertMailer.pop_alert(self).deliver
  end

  def get_site_zipcodes
    zipcodes = []

    self.sites.each do |site|
      zipcodes << site.zipcode
    end

    # self.projects.each do |project|
    #   self.sites.each do |site|
    #     zipcodes << site.zipcode
    #   end
    # end

    return zipcodes
  end

  def get_sites
    @site_names = []

    self.sites.each do |s|
      @site_names << s.name.to_s
    end

    unless @site_names.blank?
      return @site_names
    else
      'no current sites'
    end
  end
end
