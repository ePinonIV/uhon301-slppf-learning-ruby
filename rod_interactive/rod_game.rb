# !/usr/bin/ruby

require 'ruby2d'

set width: 648, height: 589, title: "River of Doubt Interactive Game"

Image.new('rod_cover.jpg')


# just to display static text on screen
Text.new(
    'Press enter',
    x: 10,
    y: 10,
    size: 30,
    color: 'black',
)
Text.new(
    'to start!',
    x: 10,
    y: 35,
    size: 30,
    color: 'black',
)



# Global variables -> changed to GameState class variables

class GameState
    @stage = 0
    @health = 100
    @morale = 100
    @hunger = 1
    @research = 0

    class << self
        attr_accessor :stage
        attr_accessor :health
        attr_accessor :morale
        attr_accessor :hunger
        attr_accessor :research
    end

    def change_stage 
        if self.class.health <= 0
            self.class.stage = -1
        elsif self.class.morale <= 0
            self.class.stage = -2
        elsif self.class.hunger <= 0
            self.class.stage = -3
        else
            self.class.stage += 1
        end
    end

    def display_state
        if self.class.stage == 0
            puts "placeholder"
        elsif self.class.stage == 1
            Image.new('loading_boat.jpg')
        end
    end

end



# ---------------------------------------------------------


=begin
General structure of code:
- set up all variables/classes/etc.
- set up game states with each stage's text and options
- have on event that checks if mouse clicked on certain button (in while loop?)
    - then based on current game state & button clicked, do certain action
    - update statuses as needed
=end
myGame = GameState.new

on :key_down do |event|
    if event.key == 'return'
        myGame.change_stage
        myGame.display_state

    end
end

# ---------------------------------------------------------


# display game
show

