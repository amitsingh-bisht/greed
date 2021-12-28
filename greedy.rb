#!/usr/bin/env ruby
# -*- ruby -*-

require "./dice"

puts "================================"
puts "           GREED GAME           " 
puts "================================"

print "Enter number of players: "
number_of_players = gets.chomp.to_i

# Create an array to keep track of the score of players
score_of_players = Array.new(number_of_players, 0)

b = Dice.new
puts b.roll_a_dice()