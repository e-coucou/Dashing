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
p	current = ws[3, 2].to_f # 3:B
p	last    = ws[3, 3].to_f # 3:C
p	moreinfo = ws[3, 5].to_s # 3:E
p	new_title = ws[3, 4].to_s # 3:D
p	suffix = ws[3, 6].to_s # 3:F
	

#  last_valuation = current_valuation
  last_karma     = current_karma
  current_karma     = rand(200000)

  send_event('e-CNumber', { current: current, last: last, moreinfo: moreinfo, title: new_title, suffix: suffix })
#  send_event('karma', { current: current_karma, last: last_karma })
  send_event('synergy',   { value: rand(100) })
end