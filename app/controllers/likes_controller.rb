class LikesController < ApplicationController
  def create
    user = current_user
    @post = Post.find(params[:post_id])
    like = Like.new(user_id: user.id, post_id: @post.id)
    like.save
  end

  def destroy
    user = current_user
    @post = Post.find(params[:post_id])
    like = Like.find_by(user_id: user.id, post_id: @post.id)
    like.destroy
  end
end
