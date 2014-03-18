class Member < ActiveRecord::Base
	belongs_to :group
	belongs_to :age_group
	has_many :responses, dependent: :destroy

	before_create :capitalize_names

	validates_presence_of :first_name, :last_name

	def capitalize_names
		self.first_name.capitalize!
		self.last_name.capitalize!
	end

	def full_name
		"#{first_name} #{last_name}"
	end
end
