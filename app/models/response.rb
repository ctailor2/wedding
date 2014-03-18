class Response < ActiveRecord::Base
	belongs_to :invite
	belongs_to :member
end
