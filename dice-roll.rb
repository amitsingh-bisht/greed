class DiceRoll
    def roll_a_dice(number_of_dice_to_be_rolled)
        @dice_value = []                                    # initialize an empty array to store the face of dice
        number_of_dice_to_be_rolled.times do                # roll as many times as the number of dice available
            @dice_value << rand(5)+1                        # append it to the end of the array
        end 
        @dice_value                                         # return it
    end
end
