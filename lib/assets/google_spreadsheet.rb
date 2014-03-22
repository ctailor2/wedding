class GoogleSpreadsheet
	attr_reader :session, :title, :worksheet

	def initialize(key)
		connect
		spreadsheet = session.spreadsheet_by_key(key)
		@title = spreadsheet.title
		@worksheet = spreadsheet.worksheets[0]
	end

	def connect
		creds = HashWithIndifferentAccess.new(YAML.load_file('config/google_drive.yml'))[Rails.env]
		@session = GoogleDrive.login(creds[:email], creds[:password])
	end

	def event_titles
		worksheet.rows.first[1..-2]
	end

	def events
		event_titles.map { |title| Event.find_by_title(title) }
	end

	def event_ids
		events.map { |event| event.id }
	end

	def group_invite_data
		worksheet.rows[1..-1]
	end

end
