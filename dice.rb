Class Dice
    def roll_a_dice
        dice = []
        5.times { 
            dice << rand(5) * 1
        }
        dice
    end
end