class PhotosController < ApplicationController

	def index
		@photos = Photo.all
  end

  def new
  	@photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
	    redirect_to photos_path
	  else
	  	flash.now[:notice] = 'Minimum title length is 3'
	    render 'new'
	  end
  end

  def photo_params
    params.require(:photo).permit(:title)
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.update(photo_params)
    redirect_to '/photos'
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:notice] = 'Photo deleted successfully'
    redirect_to '/photos'
  end

end
