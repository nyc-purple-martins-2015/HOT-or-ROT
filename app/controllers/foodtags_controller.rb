class FoodtagsController < ApplicationController

  def new
    @foodtag = Foodtag.new
  end

  def create
    @foodtag = Foodtag.new(foodtag_params)
    if @foodtag.save
      # Foodtag is saved after the photo is saved. This should
      # render the user profile

      render json: @foodtag.to_json
    else
      render :new
    end
  end

  #
  def show
    @foodtag = Foodtag.find_by(description: foodtag_params)
    render json: @foodtag.to_json
  end

  def parse_foodtags(photo, foodtag_params)
    foodtags = foodtag_params[:description].split(/[-,\/]/)
    foodtags = foodtags.map { |tag| Foodtag.find_or_create_by(description: foodtag.strip) }.uniq
    photo.foodtags.clear unless photo.foodtags.empty?

    foodtags.each do |tag|
      photo.foodtags << tag
    end
  end


  private

  def foodtag_params
    params.require(:foodtag).permit(:foodtags)
  end

end
