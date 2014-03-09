require "rubygems"
require "roo"
require "google_drive"

current_valuation = 0
#key = "0AkHkekTTsBL0dGJ5Ty14YjRud2VBbHhDMXd2UGZPVlE"

SCHEDULER.every '2s' do
	# Logs in.
	# You can also use OAuth. See document of
	# GoogleDrive.login_with_oauth for details.
	
	session = GoogleDrive.login("eric@plaidy.net", "Ricky03!")
	ws = session.spreadsheet_by_key("0AkHkekTTsBL0dGJ5Ty14YjRud2VBbHhDMXd2UGZPVlE").worksheets[0]

    current_valuation = ws[1, 2].to_f      # cellule ligne 1 colonne 2
	last_valuation = ws[2, 2].to_f
	value = ws[3, 2].to_f
	value_min = ws[3, 3].to_f
	value_max = ws[3, 4].to_f

	send_event('valuation', { current: current_valuation, last: last_valuation })
	send_event('gain', { value: value, min: value_min, max: value_max })
end
