# Simple Ruby Tutorials and Game Demonstration
### uhon301-slppf-learning-ruby

This repository will hold all of the daily practice and work I do in my effor to learn a new programming language over the course of 21 days. Details on how to install Ruby can be found below.

# Setup

First Ruby must be installed on the target system.

I am using an Ubuntu/Debian based system so use apt:

`sudo apt update`

`sudo apt upgrade`

` sudo apt-get install ruby-full`

Additional packages may be required to run Ruby2d, the graphical user interface of Ruby. Install these packages first with apt:

`sudo apt install libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev`

Then use RubyGems, Ruby's internal libarary installer and manager, to install Ruby2d:

`gem install ruby2d`

Since Ruby is an interpreted language, instead of a compiled one, you can simply run any Ruby program (with or without the Ruby2d library) like so:

`ruby <program_name>.rb`

# Game Demo(s)

Hopefully proper Windows executables will be added later to easily run these demos...