class RatingsController < ApplicationController
  before_action :expire_rating_statistics_fragments, only: [:create, :destroy]
  def index
    @ratings = Rating.all
    @top_users = User.top(3)
    @last_ratings = Rating.last(5)
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user

    if @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to ratings_path
  end

  private

  def expire_rating_statistics_fragments
    expire_fragment('brewerylists')
    %w(beerlist-name beerlist-brewery beerlist-style).each{ |f| expire_fragment(f) }
  end
end
