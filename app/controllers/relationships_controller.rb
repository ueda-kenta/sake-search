class RelationshipsController < ApplicationController

	before_action :set_user

	def create
    following = current_user.follow(@user)
    # following.save
    # redirect_back(fallback_location: posts_path)
    following.save
  end

  def destroy
    following = current_user.unfollow(@user)
    # following.destroy
    # redirect_back(fallback_location: posts_path)
    following.destroy
  end


  private
  def set_user
  	@user = User.find params[:follow_id]
  end


end
