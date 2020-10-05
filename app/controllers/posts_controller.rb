class PostsController < ApplicationController
	def new
		@post = Post.new
		@post.build_sake_brewery
	end

	def create
		# @をつけるのはrenderの際viewにデータを渡すため
		@sake_brewery = SakeBrewery.find_or_create_by(brewery_name: post_params[:sake_brewery_attributes][:brewery_name], brewery_prefecture: post_params[:sake_brewery_attributes][:brewery_prefecture] )
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		@post.sake_brewery_id = @sake_brewery.id

			if @post.save
				flash[:notice] = "投稿しました"
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
		@comment = Comment.new
		@comments = Comment.where(post_id: @post.id).order(created_at: :desc)
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

	private
	def post_params
		params.require(:post).permit(:user_id, :sake_brewery_id, :sake_name, :sake_img, :tag_id, :sake_text, :sake_degree, sake_brewery_attributes:[:id, :brewery_name, :brewery_prefecture, :brewery_address])
	end

end
