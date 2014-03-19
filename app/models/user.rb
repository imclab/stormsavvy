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
  validates_presence_of :email, :password
  validates_uniqueness_of :email

  def has_site?
    return true if self.sites.count > 0
    # self.projects.each do |project|
    #   return true if project.sites_count > 0
    # end
    return false
  end

  def get_site_zipcodes
    zipcodes = []

    self.sites.each do |site|
      zipcodes << site.zipcode
    end

    return zipcodes
  end

  def get_sites
    site_names = []

    self.sites.each do |site|
      site_names << site.name.to_s
    end

    unless site_names.blank?
      return site_names
    else
      'no current sites'
    end
  end

  def noaa_forecast
    self.sites.each do |site|
      begin
        # pp 'sleep 2s between queries'
        # sleep 2
        site.save_noaa
      rescue => e
        # pp 'NOAA API connection cannot be established'
        pp e
      end
    end
  end

  def wg_forecast
    self.sites.each do |site|
      begin
        pp 'sleep 7s between queries'
        sleep 7
        site.save_wg
      rescue
        pp 'Wunderground API connection cannot be established'
      end
    end
  end
end
