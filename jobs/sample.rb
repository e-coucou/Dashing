require "rubygems"
require "roo"
require "google_drive"

#current_valuation = 0
key = "0AkmmwnTmClhodDBHa2xJSDBtTE5LVF9UYktmOUZTeGc"
current_karma = 0

SCHEDULER.every '5s' do
	# open session to google
	session = GoogleDrive.login("automate@e-coucou.com", "Penelope75!")
	ws = session.spreadsheet_by_key(key).worksheets[0]
	# get data from google spreadsheet [row, col]
	current = ws[3, 2].to_f # 3:B
	last    = ws[3, 3].to_f # 3:C
	moreinfo = ws[3, 5].to_s # 3:E
	new_title = ws[3, 4].to_s # 3:D
	suffix = ws[3, 6].to_s # 3:F
	# -----
	g_value = ws[4, 2].to_f # 4:B
	g_max    = ws[4, 3].to_f # 4:C
	g_moreinfo = ws[4, 5].to_s # 4:E
	g_new_title = ws[4, 4].to_s # 4:D
	g_suffix = ws[4, 6].to_s # 4:F

	send_event('e-CNumber', { current: current, last: last, moreinfo: moreinfo, title: new_title, suffix: suffix })
	send_event('synergy',   { value: rand(100) })
	send_event('e-CUsageGauge', {	max: g_max,	value: g_value, title: g_new_title, moreinfo: g_moreinfo	})

end