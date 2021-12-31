#!/usr/bin/env ruby
# -*- ruby -*-

require "./dice-roll" 
require "./dice-score"

class GreedyGame

    $score_of_players = Hash.new()          # Create an array to keep track of the score of players    

    $dice_roll_object = DiceRoll.new 
    $dice_score_object = DiceScore.new   

    def get_number_of_players()
        number_of_players = 2                  # i am not able to take input from user, if you can help me.
        # until number_of_players > 1
        #     print "\nEnter number of players (Player count needs to be 2 or more): "
        #     number_of_players = gets.chomp().to_i
        # end
        number_of_players
    end

    def initialize_score(number_of_players)
        number_of_players.times do |i|
            $score_of_players[i] = 0        # initialize hash with number of players as key and value as 0
        end
    end

    def play_until_last_round(number_of_players)
        $current_round = 1                      # current_round will keep a track of rounds and display it on our console screen
        is_round_completed = false             # if anyone is reached, then the next round will be the last round
        is_score_greater_than_3000 = false     # flag to check if any player has reached the benchmark of 3000 points
        rounds_to_reach_3000 = -1
        until is_round_completed
            puts_current_round()
            @current_player = 0                 # every new round begins with player 1
            play_until_last_player(number_of_players)
            puts "\n\nScore after Turn #{$current_round} : "
            $score_of_players.each do |key, value|
                puts "  Player #{key+1} : #{value}"
            end
            puts "\n"
            is_round_completed = true if is_score_greater_than_3000 && $current_round > rounds_to_reach_3000                                                                 # set the flag is_round_completed to true if the score is greater than 3000 and current_round (last round)> rounds_to_reach_3000(which we had set in previous step => last round - 1)
            is_score_greater_than_3000, rounds_to_reach_3000 = true, $current_round if $score_of_players.values.max >= 3000                                                   # see if any player has reached the benchmark score of 3000 or not and rounds_to_reach_3000 as current_round (last round - 1)
            puts "Player #{$score_of_players.key($score_of_players.values.max) + 1} has reached 3000 (or more points). The next round is the final round and the player with the highest score wins !!! \n" if is_score_greater_than_3000 && !is_round_completed
            puts "Hurray !!! Player #{$score_of_players.key($score_of_players.values.max) + 1} has won !!! \n\n" if is_score_greater_than_3000 && is_round_completed
            $current_round += 1
        end
    end

    def puts_current_round()
        puts ""
        puts "----------------------------------------------------------------"
        puts "                              Turn #{$current_round}"
        puts "----------------------------------------------------------------"
    end

    def play_until_last_player(number_of_players)
        number_of_players.times do 
            @score_accumulated_for_this_round = 0                                                                                                                        # score_accumulated_for_this_round will keep a track of score for that particular round/turn
            @dice_count = 5                                                                                                                                              # initially all the 5 dices are to be rolled
            @go_for_next_roll = "y"                                                                                                                                      # go_for_next_roll will ask the player if they want to roll further or stop their turn. Initially kept as "y (yes)"
            @all_5_dice_rolled_in_first_attempt = true
            play_until_last_roll()
            ($score_of_players[@current_player] == 0 and @score_accumulated_for_this_round < 300) ?                                                                        # if a player gets 300 or more points then add it to their previous score or else no score is awarded
                0 : $score_of_players[@current_player] += @score_accumulated_for_this_round
            @current_player += 1  
        end
    end

    def play_until_last_roll()
        while @go_for_next_roll == "y"                                                                                                                               # condition to check if player wants to continue further or not
            @dice_values = $dice_roll_object.roll_a_dice(@dice_count)                                                                                                  # calls roll_a_dice method that returns an array
            print "\nPlayer #{@current_player + 1} rolls : #{@dice_values} \n"
            @score, @dice_values = $dice_score_object.score_on_roll(@dice_values)                                                                                       # pass the same array as a parameter to score_on_roll method that returns 2 value - score generated from that dice, and new dice which consists of elements that didn't score
            print "  Score in this roll : #{@score}\n" 
            check_my_score()   
        end 
    end

    def check_my_score()
        if @score == 0                                                                                                                                           # if no score is generated, then player loses its turn and also the score generated from that turn also gets lost
            print "  Score in this round : "
            print (@score_accumulated_for_this_round > 0) ? 
                "0 (Ah ! High Risk High Reward sometimes may backfire. You lost all your points for this round)\n" : "0\n"
            @score_accumulated_for_this_round = 0                                                                                                                # set @score_accumulated_for_this_round = 0, as player just lost
            @go_for_next_roll = "n"                                                                                                                              # player should not roll again for that turn
        else
            @dice_count = @dice_values.size                                                                                                                       # check the size of new array to find how many dice have scored points
            @score_accumulated_for_this_round += @score                                                                                                           # add the score to @score_accumulated_for_this_round variable
            print "  Score in this round : #{@score_accumulated_for_this_round}"
            print ($score_of_players[@current_player] == 0 and @score_accumulated_for_this_round < 300) ?                                                          # Before a player is allowed to accumulate points, they must get atleast 300 points in a single turn. Once they have achieved 300 points
                " (Minimum score: 300. You still need #{300 - @score_accumulated_for_this_round} score to add this turn score to your total score)\n" : "\n"     # in a single turn, the points earned in that turn and each following turn will be counted toward their total score
            print "  Non-Scoring Dice : #{@dice_values}\n"
            if @dice_count > 0                                                                                                                                   # check if @ is > 0, means not all dice have scored points
                all_5_dice_rolled_in_first_attempt = false                                                                                                      # hence set the flag all_5_dice_rolled_in_first_attempt to false
                print "  Do you want to roll the non-scoring #{@dice_count} dice? (y/n): " 
                @go_for_next_roll = "n"#(gets.chomp.to_s.downcase)[0]                                                                                                # gets player input if they further want to roll the dice, if "y" follow same procedure again or else go to next player
            elsif @dice_count == 0 and all_5_dice_rolled_in_first_attempt                                                                                        # if all dices have scored points 
                print "  Tremendous ! All In. You have scored points on all 5 dice. Extra roll is provided to you. "
                @dice_count = 5                                                                                                                                  # then player should get a chance to roll all 5 dice again as a reward 
                @go_for_next_roll = "y"
            else
                @go_for_next_roll = "n"                                                                                                                          # if player enters "n", pass the game to the next player
            end
        end 
    end

end
