require 'securerandom'

class Group < ActiveRecord::Base
	has_many :members
	has_many :responses, through: :members
	has_many :invites, -> { order "event_id ASC" }
	before_create :generate_rsvp_code

	scope :ci_find_by_rsvp_code, lambda {
    |value| where("lower(rsvp_code) = ?", value.downcase).first
  }

	def saved(collection)
		self.send(collection).reject { |member| !member.persisted? }
	end

	def generate_rsvp_code
		self.rsvp_code = loop do
			random_code = SecureRandom.urlsafe_base64(4).upcase
			break random_code unless Group.exists?(rsvp_code: random_code) || random_code.match(/[-_oO0]+/)
		end
	end

  def create_invite(num_invited, event_id)
    unless num_invited.blank? || num_invited == 0
      invites.create(num_invited: num_invited, event_id: event_id)
    end
  end
end
