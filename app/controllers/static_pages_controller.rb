class StaticPagesController < ApplicationController
  def home
		if logged_in
			@entry = current_user.entries.build			
		end
	end

	def help
	end
end
