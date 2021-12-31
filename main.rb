#!/usr/bin/env ruby
# -*- ruby -*-

require 'rspec'
require "./greedy"
require "./dice-roll"
require "./dice-score"

require 'test/unit/assertions'
include Test::Unit::Assertions

puts ""
puts "================================================================"
puts "                           GREED GAME                           " 
puts "================================================================"

describe GreedyGame do

    number_of_players= 0
    game = GreedyGame.new
    dice_score_object = DiceScore.new   

    context "when user enters number of players" do
        it "should return the number of players" do
            number_of_players = game.get_number_of_players()
        end
    end

    context "initialize a hash to keep a track of score of each player" do
        it "should return an empty hash with initial value as 0" do
            game.initialize_score(number_of_players)
        end
    end

    context "continue the game until its not the last round" do
        it "should return the player which has the highest score" do
            game.play_until_last_round(number_of_players)
        end
    end

    context "example to check if score class is returning proper value" do
        it "should return 1000" do
            score, dice_values = dice_score_object.score_on_roll([1,1,1,2,2])
            assert_equal 1000, score
        end
    end
end
