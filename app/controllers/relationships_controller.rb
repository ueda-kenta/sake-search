class RelationshipsController < ApplicationController

	before_action :set_user

	def create
    following = current_user.follow(@user)
    # following.save
    # redirect_back(fallback_location: posts_path)
    respond_to do |format|
      if  following.save
        flash[:notice] = "フォローしました"
        format.html { redirect_back(fallback_location: posts_path)}
        # format.js { redirect_to posts_path}
      end
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    # following.destroy
    # redirect_back(fallback_location: posts_path)
    respond_to do |format|
      if  following.destroy
        flash[:danger] = "フォローを解除しました"
        format.html { redirect_back(fallback_location: posts_path)}
        # format.js { redirect_to posts_path}
      end
    end
  end


  private
  def set_user
  	@user = User.find params[:follow_id]
  end


end
