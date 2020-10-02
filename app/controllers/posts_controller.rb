class PostsController < ApplicationController
	def new
		@post = Post.new
	end

	def create
		# @をつけるのはrenderの際viewにデータを渡すため
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		if @post.save
			redirect_to posts_path
		else
			render "new"
		end
	end

	def index
		@posts = Post.all
	end

	def show
		@post = Post.find(params[:id])
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

	private
	def post_params
		params.require(:post).permit(:user_id, :sake_brewery_id, :sake_name, :sake_img, :tag_id, :sake_text, :sake_degree)
	end

end
