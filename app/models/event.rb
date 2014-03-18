class Event < ActiveRecord::Base
	has_many :invites
	has_many :responses, through: :invites
	has_many :members, through: :responses
end
