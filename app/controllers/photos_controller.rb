class PhotosController < ApplicationController

  def new
    @photo = current_user.photos.new
  end

  def create
    restaurant = Restaurant.find_or_create_by(name: restaurant_params[:restaurant])
    @photo = current_user.photos.new(image: photo_params[:image], dish_name: photo_params[:dish_name], restaurant_id: restaurant.id)
    if @photo.save
      @photo.pricetag = Pricetag.find_or_create_by(price: pricetag_params[:pricetag])
      @photo.associate_to_foodtags(foodtag_params[:foodtags].split(","))
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def index
    @photos = current_user.photos
    render json: @photo.to_json
  end

  def show
    @photo = Photo.find(params[:id])
    render json: @photo.to_json(methods: [:image_url], :include => { :foodtags => {:only => :description}, :pricetag => {:only => :price}})
  end

  private

  def photo_params
    params.require(:photo).permit(:image, :dish_name)
  end

  def pricetag_params
    params.require(:photo).permit(:pricetag)
  end

  def restaurant_params
    params.require(:photo).permit(:restaurant)
  end

  def foodtag_params
    params.require(:photo).permit(:foodtags)
  end

  # def photo_foodtag_params
  #   params.require(:photo).permit(:foodtag)
  # end

end
