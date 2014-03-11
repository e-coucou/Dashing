require "rubygems"
require "roo"
require "google_drive"

key = "0AsWa_wvrz5AndDBHVS1BbXU1MVJpVDE2VDk3akNJOWc"
	
buzzwords = ['Action', 'Pivoting', 'Turn-key', 'Streamlininess', 'Enterprise', 'Web 2.0'] 
buzzword_counts = Hash.new({ value: 0 })

SCHEDULER.every '2s' do
  session = GoogleDrive.login("automate@e-coucou.com", "Penelope75!")
  ws = session.spreadsheet_by_key(key).worksheets[0]

  random_buzzword = buzzwords.sample
  buzzword_counts[random_buzzword] = { label: random_buzzword, value: (buzzword_counts[random_buzzword][:value] + 1) % 30 }
  
  send_event('buzzwords', { items: buzzword_counts.values })
end