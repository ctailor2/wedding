class GroupsController < ApplicationController
	respond_to :js

	def find
		@group = Group.find_by_rsvp_code(params[:rsvp_code])
		if @group.present?
			@member = @group.members.new
			render partial: "find"
		else
			head :not_found
		end
	end

	def rsvp
		@group = Group.find(params[:group_id])
		@group.responses.each(&:destroy)
		params[:response].each do |invite_id, member_ids|
			member_ids.each do |member_id|
				Response.create(invite_id: invite_id, member_id: member_id)
			end
		end
		render nothing: true
	end
end
