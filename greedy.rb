#!/usr/bin/env ruby
# -*- ruby -*-

require "./dice"

puts ""
puts "================================================================"
puts "                           GREED GAME                           " 
puts "================================================================"

print "\nEnter number of players: "
number_of_players = gets.chomp.to_i

# Create an array to keep track of the score of players
score_of_players = Hash.new()
number_of_players.times do |i|
    score_of_players[i] = 0
end

is_score_greater_than_3000 = false
is_round_completed = false
current_round = 1
rounds_to_reach_3000 = -1

dice_object = Dice.new

until is_round_completed
    puts ""
    puts "----------------------------------------------------------------"
    puts "                              Turn #{current_round}"
    puts "----------------------------------------------------------------"
    current_player = 0
    number_of_players.times do
        score_accumulated_for_this_round = 0
        dice_count = 5
        go_for_next_roll = "y"
        while go_for_next_roll == "y"
            dice_values = dice_object.roll_a_dice(dice_count)
            print "\nPlayer #{current_player + 1} rolls : #{dice_values} \n"
            score, scoring_dice, dice_values = dice_object.score_on_roll(dice_values)
            print "  Score in this roll : #{score}\n"
            if score == 0
                print "  Score in this round : "
                print (score_accumulated_for_this_round > 0) ? 
                    "0 (Ah ! High Risk High Reward sometimes may backfire. You lost all your points for this round)\n" : "0\n"
                score_accumulated_for_this_round = 0
                go_for_next_roll = "n"
            else
                dice_count = dice_values.size
                score_accumulated_for_this_round += score
                print "  Score in this round : #{score_accumulated_for_this_round}"
                print (score_of_players[current_player] == 0 and score_accumulated_for_this_round < 300) ? 
                    " (Minimum score required: 300. You still need #{300 - score_accumulated_for_this_round} score to add this turn score to your total score)\n" : "\n"
                print "  Non-Scoring Dice : #{dice_values}\n"
                if dice_count > 0
                    print "  Do you want to roll the non-scoring #{dice_count} dice? (y/n): " 
                    go_for_next_roll = (gets.chomp.to_s.downcase)[0]
                else
                    go_for_next_roll = "n"
                end
            end 
        end
        (score_of_players[current_player] == 0 and score_accumulated_for_this_round < 300) ? 
            0 : score_of_players[current_player] += score_accumulated_for_this_round
        current_player += 1
    end
    puts "\n\nScore after Turn #{current_round} : "
    score_of_players.each do |key, value|
        puts "  Player #{key+1} : #{value}"
    end
    puts "\n"
    is_round_completed = true if is_score_greater_than_3000 && current_round > rounds_to_reach_3000
    is_score_greater_than_3000, rounds_to_reach_3000 = true, current_round if score_of_players.values.max >= 3000
    puts "Player #{score_of_players.key(score_of_players.values.max) + 1} has reached 3000 (or more points). The next round is the final round and the player with the highest score wins !!! \n" if is_score_greater_than_3000 && !is_round_completed
    puts "Hurray !!! Player #{score_of_players.key(score_of_players.values.max) + 1} has won !!! \n\n" if is_score_greater_than_3000 && is_round_completed
    current_round += 1
end