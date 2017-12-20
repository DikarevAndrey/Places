class PlacesController < ApplicationController
	before_action :authenticate_user!, except: %i[index categories show]
  before_action :find_place, only: %i[show edit update destroy]

  def index
  end

  def categories
    @categories = Category.all.map { |e| { id: e.id, name: e.name } }
  end

  def show
    redirect_to newPlace_path unless @place
  end

  def destroy
    @place.destroy
    logger.debug 'Place destroyed'
    redirect_to listPlaces_path
  end

  def new_place
  	@place = current_user.places.build
  end

  def create
    @place = current_user.places.build(place_params)
    @place.category_id = params[:category_id]
    logger.debug @place.address
    logger.debug @place.latitude
    logger.debug @place.longitude
    logger.debug @place.valid?
    logger.debug @place.errors.full_messages
    if @place.save
      logger.debug 'Saved new place'
      # flash[:notice] = "Place successfully created"
      redirect_to root_path
    else
      logger.debug 'Did not save new place'
      # flash.alert = "Incorrect address"
      render :new_place
    end
  end

  def edit
    redirect_back(fallback_location: root_path) unless @place.user_id == current_user.id
  end

  def update
    if @place.update_attributes(place_params)
      redirect_to place_path(@place.id)
    else
      render :edit
    end
  end

  def list_places
    @categories = Category.all.map { |e| { id: e.id, name: e.name } }
  end

  private

  def place_params
    params.require(:place).permit(:name, :description, :category_id, :address)
  end

  def find_place
    @place = Place.find_by(id: params[:id])
  end
end
