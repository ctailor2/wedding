class MembersController < ApplicationController
	def create
		@group = Group.find(params[:group_id])
		@member = @group.members.build(permitted_params.member)
		if @member.save
			render partial: "member", locals: { member: @member, group: @group }
		else
			head :bad_request
		end
	end

	def destroy
		Member.find(params[:id]).destroy
		head :ok
	end
end
