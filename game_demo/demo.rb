# simple game capability demonstration using the Ruby2d library

require 'ruby2d'

set width: 600, height: 273, title: "Space Game Demo"
#set height: 273

Image.new('space_background.png')

=begin
square = Square.new(
    color: 'red',
    size: 80,
    x: 100, y: 100,
)
=end

Circle.new(
    color: 'yellow',
    radius: 60,
    x: 20, y: 20,
)

=begin
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

Text.new(
    'Use the arrow keys to move!',
    x: 120,
    y: 10,
    size: 30,
    color: 'white',
)

# active while key pressed and held
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

# activates only when key is initially pressed
on :key_down do
    ufo_sound.play
end
# start the visual display window
show