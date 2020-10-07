class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@posts = Post.where(user_id: @user.id)
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "ユーザー情報を変更しました"
			redirect_to user_path(@user.id)
		else
			render "edit"
		end
	end

	def like
		@user = User.find(params[:user_id])
		@likes = Like.where(user_id: params[:user_id])
	end

	def follow_index
		@relationships = Relationship.where(user_id: params[:user_id])
	end

	private
	def user_params
		params.require(:user).permit(:last_name, :first_name, :profile_img, :profile_text, :user_address, :nickname)
	end
end
