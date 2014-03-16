require "rubygems"
require "roo"
require "google_drive"

#key = "0AkHkekTTsBL0dGJ5Ty14YjRud2VBbHhDMXd2UGZPVlE"
key = "0AkmmwnTmClhodDBHa2xJSDBtTE5LVF9UYktmOUZTeGc"

SCHEDULER.every '2s' do
	# Logs in.	
	session = GoogleDrive.login("automate@e-coucou.com", "Penelope75!")
	ws = session.spreadsheet_by_key(key).worksheets[1]

	lieu = ws[1, 2]   # cellule ligne 1  / colonne 2
  	date = ws[1, 3]		# l/c
	heure = ws[1, 4]		# l/c
	c_PM10 = ws[1, 6].to_f   # cellule ligne 1  / colonne 2
	c_NO2 = ws[1, 7].to_f		# l/c

	send_event('ap-val', { current: c_PM10, moreinfo: date+" "+heure })
#	send_event('ap-fo', { current: NO2, moreinfo: '' })
	send_event('ap-circle', { value: c_PM10, min: 0, max: 150 , moreinfo: date+" "+heure })
	send_event('ap-bg', {	max: 150,	value: c_NO2	})
end
