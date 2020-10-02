class UsersController < ApplicationController
	private
	def user_params
		params.require(:user).permit(:last_name, :first_name, :profile_img_id, :profile_text, :user_address, :nickname)
	end
end
