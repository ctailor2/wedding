require 'csv'

namespace :import do
  desc "Import group and invite data from a csv file in lib/assets, e.g., rake import:csv FILE=filename"
  task csv: :environment do
		unless ENV.has_key?('FILE')
			raise "Must specify filename, e.g., rake import:csv FILE=filename"
		end

		filename = ENV['FILE']
		filepath = Rails.root.join('lib', 'assets', filename)
		file = CSV.open(filepath, converters: :numeric)

		event_titles = file.shift[1..-1]
		events = event_titles.map { |title| Event.find_by_title(title) }
		event_ids = events.map { |event| event.id }

		file.each_with_index do |data_row, index|
			name = data_row.shift
			group = Group.create(name: name, rsvp_code: "1234" + index.to_s)

			invite_data = data_row.zip(event_ids)
			invite_data.each do |data|
				num_invited = data.first
				event_id = data.last

				unless num_invited.blank? || num_invited == 0
					group.invites.create(num_invited: num_invited,  event_id: event_id)
				end
			end
		end
  end

end
