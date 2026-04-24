# !/usr/bin/ruby

require 'ruby2d'

set width: 648, height: 589, title: "River of Doubt Interactive Game"

Image.new('rod_cover.jpg')


# just to display static text on screen
Text.new(
    'Click anywhere',
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


# Global variables
GameState = 0       # sets stage of game 
Health = 100
Morale = 100
Hunger = 0


# ---------------------------------------------------------


=begin
General structure of code:
- set up all variables/classes/etc.
- set up game states with each stage's text and options
- have on event that checks if mouse clicked on certain button (in while loop?)
    - then based on current game state & button clicked, do certain action
    - update statuses as needed
=end





# ---------------------------------------------------------


# display game
show

