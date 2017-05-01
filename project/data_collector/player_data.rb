#script to collect required stats on Player information only
#created by: Mitch Stark 2/26/17

require 'rubygems'
require 'nokogiri'
require 'open-uri'

search = ['td.pla', 'td.age', 'td.starts', 'td.subIns', 'td.totalGoals', 'td.totalShots', 'td.shotsOnTarget', 'td.goalAssists', 'td.foulsCommitted', 'td.foulsSuffered', 'td.yellowCards', 'td.redCards', 'td.pos', 'td.no']

site = ARGV[0]
teamId = ARGV[1]

page = Nokogiri::HTML(open(site))
columns = page.css('tbody')

players = columns.children
count = 0
players.each do |player|
  if player.css('td.pla').text.strip != ''
    player_info = Hash.new
    search.each do |find|
      player_info[find] = player.css(find).text.strip
    end
    #write player info to update_info.sql
  #write player info to update_info.sql
  output =  "insert into player values ('#{player_info['td.pla'].gsub("'", "''")}', '#{player_info['td.pos']}', #{player_info['td.no']}, #{player_info['td.age']}, #{player_info['td.starts']}, #{player_info['td.subIns']}, #{player_info['td.totalGoals']}, #{player_info['td.shotsOnTarget']}, #{player_info['td.goalAssists']}, #{player_info['td.foulsSuffered']}, #{player_info['td.foulsCommitted']}, #{teamId});"
  output = output.gsub(', ,', ', null,').gsub('--', 'null').gsub(', ,', ', null,')
  count += 1
  open('../oracle_files/data.sql', 'a') { |f| f.puts output }
  end
end

open('../oracle_files/data.sql', 'a',) { |f| f.puts "\n\n\n" }
