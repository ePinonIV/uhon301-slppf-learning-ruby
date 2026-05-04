# !/usr/bin/ruby

require 'ruby2d'

set width: 1920, height: 1080, title: "River of Doubt Interactive Game"

#Image.new(File.join(__dir__, 'images', 'rod_cover2.jpg')

# Global variables -> changed to GameState class variables

class GameState
    @stage = 0
    @health = 100
    @morale = 100
    @hunger = 100
    @resources = 50
    @research = 0
    @pres_down = 0
    @current_objs = []
    @clickable_areas = []

    class << self
        attr_accessor :stage
        attr_accessor :next_target_stage
        attr_accessor :health
        attr_accessor :morale
        attr_accessor :hunger
        attr_accessor :resources
        attr_accessor :research
        attr_accessor :pres_down
        attr_accessor :current_objs
        attr_accessor :clickable_areas
    end

    STAGES = {
        0 => {
            text: "THE RIVER OF DOUBT INTERACTIVE ADVENTURE\nYou will be given the ability to make the choices of Teddy Roosevelt on his journey through the River of Doubt and see if you can get the canon outcome!\nYou will need to manage your resources and conditions carefully, as the jungle is unforgiving... Hunger will be lost every at every stage, health and morale can be lowered depending on your choices, and resources are limited (you can monitor them with the statuses in green below).\nGood luck!",
            bg: 'rod_cover2.jpg',
            options: [ 
                { label: "Start Game", action: 's0_start' },
                { label: "Quit", action: 'quit' }
            ]
        },
        1 => {
            text: "STAGE 1: The year is 1912 and Roosevelt has just lost the presidential election. His old friend Father Zahm has asked again about going on a trip to the Amazon rainforest. Thinking it will be a good way to run from the darkness, he accepts. Zahm is offering to make all the preparations himself. Should TR help him or let Zahm do all the packing?",
            bg: 'loading_boat2.jpg',
            options: [ 
                { label: "Help him pack", action: 's1_help' },
                { label: "Let Zahm do the work", action: 's1_no_help' }
            ]
        },
        2 => {
            text: "STAGE 2: Now deep in the jungle on the way to the River of Doubt, the terrain gets more and more rough to navigate. With the rushing water roaring, the group debates how to proceed, as it is taking longer than they thought to make it to the first landmark.\nShould they risk taking the canoes down the river or trudge on by foot?",
            bg: 'jungle2.jpg',
            options: [
                { label: "Ride the canoes down the river", action: 's2_canoe' },
                { label: "Walk beside the river by foot", action: 's2_walk' }
            ]
        },
        3 => {
            text: "STAGE 3: As the group is trying to settle down for the night, Rondon notices signs of the Cinta Large tribe nearby. This tribe having had little contact with the outside world could prove very dangerous if they find the group.\nShould they leave a peace offering or pack up and leave the area?",
            bg: 'tribe2.jpg',
            options: [
                { label: "Leave a peace offering", action: 's3_peace' },
                { label: "Hurry away quickly", action: 's3_leave' }
            ]
        },
        4 => {
            text: "STAGE 4: The waters were seeming calm, but out of nowhere a whirlpool formed, sending a couple canoes crashing into the rocks. Most of the men recovered, but Simplicio was swept away and is nowhere to be seen.\nAs he was a valuable member of the crew, should they stop and take the time to look for him? Or cut their losses and move on?",
            bg: 'whirlpool2.jpg',
            options: [
                { label: "Look for Simplicio", action: 's4_look' },
                { label: "Move on", action: 's4_move' }
            ]
        },
        5 => {
            text: "STAGE 5: The harsh climate is weakening everyone physically. Kermit, along with the rest of the group, have pretty bad cases of Malaria.\nUse resources to heal or try to let it pass?",
            bg: 'medicine2.jpg',
            options: [
                { label: "Use medicine", action: 's5_medicine' },
                { label: "Let it pass", action: 's5_pass' }
            ]
        },
        6 => {
            text: "STAGE 6: Now at the River of Doubt, Roosevelt and Rondon are in conflict on how to proceed. Roosevelt thinks the journey has been too treacherous and the people's safety is the priority, so they should keep moving. However Rondon wants to use this once in a lifetime opportunity to survey the river and get valuable information.\nShould they stop and survey the river or prioritize survival?",
            bg: 'conflict2.jpg',
            options: [
                { label: "SLow down and conduct research", action: 's6_research' },
                { label: "Keep the pace and prioritize survival", action: 's6_survival' }
            ]
        },
        7 => {
            text: "STAGE 7: In the last stretch of the adventure, Roosevelt's injured leg became very infected and he was in a bad state. Begging to just be left behind with a bottle of morphine as to not slow the group down, the decision has to be made...\nLet Roosevelt go or keep pushing on with him?",
            bg: 'stretcher.jpg',
            options: [
                { label: "Leave Roosevelt", action: 's7_leave' },
                { label: "Save Roosevelt", action: 's7_save' }
            ]
        },
        8 => {
            text: "STAGE 8: After a long and arduous journey, Roosevelt, Rondon and others made it out of the jungle alive! However, there are many people who are in disbelief about the journey, thinking Roosevelt just wanted attention and that he wouldn't have actually gone to uncharted territory.\nDid you conduct enough research to demonstrate to the critics?",
            bg: 'escaped_good.jpg',
            options: [
                { label: "Find out results...", action: 'endgame' }
            ]
        },
        -1 => {
            text: "Your injuries and weak physical state led to disease after disease, and the brutal rainforest's environment claims another vitcim...",
            bg: 'game_over.jpg',
            options: [
                { label: "Try Again", action: 'restart' },
                { label: "Quit", action: 'quit' } 
            ]
        },
        -2 => {
            text: "Morale collapsed and the group fell apart. It became every man for himself as everyone fought for what little resources were left. No one really knows what became of the members of the expedition...",
            bg: 'game_over.jpg',
            options: [
                { label: "Try Again", action: 'restart' },
                { label: "Quit", action: 'quit' } 
            ]
        },
        -3 => {
            text: "The terrain proved too rough and the group used up all thier rations, leaving them to starve out in the jungle...",
            bg: 'game_over.jpg',
            options: [
                { label: "Try Again", action: 'restart' },
                { label: "Quit", action: 'quit' } 
            ]
        },
        -4 => {
            text: "The group decided to honor Roosevelt's wishes and there his legacy ended, a fitting to his Strenuous Life...\nBut this story can't continue without him!",
            bg: 'game_over.jpg',
            options: [
                { label: "Try Again", action: 'restart' },
                { label: "Quit", action: 'quit' } 
            ]
        },
        10 => {
            text: "The group made it out alive! There are people who are in disbelief about your journey, as it sounds crazy on paper. However, since you were able to conduct some research and collect specimens, people can see the physical proof of your expedition!...\nAchievement: Canon Ending",
            bg: 'escaped_good.jpg',
            options: [
                { label: "Return to title", action: 'restart' },
                { label: "Quit", action: 'quit' } 
            ]
        },
        11 => {
            text: "You survived the trip, but brought back no proof. Unfortunatly this time, it was the critics who counted, and your legacy was that of an attention-seeking fraud.",
            bg: 'escaped_bad2.jpg',
            options: [
                { label: "Try Again", action: 'restart' },
                { label: "Quit", action: 'quit' } 
            ]
        }

    }
    
    # ok had to use AI to figure this one out, apparently wrapping text is not a simple thing to do...
    def self.wrap_text(text, max_width = 60)
        return [] if text.nil? || text.empty?
        
        lines = []
        
        # 1. First, split the text into distinct paragraphs wherever you typed \n
        text.split("\n").each do |paragraph|
            current_line = ""
            
            # 2. Then wrap each paragraph normally
            paragraph.split(' ').each do |word|
                if current_line.length + word.length + 1 > max_width
                    lines << current_line
                    current_line = word
                else
                    current_line += (current_line.empty? ? "" : " ") + word
                end
            end
            # Add the last line of the paragraph
            lines << current_line unless current_line.empty?
            
            # (Optional) Add a blank line to act as a spacer between paragraphs!
            lines << "" 
        end
        
        return lines
    end    

    # used AI to write the wrapper to be able to export images with the game file
    def self.get_image(filename)
        File.join(__dir__, 'images', filename)
    end

    def self.update_display
        data = STAGES[@stage]
        @current_objs.each(&:remove)
        @current_objs.clear
        @clickable_areas.clear

        if @stage == 99
            @current_objs << Image.new(get_image('transition_bg.jpg'))
            wrapped_lines = wrap_text(@transition_text, 50)
            start_y = 50
            wrapped_lines.each do |line|
                @current_objs << Text.new(line, x: 1100, y: start_y, size: 25, color: 'white', z: 10)
                start_y += 30
            end
            draw_button(1100, 400, "  Eat some rations (Hunger +10, Resources -10)", 'eat')
            draw_button(1100, 470, "  Use some medicine (Health +10, Resources -10)", 'heal')
            draw_button(1100, 540, "  Spend some time telling stories (Morale +10, Hunger -10)", 'socialize')
            draw_button(1100, 610, "  Spend time surveying the area (Research +10, Resources -10)", 'research')
            draw_button(1100, 680, "  → Continue adventure", 'endgame')

        else
            #data = STAGES[@stage]
            return unless data

            start_x = 1100
            start_y = 20 
        
            # background
            @current_objs << Image.new(get_image(data[:bg])) if data[:bg]

            # text
            wrapped_lines = wrap_text(data[:text], 60)
            wrapped_lines.each do |line|
                @current_objs << Text.new(line, x: start_x, y: start_y, size: 25, color: 'white', z: 10)
                start_y += 40
            end

            # draw buttons (btn) and save boundaries
            if data[:options]
                btn_start_y = start_y + 40

                data[:options].each_with_index do |opt, i|
                    btn_x = start_x
                    btn_y = btn_start_y + (i * 65)
                    btn_width = 800
                    btn_height = 50 

                    # rectangle for btn
                    @current_objs << Rectangle.new(
                        x: btn_x, y: btn_y,
                        width: btn_width, height: btn_height,
                        color: 'blue', z: 10
                    )

                    # text to go in btn
                    @current_objs << Text.new(
                        opt[:label],
                        x: btn_x + 15, y: btn_y + 12,
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
        hud_text = "Health: #{@health} | Morale: #{@morale} | Hunger: #{@hunger} | Resources: #{@resources} | Research: #{@research}"
        @current_objs << Text.new(hud_text, x: 1120, y: 1020, size: 22, color: 'lime', z: 10)
    end

    def self.next_stage
        @stage += 1
        update_display
    end

    def self.handle_choice(action)
        case action
        when 's0_start'
            @stage = 1
            update_display

        when 's1_help'
            @resources += 50
            show_transition("Father Zahm was packing luxurious goods that Roosevelt deemed unnecessary for a trip in the wilderness. By removing some of these, they were able to take more rations and medicine.\n\nResources +50", 2)
        when 's1_no_help'
            show_transition("Focusing on his more political matters, Roosevelt lets Zahm do all the packing. However, Zahm didn't know just how rough the trip would end up being, so he packed some luxurious, but useless items, that would later be discarded.", 2)

        when 's2_canoe'
            @morale -= 10
            @health -= 30
            @resources -= 10
            show_transition("The group takes the canoes down the rough waters, making good time. However, they do suffer some damage and lose a canoe along the way.\n\nMorale -10\nHealth -20\nResources -10", 3)
        when 's2_walk'
            @health -= 20
            @hunger -= 10
            @research += 20
            show_transition("The group decides to be safe and walk. The terrain is gruelling on foot, but they're able to procure some valuable specimens along the way.\n\nHealth -10\nHunger -20\nResearch +20", 3)
        
        when 's3_peace'
            @resources -= 20
            show_transition("The Cinta Larga tribe found the peace offering and took it as intended, leaving the group alone. It cost some rations but everyone is safe and sound.\n\nResources -20", 4)
        when 's3_leave'
            @health -= 20
            @morale -= 20
            show_transition("Uncoordinated and panicked, the group decides to hurriedly pack their stuff and move to a new area. With minor injuries, everyone is safe for now, but the weight of the danger still looms.\n\nHealth -20\nMorale -20", 4)

        when 's4_look'
            @morale += 30
            @hunger -= 20
            show_transition("Banding together to look for Simplicio took some time, but strengthened the bonds of the group. Although Simplicio was never found, everyone was reassured that the rest of the team had their back in an emergency.\n\nMorale +30\nHunger -20", 5)
        when 's4_move'
            @morale -= 60
            show_transition("Deciding it wasn't worth their time and resources, the group moved on. Shaken up by the loss of a good man and the willingness of the group to leave people behind took a toll on everyone's spirits.\nMorale -20", 5)
            
        when 's5_medicine'
            @resources -= 40
            show_transition("Thinking it best to recover fully, the group uses whatever medicine and rations they have to recover. After a little, everyone is recuperated and ready to keep moving.\nResources -40", 6)
        when 's5_pass'
            @health -= 50
            @hunger -= 20
            show_transition("In order to save resources, the group decides to tough out the illnesses. At the cost of their physical health, they are able to save thier resources.\n\nHealth -40\nHunger-20 ", 6)
        
        when 's6_research'
            @morale -= 10
            @hunger -= 10
            @research += 40
            show_transition("Settling their disagreement, Rondon and Roosevelt decide to stop for a while to conduct research They do some analysis of the river, take some astronomical data at night and inspect the wildlife in the jungle. They obtain valuable research at the cost of a couple days' time.\n\nMorale -10\nHunger -20\nResearch +40", 7)
        when 's6_survival'
            @morale -= 30
            show_transition("Roosevelt, worried about the wellbeing of the group, pushes to forsake the scientific research they originally sought to do in order to ensure their survival. Not wanting to upset the President too much, Rondon begrudgingly agrees and the group moves on.\nMorale -20", 7)
        
        when 's7_leave'
            @pres_down = 1
            show_transition("", -4)
        when 's7_save'
            @morale += 40
            @resources -= 20
            show_transition("Kermit and the others encourage Roosevelt to keep fighting to stay alive. They are willing to come together to care for him for the rest of the journey, knowing they can't leave the President behind.\n\nMorale +40\nResources -20", 8)

        when 'eat'
            if @hunger < 100 && @resources > 0
                @hunger += 10
                @resources -= 10
            end

        when 'heal'
            if @health < 100 && @resources > 0
                @health += 10
                @resources -= 20
            end

        when 'socialize'
            if @resources > 0
                @morale += 20
                @hunger -= 10
                @resources -= 10
            end

        when 'research'
            @hunger -= 10
            @research += 10

        when 'endgame'
            if @next_target_stage == 8
                @stage = (@research >= 60) ? 10: 11
            else
                @stage = @next_target_stage
            end
            update_display

        when 'restart'
            @stage = 0
            @health = 100
            @morale = 100
            @hunger = 100
            @resources = 50
            @research = 0
            @pres_down = 0
            update_display

        when 'quit'
            exit
        end
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
        @hunger -= 10
        if @resources < 0
            @resources = 0
        end
        if @morale > 100
            @morale = 100
        end

        if @health <= 0
            @stage = -1
        elsif @morale <= 0
            @stage = -2
        elsif @hunger <= 0
            @stage = -3
        elsif @pres_down == 1
            @stage = -4
        else
            @transition_text = text
            @next_target_stage = target
            @stage = 99
        end
        update_display
    end

    def self.draw_button(x, y, label, action)
        @current_objs << Rectangle.new(x: x, y: y, width: 800, height: 45, color: 'blue', z: 10)
        @current_objs << Text.new(label, x: x, y: y + 10, size: 20, color: 'white', z: 11)
        @clickable_areas << {x: x, y: y, width: 800, height: 45, action: action}
    end

end

# ---------------------------------------------------------

myGame = GameState.new

GameState.update_display

on :mouse_down do |event|
    if event.button == :left
        GameState.handle_click(event.x, event.y)
    end
end

# ---------------------------------------------------------

# display game
show

