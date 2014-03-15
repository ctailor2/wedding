class GroupsController < ApplicationController
	def find
		@group = Group.find_by_rsvp_code(params[:rsvp_code])
		if @group.present?
			@member = @group.members.new
			render partial: "find"
		else
			head :not_found
		end
	end
end
