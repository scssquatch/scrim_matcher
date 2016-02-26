require 'unirest'
require 'pry-nav'
require_relative 'partition'

@system = ARGV[0]
@elos = []

def get_membership_id(gamertag)
  response = Unirest.get("http://proxy.guardian.gg/Platform/Destiny/SearchDestinyPlayer/#{@system}/#{gamertag}/")
  response.body["Response"][0]["membershipId"]
end

gamertags = ARGV[1..-1]

gamertags.each do |gamertag|
  response = Unirest.get "http://api.guardian.gg/elo/#{get_membership_id(gamertag)}"
  @elos << { gamertag: gamertag, elo: response.body.find { |a| a["mode"] == 9 }["elo"].to_i }
end

teams = simple_partition(@elos, 'elo')

team_1 = teams[0].map { |player| player[:gamertag] }
team_2 = teams[1].map { |player| player[:gamertag] }

puts "Team 1: #{team_1.join(', ')}"
puts "Team 2: #{team_2.join(', ')}"
