# !/usr/bin/ruby

require 'ruby2d'

set width: 648, height: 589, title: "River of Doubt Interactive Game"

Image.new('rod_cover.jpg')


# just to display static text on screen
=begin
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
=end

# Global variables -> changed to GameState class variables

class GameState
    @stage = 0
    @health = 100
    @morale = 100
    @hunger = 100
    @research = 0
    @current_objs = []
    @clickable_areas = []

    class << self
        attr_accessor :stage
        attr_accessor :health
        attr_accessor :morale
        attr_accessor :hunger
        attr_accessor :research
        attr_accessor :current_objs
        attr_accessor :clickable_areas
    end

    STAGES = {
        0 => {
            text: "THE RIVER OF DOUBT CYOA\nPress enter to start!"
            bg: 'rod_cover.jpg'
            options: [ {label: "Start Game", action: 'start'} ]
        },
        1 => {
            text: "STAGE 1: Prepping for the trip.\nYou have just lost the reelection and you want to get away.\nYour old friend Father Zahm has asked again about going on a trip to the Amazon rainforest. Thinking it will be a good way to run from the darkness, you accept.\nZahm is offering to make all the preparations himself.\nDo you help him or leave it up to him?"
            bg: 'loading_boat.jpg'
            options: [ 
                { label: "Help him pack.", action: 'help' },
                { label: "Let Zahm do the work.", action: 'no_help' }
            ]
        }

    }

    def self.update_display
        @current.objs.each(&:remove)
        @current.objs.clickable_areas
        @clickable_areas.clear

        data = STAGES[@stage]
        return unless data

        # background
        @current_objs << Image.new(data[:bg]) if data[:bg]

        # text
        @current_objs << Text.new(data[:text], x: 20, y: 20, size: 25, color: 'white', z = 10)

        # draw buttons (btn) and save boundaries
        if data[:options]
            data[:options].each_with_index do |opt, i|
                btn_x = 20
                btn_y = 350 + (i * 60)
                btn_width = 250
                btn_height = 45

                # rectangle for btn
                @current_objs << Rectangle.new(
                    x: btn_x, y: btn_y,
                    width: btn_width, height: btn_height,
                    color: 'blue', z: 10
                )

                # text to go in btn
                @current_objs << Text.new(
                    opt[:label],
                    x: btn_x + 15, y: btn_y + 10,
                    size: 20, color: 'white', z: 11
                )

                # boundaries so we can click with mouse
                @clickable_areas << {
                    x: btn_x, y: btn_y,
                    width: btn_width, height: btn_height,
                    action: opt[:action]
                }
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

on :mouse_down do |event|
    if event.button == :left
        # need wrapper to respond cleanly to mouse click
        GameState.handle_click(event.x, event.y)
    end
end


# ---------------------------------------------------------


# display game
show

