require "rubygems"
require "roo"
require "google_drive"

#key = "0AkHkekTTsBL0dGJ5Ty14YjRud2VBbHhDMXd2UGZPVlE"
key = "0AsWa_wvrz5AndDBHVS1BbXU1MVJpVDE2VDk3akNJOWc"

SCHEDULER.every '2s' do
	# Logs in.	
	session = GoogleDrive.login("automate@e-coucou.com", "Penelope75!")
	ws = session.spreadsheet_by_key(key).worksheets[0]

#p  Lieu = ws[1, 2].to_f   # cellule ligne 1  / colonne 2
#p	Date = ws[1, 3].to_f		# l/c
#p	Heure = ws[1, 4].to_f		# l/c
p   c_PM10 = ws[1, 6].to_f   # cellule ligne 1  / colonne 2
#p	NO2 = ws[1, 7].to_f		# l/c

	send_event('ap-val', { current: c_PM10, moreinfo: '' })
#	send_event('ap-fo', { current: NO2, moreinfo: '' })
	send_event('ap-circle', { value: c_PM10, min: 0, max: 150 , moreinfo: "cible : 10 encours max" })
	send_event('ap-bg', {	max: c_PM10,	value: c_PM10	})
end
