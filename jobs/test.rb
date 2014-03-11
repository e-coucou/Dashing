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

    current_valuation = ws[16, 2].to_f   # cellule ligne 1  / colonne 2
	last_valuation = ws[16, 3].to_f		# l/c
	valueGO = ws[12, 2].to_f
	valueGC = ws[11, 2].to_f
	value_min = 0
	value_max_O = ws[12, 4].to_f
	value_max_C = ws[11, 4].to_f
	dateMAJ = ws[10,2]
	
	# information sur fournisseurs
	nb_fournisseur = ws[14,2].to_f
	nb_fournisseur_target = ws[14,4].to_f

	# information sur fournisseurs
	reclamation = ws[21,2].to_f
	reclamation_target = ws[21,4].to_f
	progress_items = {name: "OPex", progress: 24},{name: "CaPex", progress: 34}

	send_event('valuation', { current: current_valuation, last: last_valuation, moreinfo: dateMAJ })
	send_event('fournisseur', { current: nb_fournisseur, last: nb_fournisseur_target })
	send_event('gainO', { value: valueGO, min: value_min, max: value_max_O , moreinfo: "cible : " })
	send_event('gainC', { value: valueGC, min: value_min, max: value_max_C })
	send_event('bargraph', {	max: reclamation_target,	value: reclamation	})
	send_event('progress_bars', {title: "Opex", progress_items: [] } )
end
