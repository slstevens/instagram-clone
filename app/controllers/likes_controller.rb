class LikesController < ApplicationController

	def create
		# @photo = Photo.find(params[:photo_id])
		# @like = Like.new
		# @like.user = current_user
		# @like.photo = Photo.find(params[:photo_id])
		# @like.save
		# render json: {new_like_count: @photo.likes.count}
		@photo = Photo.find(params[:photo_id])
		if @photo.likes.create(user_id: current_user.id)
			flash.now[:notice] =  "Thank you for liking!"
			render json: {new_like_count: @photo.likes.count}
			# redirect_to photos_path
		else
			flash.now[:notice] = "You have already liked this!"
			# redirect_to photos_path
		end
	end

end
