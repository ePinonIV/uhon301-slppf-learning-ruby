#!/usr/bin/ruby

# Simple terminal based game where the user must guess the word
# - functions similar to Wordle in that it returns which characters in the word were correct

# global game variables
hidden_word = "fleet"
not_guessed = true

# intro title
puts "\nWord Guessing Game\n-------------------"
puts ("The hidden word length is " + hidden_word.length.to_s + "\n")

# main loop of game
while not_guessed
    puts "Enter guess:\n"
    guess = gets.chomp()

    # compare guess to hidden word
    if guess == hidden_word
        not_guessed = false    # guess is correct

    elsif guess.length != hidden_word.length     # guess invalid
        puts ("\n>> Your guess doesn't match the length of the hidden word (" + hidden_word.length.to_s + "), guess again!")

    else # guess valid, not correct

        common_chars = guess.chars & hidden_word.chars

        # loop through guess and assemble response to guess
        output = ""
        for i in 0..guess.length
            if guess[i] == hidden_word[i]
                output += guess[i].to_s + " "
            else
                output += "_ "
            end
            i += 0
        end

        # get how many letters in common and report status
        if common_chars.length == 0
            puts "\n>> Nope, guess again!"
        else 
            puts ("\n>> You have " + common_chars.length.to_s + " letters correct")
            puts ("The letters you have correct are: " + common_chars.to_s)
        end

        puts output

    end

end

# out of while loop means word was guessed
puts ("Success! The hidden word was " + hidden_word + "\n-------------------")#!/usr/bin/ruby