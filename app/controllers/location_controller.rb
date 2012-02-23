class LocationController < ApplicationController
  def index
    @location = Location.all
  end

  def new
    @location = Location.new
  end

  def create
  end
end
