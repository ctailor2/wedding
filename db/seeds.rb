AgeGroup.find_or_create_by_description(description: "Adult (12+)")
AgeGroup.find_or_create_by_description(description: "Child Under 12")
AgeGroup.find_or_create_by_description(description: "Child Under 5")
Event.find_or_create_by_title(title: "Vidhi")
Event.find_or_create_by_title(title: "Manglik Prasango")
Event.find_or_create_by_title(title: "Raas-Garba")
Event.find_or_create_by_title(title: "Wedding")
Event.find_or_create_by_title(title: "Reception")

chirag_worksheet = GoogleWorksheet.new("0Aht20VD6GO7odGlJQm1hS0tsd3NLbkd1dUQ5Tk1OdEE")
chirag_worksheet.import
chirag_worksheet.save

