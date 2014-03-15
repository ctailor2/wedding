class Member < ActiveRecord::Base
	belongs_to :group
	belongs_to :age_group
end
