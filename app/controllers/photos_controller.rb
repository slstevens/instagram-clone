class PhotosController < ApplicationController

	before_action :authenticate_user!, :except => [:index, :show]

	def index
		@photos = Photo.all
	end

	def new
		@photo = Photo.new
	end

	def create
		@photo = Photo.new(photo_params)
		@photo.user = current_user
		if @photo.save
			redirect_to photos_path
		else
			flash.now[:notice] = 'Minimum title length is 3'
			render 'new'
		end
	end

	def photo_params
		params.require(:photo).permit(:title, :image)
	end

	def edit
		# @photo = Photo.find(params[:id])
		@photo = current_user.photos.find(params[:id])
		rescue ActiveRecord::RecordNotFound
		redirect_to root_path
		flash[:notice] = "You're not allowed to edit!"
	end

	def update
		@photo = Photo.find(params[:id])
		@photo.update(photo_params)
		redirect_to '/photos'
	end

	def destroy
		@photo = current_user.photos.find(params[:id])
		@photo.destroy
		flash[:notice] = 'Photo deleted successfully'
		redirect_to root_path
		rescue ActiveRecord::RecordNotFound
		flash[:notice] = "You're not allowed to delete!"
	  redirect_to root_path
		# @photo = Photo.find(params[:id])
		# @photo.destroy
		# flash[:notice] = 'Photo deleted successfully'
		# redirect_to '/photos'
	end
end
