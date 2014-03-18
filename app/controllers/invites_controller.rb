class InvitesController < ApplicationController
	def index
		@group = Group.find(params[:group_id])
		render partial: "form", locals: { group: @group }
	end
end
