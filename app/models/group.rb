class Group < ActiveRecord::Base
	has_many :members
	has_many :responses, through: :members
	has_many :invites

	def saved(collection)
		self.send(collection).reject { |member| !member.persisted? }
	end
end
