require "rubygems"
require "roo"
require "google_drive"

key = "0AkmmwnTmClhodDBHa2xJSDBtTE5LVF9UYktmOUZTeGc"

points = []
(1..10).each do |i|
  points << { x: i, y: 0 }
end
last_x = points.last[:x]

SCHEDULER.every '2s' do
	# Logs in.	
	session = GoogleDrive.login("automate@e-coucou.com", "Penelope75!")
	ws = session.spreadsheet_by_key(key).worksheets[1]

	# les infos from spreadsheet
	lieu = ws[1, 2]   # cellule ligne 1  / colonne 2
  	date = ws[1, 3]		# l/c
	heure = ws[1, 4]		# l/c
	c_PM10 = ws[1, 6].to_f   # cellule ligne 1  / colonne 2
	c_NO2 = ws[1, 7].to_f		# l/c
	
	# animation du graphique trend
	points.shift
	last_x += 1
	points << { x: last_x, y: c_PM10 }

	send_event('histoPM10', points: points)

#	send_event('ap-val', { current: c_PM10, moreinfo: date+" "+heure })
	send_event('ap-fo', { title: lieu+"   Maj "+date+" "+heure, moreinfo: 'BASCH' })
	send_event('ap-circle', { value: c_PM10, min: 0, max: 150, moreinfo: "max : 150", title: "Particules PM10" })
	send_event('ap-bg', {	max: 100,	value: c_NO2, title: "Dioxyde d'Azote"	})
end
