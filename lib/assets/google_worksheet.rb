class GoogleWorksheet
  attr_reader :session, :title, :worksheet, :summary_worksheet, :list, :event_id_reference

  def initialize(key)
    connect
    spreadsheet = session.spreadsheet_by_key(key)
    @title = spreadsheet.title
    @worksheet = spreadsheet.worksheets[0]
    @summary_worksheet = spreadsheet.worksheets[1]
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
    ["Name", "Address1", "Address2", "Code", "Side"]
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
      num_invited = row[title].to_i
      event_id = event_id_reference[title]
      unless num_invited.blank? || num_invited.zero?
        group.create_invite(num_invited, event_id)
      end
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
    # TODO: Destroying may be a dangerous operation, in case responses have
    # already started coming in for one or more invites. Need a more robust
    # update row method. Also need to consider if num_invited is zero.
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

  def export_rsvp_data(side)
    data = Group.by_side(side).map do |group|
      group.format_for_export
    end
    summary_worksheet.update_cells(2, 1, data)
    summary_worksheet.save
  end
end
