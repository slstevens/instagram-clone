class CommentsController < ApplicationController

	def new
		@photo = Photo.find(params[:photo_id])
		@comment = Comment.new
	end

	def create
		# @photo = Photo.find(params[:photo_id])
		# @photo.comments.create(comment_params)
		# redirect_to photos_path
		@photo = Photo.find(params[:photo_id])
		@comment = Comment.new(comment_params)
		@comment.user = current_user
		@comment.photo = Photo.find(params[:photo_id])
		if @comment.save
			redirect_to photos_path
		else
			flash.now[:notice] = "Didn't save"
			render 'new'
		end

		# @photo = Photo.new(photo_params)
		# @photo.user = current_user
		# if @photo.save
		# 	redirect_to photos_path
		# else
		# 	flash.now[:notice] = 'Minimum title length is 3'
		# 	render 'new'
		# end
	end

	def destroy
		@comment = current_user.comments.find(params[:id])
		@comment.destroy
		flash[:notice] = 'Comment deleted'
		redirect_to root_path
	rescue ActiveRecord::RecordNotFound
		flash[:notice] = "You can't delete this!"
		redirect_to root_path
	end

	def comment_params
		params.require(:comment).permit(:comments)
	end

end
