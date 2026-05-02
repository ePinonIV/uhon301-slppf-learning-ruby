# !/usr/bin/ruby

require 'ruby2d'

set width: 580, height: 580, title: "River of Doubt Interactive Game"

Image.new('rod_cover.jpg')


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
        attr_accessor :next_target_stage
        attr_accessor :health
        attr_accessor :morale
        attr_accessor :hunger
        attr_accessor :research
        attr_accessor :current_objs
        attr_accessor :clickable_areas
    end

    STAGES = {
        0 => {
            text: "THE RIVER OF DOUBT CYOA\nPress enter to start!",
            bg: 'rod_cover.jpg',
            options: [ {label: "Start Game", action: 'start'} ]
        },
        1 => {
            text: "STAGE 1: Prepping for the trip.\nYou have just lost the reelection and you want to get away.\nYour old friend Father Zahm has asked again about going on a trip to the Amazon rainforest. Thinking it will be a good way to run from the darkness, you accept.\nZahm is offering to make all the preparations himself.\nDo you help him or leave it up to him?",
            bg: 'loading_boat.jpg',
            options: [ 
                { label: "Help him pack.", action: 'help' },
                { label: "Let Zahm do the work.", action: 'no_help' }
            ]
        }
        2 => {
            text: "STAGE 2: In the Jungle.\nAs the rushing water roars next to you, your group debates how to proceed, as it is taking longer than you thought to make it to your first landmark.",
            bg: 'jungle_1.jpg',
            options: [
                { label: "Ride the canoes down the river.", action: 'canoe' },
                { label: "Walk beside the river by foot.", action: 'walk' }
            ]
        }
        3 => {
            text: "STAGE 3: Cinta Larga Tribe Encounter.",
            bg: 'tribe.jpg',
            options: [
                { label: "Leave a peace offering.", action: 'peace' },
                { label: "Try to fight them.", action: 'fight' },
                { label: "Hurry away.", action: 'leave' }
            ]
        }

    }

    def self.update_display
        @current_objs.each(&:remove)
        @current_objs.clear
        @clickable_areas.clear

        if @stage == 99
            @current_objs << Image.new('transition_bg.png')     # NEED to add
            wrapped_text = wrap_text(@transition_text, 45)
            @current_objs << Text.new(wrapped_text, x: 40, y: 50, size: 22, color: 'white', z: 10)

            draw_button(450, "Continue Adventure", 'finish_transition')

        else
            data = STAGES[@stage]
            return unless data

            # background
            @current_objs << Image.new(data[:bg]) if data[:bg]

            # text
            @current_objs << Text.new(data[:text], x: 20, y: 20, size: 25, color: 'white', z: 10)

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

        # still in fn
        # put hud w/resources info
        hud_text = "Health: #{@health} | Morale: #{@morale} | Hunger: #{@hunger} | Research: #{@reseach}"
        @current_objs << Text.new(hud_text, x: 20, y: 550, size: 15, color: 'lime', z: 10)
    end

    def self.next_stage
        @stage += 1
        update_display
    end

    def self.handle_choice(action)
        if @stage == 0 && action == 'start'
            next_stage
        elsif @stage == 1
            if action == 'help'
                @hunger -= 40
                puts "Helped Father Zahm pack and brought more practical food resources"
            elsif action == 'no_help'
                puts "Let Father Zahm do all the work... he didn't know what he was getting himself into"
            end
            next_stage
        end
        ######
    end
            
    def self.handle_click(mouse_x, mouse_y)
        @clickable_areas.each do |area|
            # check if mouse is w/in rectangle's bounds
            if mouse_x >= area[:x] && mouse_x <= (area[:x] + area[:width]) &&
                mouse_y >= area[:y] && mouse_y <= (area[:y] + area[:height])

                handle_choice(area[:action])
                break
            end
        end
    end

    def self.show_transition(text, target)
        @transition_text = text
        @next_target_stage = target
        @stage = 99
        update_display
    end

    def self.draw_button(y, label, action)
        btn_x = 20
        @current_objs << Rectangle.new(x: btn_x, y: y, width: 300, height: 45, color: 'blue', z: 10)
        @current_objs << Text.new(label, x: btn_x, y: y + 10, size: 20, color: 'white', z: 11)
        @clickable_areas << {x: btn_x, y: y, width: 300, height: 45, action: action}
    end

    # ok had to use AI to figure this one out, apparently word wrapping is not human readable code...
    def self.wrap_text(text, max_width = 50)
        text.gsub(/(.{1,#{max_width}})(\s+|\Z)/, "\\1\n")
end

end

#GameState.update_display



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

#myGame.update_display

GameState.update_display

=begin
on :key_down do |event|
    if event.key == 'return'
        myGame.change_stage
        myGame.display_state

    end
end
=end

on :mouse_down do |event|
    if event.button == :left
        # need wrapper to respond cleanly to mouse click
        GameState.handle_click(event.x, event.y)
    end
end


# ---------------------------------------------------------


# display game
show

