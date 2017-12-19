class PlacesController < ApplicationController
	before_action :authenticate_user!, except: %i[index categories]
  def index
  end

  def categories
  end

  def new_place
  end

  def list_places
  end

end
