#script to collect required stats on Team information only
#created by: Mitch Stark 2/26/17

require 'rubygems'
require 'nokogiri'
require 'open-uri'

search = ['td.pla', 'td.age', 'td.starts', 'td.subIns', 'td.totalGoals', 'td.totalShots', 'td.shotsOnTarget', 'td.goalAssists', 'td.foulsCommitted', 'td.foulsSuffered', 'td.yellowCards', 'td.redCards', 'td.pos', 'td.no']

site = ARGV[0]
page = Nokogiri::HTML(open(site))
columns = page.css('tbody')

teams = columns.children
TEAM_COUNT = `cat teams.txt | wc -l`
TEAM_COUNT = TEAM_COUNT.to_i
count = TEAM_COUNT
teams.each do |team|
  wins = -1
  ties = -1
  losses = -1
  if team.css('td.pos').text.strip != ''
    record = team.css('td.groupA')
    rc = 0
    record.each do |r| 
      if rc == 1
        #wins
        wins = r.text.strip
      elsif rc == 2
        #draws
        ties = r.text.strip
      elsif rc == 3
        #losses
        losses = r.text.strip
      end
      rc += 1
    end
    name = team.css('td.team a').text.strip
    if name != ''
      team_data = "insert into team values (#{count}, '#{name}', #{wins}, #{losses}, #{ties});"
      open('../oracle_files/data.sql', 'a') { |f| f.puts team_data }
      count += 1
    end
  end
end

open('../oracle_files/data.sql', 'a',) { |f| f.puts "\n\n\n" }

count = TEAM_COUNT
teams.each do |team|
  if team.css('td.pos').text.strip != ''
    league_id = 1
    if site.include?("spanish")
      league_id = 0
    end
    begin
      open('teams.txt', 'a') { |f| f.puts team.css('td.team a').attribute('href').to_s}
      team_standing = "insert into league_standing values (#{count}, #{league_id}, #{team.css('td.pos').text.strip});"
      open('../oracle_files/data.sql', 'a') { |f| f.puts team_standing }
      count += 1
    rescue
      puts "error"
    end
  end
end

open('../oracle_files/data.sql', 'a',) { |f| f.puts "\n\n\n" }
