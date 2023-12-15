class PlacesController < ApplicationController
  def index
  end

  def show
    places = BeermappingApi.places_in(session[:last_city])
    @place = places.find{ |obj| obj.id == params[:id] }
  end

  def search
    @place = params[:city]
    @places = BeermappingApi.places_in(@place)
    @weather = Weather.current(@place)
    session[:last_city] = params[:city]
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index, status: 418
    end
  end
end
