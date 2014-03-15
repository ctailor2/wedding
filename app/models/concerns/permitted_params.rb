class PermittedParams < Struct.new(:params)
	def member
		params.require(:member).permit(*member_attributes)
	end

	def member_attributes
		[:first_name, :last_name, :age_group_id]
	end
end
