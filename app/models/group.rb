require 'securerandom'

class Group < ActiveRecord::Base
	has_many :members
	has_many :responses, through: :members
	has_many :invites, order: "event_id"
	before_create :generate_rsvp_code

	scope :ci_find_by_rsvp_code, lambda { |value| where("lower(rsvp_code) = ?", value.downcase).first }

	def saved(collection)
		self.send(collection).reject { |member| !member.persisted? }
	end

	def generate_rsvp_code
		self.rsvp_code = loop do
			random_code = SecureRandom.urlsafe_base64(4).upcase
			break random_code unless Group.exists?(rsvp_code: random_code) || random_code.match(/[-_oO0]+/)
		end
	end
end
