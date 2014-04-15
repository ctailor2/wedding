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
    @group.invites.each { |invite| invite.update_attributes(none_attending: false) }
    response_data = params[:response]
    none_data = params[:none]
    if response_data.present? && none_data.present?
      update_none_from_data
      create_responses_from_data
      render nothing: true
    elsif none_data.present?
      update_none_from_data
      head :bad_request
    else
      head :expectation_failed
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

    def update_none_from_data
      params[:none].each do |invite_id|
        Invite.find(invite_id).update_attributes(none_attending: true)
      end
    end
end
