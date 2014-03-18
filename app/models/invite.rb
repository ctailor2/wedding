class Invite < ActiveRecord::Base
	belongs_to :event
	belongs_to :group
	has_many :responses
end
