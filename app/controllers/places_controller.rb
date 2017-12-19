class PlacesController < ApplicationController
	before_action :authenticate_user!, except: %i[index categories]
  def index
  end

  def categories
  end

  def new_place
  	@place = current_user.places.build
    # @place = Place.new(user_id: current_user.id)
    logger.debug @place
  end

  def create
    @place = current_user.places.build(place_params)
    logger.debug @place.category_id
    @place.category_id = params[:category_id]
    if @place.save
      logger.debug 'Saved new place'
      redirect_to root_path
    else
      logger.debug 'Did not save new place'
      render :new_place
    end
  end

  def list_places
  end

  def place_params
    params.require(:place).permit(:name, :description, :category_id, :address)
  end
end
