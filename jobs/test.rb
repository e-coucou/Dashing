require "rubygems"
require "roo"
require "google_drive"

current_valuation = 0
key = "0AsWa_wvrz5AndDBHVS1BbXU1MVJpVDE2VDk3akNJOWc"

SCHEDULER.every '2s' do
	# Logs in.
	# You can also use OAuth. See document of
	# GoogleDrive.login_with_oauth for details.
	
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
	reclamation_open = ws[22,2].to_f
	reclamation_target = ws[21,4].to_f
	progress_items = [{name: "OPex "+(valueGO/1000).to_s+"k€", progress: valueGO/value_max_O*100},{name: "CaPex "+(valueGC/1000).to_s+"k€", progress: valueGC/value_max_C*100}]

	send_event('valuation', { current: current_valuation, moreinfo: dateMAJ })
	send_event('fournisseur', { current: nb_fournisseur, moreinfo: "target maxi : "+nb_fournisseur_target.to_s })
	send_event('gainC', { value: reclamation_open, min: 0, max: 10 , moreinfo: "cible : 10 encours max" })
	send_event('active_claim', { current: reclamation_open, moreinfo: "cible : 10 encours max" })
	send_event('bargraph', {	max: reclamation_target,	value: reclamation	})
	send_event('progress_bars', {title: "Gains Achats", progress_items: progress_items } )
end
