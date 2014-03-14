class GroupsController < ApplicationController
	def find
		@group = Group.find_by_rsvp_code(params[:rsvp_code])
		respond_to do |format|
			if @group.present?
				format.js
			else
				# Need to figure out a way to render flash messages on ajax calls.
				# format.js { render nothing: true, flash: { info: "Group Not Found" } }
			end
		end
	end
end
