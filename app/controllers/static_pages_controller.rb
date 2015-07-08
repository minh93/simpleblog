class StaticPagesController < ApplicationController
  def home
		if logged_in
			@entries  = current_user.entries.build			
		end
	end

	def help
	end
end
