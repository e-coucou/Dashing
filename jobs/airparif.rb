require "rubygems"
require "roo"
require "google_drive"

current_valuation = 0
#key = "0AkHkekTTsBL0dGJ5Ty14YjRud2VBbHhDMXd2UGZPVlE"
key = "0AsWa_wvrz5AndDBHVS1BbXU1MVJpVDE2VDk3akNJOWc"

SCHEDULER.every '2s' do
	# Logs in.
	# You can also use OAuth. See document of
	# GoogleDrive.login_with_oauth for details.
	
	session = GoogleDrive.login("automate@e-coucou.com", "Penelope75!")
	ws = session.spreadsheet_by_key(key).worksheets[1]

    PM10 = ws[1, 2].to_f   # cellule ligne 1  / colonne 2
	NO2 = ws[1, 3].to_f		# l/c
    PM10 = ws[1, 6].to_f   # cellule ligne 1  / colonne 2
	NO2 = ws[1, 7].to_f		# l/c

	send_event('ap-val', { current: PM10, moreinfo: '' })
	send_event('ap-fo', { current: PM10, moreinfo: '' })
	send_event('ap-circle', { value: PM10, min: 0, max: 150 , moreinfo: "cible : 10 encours max" })
	send_event('ap-bg', {	max: PM10,	value: PM10	})
end
