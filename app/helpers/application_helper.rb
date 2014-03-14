module ApplicationHelper
	def flash_class(type)
		type_class = case type
		when :success then "alert-success"
		when :info then "alert-info"
		when :warning then "alert-warning"
		when :danger then "alert-danger"
		end

		"alert #{type_class} alert-dismissable"
	end
end
