# simple game capability demonstration using the Ruby2d library
# - this is just to demonstrate basic graphical capabilities
# - creates background and basic shape, as well as moveable sprite/image

require 'ruby2d'

set width: 600, height: 273, title: "Space Game Demo"

Image.new('space_background.png')

# how to make basic shapes
=begin
square = Square.new(
    color: 'red',
    size: 80,
    x: 100, y: 100,
)

Triangle.new(
    color: 'orange',
    x1: 0, y1: 0,
    x2: 40, y2: 0,
    x3: 0, y3: 40,
)

Sprite.new(
    'ufo.png',
    x: 100,
    y: 380,
    clip_width
)
=end

Circle.new(
    color: 'yellow',
    radius: 60,
    x: 20, y: 20,
)


# this is the sprite/image that the user will control
# NOTE: there is an actual Sprite object, but it is only needed when the image has animations
ufo_img = Image.new(
    'ufo.png',
    x: 250,
    y: 100,
    width: 100,
    height: 50,
)

# set sound files
ufo_sound = Sound.new('ufo_fly.ogg')
music = Music.new("background_noise.ogg", loop:true)
music.play

# just to display static text on screen
Text.new(
    'Use the arrow keys to move!',
    x: 120,
    y: 10,
    size: 30,
    color: 'white',
)

# active while key pressed and held
=begin
on :key_held do |event|
    case event.key
        when 'up'
            ufo_img.y -= 5
        when 'down'
            ufo_img.y += 5
        when 'left'
            ufo_img.x -= 5
        when 'right'
            ufo_img.x += 5
    end
end
=end

on :mouse_move do |event|
    ufo_img.x = event.x - 50
    ufo_img.y = event.y - 30
end

start_time = Time.now
# activates only when key is initially pressed
# - timer so it doesn't get spammed
on :key_down do
    elapsed = Time.now - start_time
    if elapsed > 0.25
        ufo_sound.play
        start_time = Time.now
    end
end

# start the visual display window
show