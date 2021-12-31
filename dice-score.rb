class DiceScore
    def score_on_roll(dice)
        dice.sort!                                                      # sort the element of dice in ascending order
        return 0 if dice.nil? or dice.empty?                            # return 0 if dice is nil or empty
        element_to_be_deleted_from_index = []
        sum = 0                                                         # initialize sum variable to be equal to 0
        counter = 0                                                     # initialize counter variable to be equal to 0, we will be using counter variable to keep a track of the index
        for i in 0...dice.size
            score = 0
            if i == counter                                             # initially i and counter both are 0
                if dice[counter] == 1 && dice[counter+1] == 1 && dice[counter+2] == 1
                    score = 1000                                        # if there are three consecutive 1s then the player gets 1000 points
                    element_to_be_deleted_from_index << counter         # add counter to the array (element_to_be_deleted_from_index)
                    element_to_be_deleted_from_index << counter+1       # add counter + 1 to the array (element_to_be_deleted_from_index)
                    element_to_be_deleted_from_index << counter+2       # add counter + 2 to the array (element_to_be_deleted_from_index)
                    counter += 3                                        # also counter is incremented by 3
                elsif dice[counter] == dice[counter+1] && dice[counter] == dice[counter+2]
                    score = 100 * dice[counter]                         # if there are three consecutive same numbers then the player gets 100 times the number points
                    element_to_be_deleted_from_index << counter         # add counter to the array (element_to_be_deleted_from_index)
                    element_to_be_deleted_from_index << counter+1       # add counter + 1 to the array (element_to_be_deleted_from_index)
                    element_to_be_deleted_from_index << counter+2       # add counter + 2 to the array (element_to_be_deleted_from_index)
                    counter += 3                                        # also counter is incremented by 3
                elsif dice[counter] == 1   
                    score = 100                                         # if the number on dice appears to be 1, give a score of 100
                    element_to_be_deleted_from_index << counter         # add counter to the array (element_to_be_deleted_from_index)
                    counter += 1                                        # also counter is incremented by 1
                elsif dice[counter] == 5  
                    score = 50                                          # if the number on dice appears to be 5, give a score of 50
                    element_to_be_deleted_from_index << counter         # add counter to the array (element_to_be_deleted_from_index)
                    counter += 1                                        # also counter is incremented by 1
                else
                    counter += 1                                        # also counter is incremented by 1
                end
            end
            sum += score                                                # add the score to the previous sum
        end
        element_to_be_deleted_from_index.reverse!                       # reverse the array so that element from last index is removed first
        element_to_be_deleted_from_index.each do |element_at_index|
            dice.delete_at(element_at_index)                            # delete the element from respective index
        end
        [sum, dice]                                                     # return sum and dice(new) as an array
    end
end
