class PageController < ApplicationController
	def home
		if signed_in? 
			redirect_to user_events_path
		end
	end

	def about
	end
end
