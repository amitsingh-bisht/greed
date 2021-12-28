class DiceRoll
    def roll_a_dice(number_of_dice_to_be_rolled)
        @dice_value = []
        number_of_dice_to_be_rolled.times do 
            @dice_value << rand(5)+1
        end
        @dice_value
    end
end