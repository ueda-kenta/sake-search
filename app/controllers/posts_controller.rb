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
				tag_list = params[:tag_names].to_s.split(nil)
				@post.save_tags(tag_list)
				flash[:notice] = "投稿しました"
				redirect_to posts_path
		    else
		    	render "new"
		    end
	end

	def index
		@posts = Post.all.page(params[:page]).per(9)
		@tag_list = Tag.all
	    @post = current_user.posts.new #よく分からん
	end

	def show
		@post = Post.find(params[:id])
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
		params.require(:post).permit(:user_id, :sake_brewery_id, :sake_name, :sake_img, :tag_id, :sake_text, :sake_degree, tag:[:tag_name], sake_brewery_attributes:[:id, :brewery_name, :brewery_prefecture, :brewery_address])
	end

	def tag_params
		params.require(:tag).permit(:tag_names)
	end

end
