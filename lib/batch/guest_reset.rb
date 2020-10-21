class Batch::GuestReset

	def self.reset
		guest = User.find_by(nickname: "ゲスト" )
		guest.posts.destroy
		p "OK"
	end
end