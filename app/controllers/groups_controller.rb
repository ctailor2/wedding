class GroupsController < ApplicationController
	respond_to :js

	def find
		@group = Group.ci_find_by_rsvp_code(params[:rsvp_code])
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
		response_data = params[:response]
		if response_data.present?
			create_responses_from_data
			render nothing: true
		else
			head :bad_request
		end
	end

	private

		def create_responses_from_data
			params[:response].each do |invite_id, member_ids|
				member_ids.each do |member_id|
					Response.create(invite_id: invite_id, member_id: member_id)
				end
			end
		end
end
