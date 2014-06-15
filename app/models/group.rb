require 'securerandom'

class Group < ActiveRecord::Base
	has_many :members, dependent: :destroy
	has_many :responses, through: :members
	has_many :invites, -> { order "event_id ASC" }, dependent: :destroy
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

  def self.by_side(side)
    Group.includes(:responses, :invites).where(side: side)
  end

  def self.total_for_side(side)
    by_side(side).count
  end

  def self.num_responded_for_side(side)
    by_side(side).select{ |group| group.responded? }.count
  end

  def self.total_groom_side
    total_for_side('Groom')
  end

  def self.num_responded_groom_side
    num_responded_for_side('Groom')
  end

  def self.total_bride_side
    total_for_side('Bride')
  end

  def self.num_responded_bride_side
    num_responded_for_side('Bride')
  end

  def self.total_both_sides
    total_groom_side + total_bride_side
  end

  def self.num_responded_in_total
    num_responded_groom_side + num_responded_bride_side
  end

  def responded?
    responses.count > 0 || invites.any? { |invite| invite.none_attending? }
  end

  def format_for_export
    row_data = invites.map { |invite| invite.total_and_attendees }
    row_data.unshift(name)
  end
end
