AgeGroup.find_or_create_by_description(description: "Adult (12+)")
AgeGroup.find_or_create_by_description(description: "Child Under 12")
AgeGroup.find_or_create_by_description(description: "Child Under 5")
Event.find_or_create_by_title(title: "Vidhi")
Event.find_or_create_by_title(title: "Manglik Prasango")
Event.find_or_create_by_title(title: "Raas-Garba")
Event.find_or_create_by_title(title: "Wedding")
Event.find_or_create_by_title(title: "Reception")

uma_data = GoogleSpreadsheet.new("0Aht20VD6GO7odG5OOXVJbXlpbmtNS01Kek4wbjc3Smc")
uma_data.group_invite_data.each_with_index do |data_row, index|
	name = data_row[0]
	invite_data = data_row[1..-2]
	group = Group.create(name: name)
	uma_data.worksheet[index + 2, 6] = group.rsvp_code

	event_invite_data = invite_data.zip(uma_data.event_ids)
	event_invite_data.each do |data|
		num_invited = data.first.to_i
		event_id = data.last

		unless num_invited.blank? || num_invited == 0
			group.invites.create(num_invited: num_invited, event_id: event_id)
		end
	end
end

uma_data.worksheet.save()
