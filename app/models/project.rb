class Project < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :user

  #has_many :reports, :through => :sites
  attr_accessible :user,
    :user_id,
    :name,
    :description,
    :startdate,
    :finishdate,
    :active,
    :sites_attributes

  has_many :sites, :dependent => :destroy
  accepts_nested_attributes_for :sites

  validates_presence_of :name,
    :description
    # :startdate,
    # :finishdate

    # before_save :check_dates

    # def check_dates
    #   return false if self.startdate > self.finishdate

    #   if self.startdate > self.finishdate
    #     raise ActiveRecord::RecordNotSaved, 'Starting date must precede finishing date'
    #   end
    # end

  def get_site_zipcodes
    zipcodes = []
    self.sites.each do |site|
      # zipcodes << site.get_zipcode
      zipcodes << site.zipcode
    end

    return zipcodes
  end
end
