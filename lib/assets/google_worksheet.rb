class GoogleWorksheet
  attr_reader :session, :title, :worksheet, :list, :event_id_reference

  def initialize(key)
    connect
    spreadsheet = session.spreadsheet_by_key(key)
    @title = spreadsheet.title
    @worksheet = spreadsheet.worksheets[0]
    @list = worksheet.list
    @event_id_reference = event_title_id_lookup
  end

	def connect
    if Rails.env == "development"
      creds = HashWithIndifferentAccess.new(
        YAML.load_file('config/google_drive.yml')
      )
    elsif Rails.env == "production"
      creds = {}
      creds[:email] = ENV['EMAIL']
      creds[:password] = ENV['PASSWORD']
    end
		@session = GoogleDrive.login(creds[:email], creds[:password])
	end

  def non_event_titles
    ["Name", "Code", "Side"]
  end

  def event_titles
    list.keys.reject { |key| non_event_titles.include?(key) }
  end

  def events
    event_titles.map { |title| Event.find_by_title(title) }
  end

  def event_ids
    events.map { |event| event.id }
  end

  def event_title_id_lookup
    Hash[event_titles.zip(event_ids)]
  end
  
  def row(number)
    list[number - 2]
  end

  def import_row(number)
    row = row(number)
    return unless row[:Code].blank?

    group = Group.create(name: row[:Name], side: row[:Side])
    row[:Code] = group.rsvp_code

    event_titles.each do |title|
      num_invited = row[title]
      event_id = event_id_reference[title]
      group.create_invite(num_invited, event_id)
    end
  end

  def import
    num_rows = list.size
    (2..num_rows + 1).each do |number|
      import_row(number)
    end
  end

  def update_row(number)
    row = row(number)
    return if row[:Code].blank?

    group = Group.find_by_rsvp_code(row[:Code])
    group.update_attributes(name: row[:Name], side: row[:Side])
    group.invites.destroy

    event_titles.each do |title|
      num_invited = row[title]
      event_id = event_id_reference[title]
      group.create_invite(num_invited, event_id)
    end
  end

  def update
    num_rows = list.size
    (2..num_rows + 1).each do |number|
      update_row(number)
    end
  end

  def save
    worksheet.save
  end

  def reload
    worksheet.reload
  end
end
