class Batch::Guest_reset

	def reset
		guest = User.find_by(nickname: "ゲスト" )
		guest.posts.destroy_all
		p OK
	end
end