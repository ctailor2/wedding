class Invite < ActiveRecord::Base
	belongs_to :event
	belongs_to :group
	has_many :responses

  def total_and_attendees
    cell_data = responses.map do |response|
      response.member.full_name
    end
    cell_data.unshift(responses.count.to_s)
    cell_data.join("\n")
  end
end
