`rm ../oracle_files/data.sql`
`rm teams.txt`

`ruby league_data.rb`

`ruby team_data.rb http://www.espnfc.us/spanish-primera-division/15/table`
`ruby team_data.rb http://www.espnfc.us/english-premier-league/23/table`

File.foreach('teams.txt').with_index do |line, line_num|
   puts "ruby player_data.rb #{line.chomp.gsub('index', 'squad')} #{line_num};"
  `ruby player_data.rb #{line.chomp.gsub('index', 'squad')} #{line_num};`
end

`ruby tournament.rb`
`ruby game.rb`
