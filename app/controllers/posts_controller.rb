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
		tag_list = post_params[:tag_name].to_s.split(",")

			if @post.save
				@post.save_posts(tag_list)
				flash[:notice] = "投稿しました"
				redirect_to posts_path
		    else
		    	render "new"
		    end
	end

	def index
		@posts = Post.all.page(params[:page]).per(9)
		@tag_list = Tag.all
	end

	def show
		@post = Post.find(params[:id])
		@post_tags = @post.tags
		@comment = Comment.new
		@comments = Comment.where(post_id: @post.id)
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

	private
	def post_params
		params.require(:post).permit(:user_id, :sake_brewery_id, :sake_name, :sake_img, :tag_id, :sake_text, :sake_degree, sake_brewery_attributes:[:id, :brewery_name, :brewery_prefecture, :brewery_address], tag_attributes:[:tag_name])
	end

end
