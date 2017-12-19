class PlacesController < ApplicationController
	before_action :authenticate_user!, except: %i[index categories]
  def index
  end

  def categories
    @categories = Category.all.map { |e| { id: e.id, name: e.name } }
  end

  def new_place
  	@place = current_user.places.build
    # @place = Place.new(user_id: current_user.id)
  end

  def create
    @place = current_user.places.build(place_params)
    @place.category_id = params[:category_id]
    logger.debug @place.valid?
    if @place.save
      logger.debug 'Saved new place'
      logger.debug @place.address
      logger.debug @place.longitude
      logger.debug @place.latitude
      flash[:notice] = "Place successfully created"
      redirect_to root_path
    else
      logger.debug 'Did not save new place'
      logger.debug @place.address
      logger.debug @place.longitude
      logger.debug @place.latitude
      flash.alert = "Incorrect address"
      render :new_place
    end
  end

  def list_places
    @categories = Category.all.map { |e| { id: e.id, name: e.name } }
  end

  def place_params
    params.require(:place).permit(:name, :description, :category_id, :address)
  end
end
