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
	
	session = GoogleDrive.login("eric@plaidy.net", "Ricky03!")
#	ws = session.spreadsheet_by_key("0AkHkekTTsBL0dGJ5Ty14YjRud2VBbHhDMXd2UGZPVlE").worksheets[0]
	ws = session.spreadsheet_by_key(key).worksheets[0]

    current_valuation = ws[3, 5].to_f   # cellule ligne 1  / colonne 2
	last_valuation = ws[2, 5].to_f		# l/c
	value = ws[3, 18].to_f
	value_min = 0
	value_max = ws[2, 18].to_f
	
	# information sur fournisseurs
	nb_fournisseur = ws[3,14].to_f
	nb_fournisseur_target = ws[2,14].to_f

	send_event('valuation', { current: current_valuation, last: last_valuation })
	send_event('fournisseur', { current: nb_fournisseur, last: nb_fournisseur_target })
	send_event('gain', { value: value, min: value_min, max: value_max })
end
