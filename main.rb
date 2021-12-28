#!/usr/bin/env ruby
$LOAD_PATH << File.dirname(__FILE__)
require 'Dice'

puts "================================"
puts "           GREED GAME           " 
puts "================================"

print "Enter number of players: "
number_of_players = gets.chomp.to_i

# Create an array to keep track of the score of players
score_of_players = Array.new(number_of_players, 0)

dice = Dice.new()
print dice.roll_a_dice()