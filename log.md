# Daily Log

04/14/26

- Got GitHub repo created and Ruby installed on my machine
- Ran through this basic interactive terminal tutorial from the [official documentation](https://www.ruby-lang.org/en/documentation/quickstart/)
- Syntax seems pretty similar to Python, which is great for accesibility and should come decently easy to me!

-----

04/15/26

- Following tutorials on the GeeksforGeeks website I got my first program written!
- I can see how the basic function structure will work, but I definitely need to read up more on how to do more advanced things...

-----

04/16/26

- Got a few more examples working
- Classes are pretty intuitive from my experience with C and other object oriented languages
- I really like the ranges feature, makes it really easy to define, well, ranges of numbers or even characters!
- I think with a little more experience with loops, I can start thinking about how I will build my larger game/demo

-----

04/17/26

- thought I should switch to some reading and listening today since I'd done mostly writing so far
- Did some good reading on [Ruby as compared to Python](www.ruby-lang.org/en/documentation/ruby-from-other-languages/to-ruby-from-python/) (a language I already know pretty well) and I think it helps to put this one more in perspective
    - similarities:
        - has interactive prompt
        - no special line terminators
        - brackets are for lists and braces are for dicts (or in Ruby, 'hashes')
        - arrays work the same (aside from getting an array of arrays)
        - objects are strongly and dynamically typed
        - everything is an object, including variables, which are just references to objects
    - differences:
        - strings are mutable
        - can make constants
        - some enforsed case-conventions (class names must start with capital, variables must start with lowercase)
        - only one kind of list container (array) and it is mutable
        - never directly access attributes, only method calls
        - paretheses sometimes optional!
        - can add/modify methods of build-in classes
        - true and false are lowercase (and nil instead of none)
        - elsif insstead of elif
        - require instead of import
        - more shortcuts available
- also interestingly I found a podcast about [Ruby as beautiful programming language](https://www.youtube.com/watch?v=CgfuEMvYeX0) so I listened to that!
    - they had some very strong opinions about the language, mostly positive, and they talked a bit about the history of the language and why it was made...
    - most interestingly they talked about writing code similar to writing a book, or even poetry! They talked about how the syntax of this language is much more elegant and simple to make sense of than others (which I definitely agree)
    - one of the people said that they loathed writing code in ohter languages because of the syntax, but they enjoy Ruby a lot, and I think it is interesting because many people think of writing code just as something to do for a job, but it is a hobby for many, just like writing
    - they briefly talked about how Ruby lets people modify the base classes and how it is like an author publishing a book and some fan writing another chapter - people's work builds on each other and makes something even greater

-----

04/18/26
- found a very [extensive tutorial](https://www.youtube.com/watch?v=t_ispmWmdjY) on learning Ruby, seems like a very helpful resource
    - I watched through the first few sections to reinforce what I learned previously, then wrote some new code after section 10 (getting user input)

-----

04/19/26

- for the 'immersive' experience today, I should put in a little extra work and I happened to find [this tutorial](https://www.youtube.com/watch?v=NNquTeeA2as) on how to make some graphics with Ruby so I decided to follow it
- made a cool little demo showcasing what you can do with the language!
- I'll try to add more documentation about it tomorrow

-----

04/20/26

- today I should try to decide on the actual project I am going to make, now that I have an understanding of the language better
- here are my current ideas:
    - wordle or similar word based game with a database (with proper gui)
        - could be a version of a board game (scrabble, tapple, anomia, etc.)
    - pong, flappy bird, asteroids or some other simple input graphic game
    - "picture this" where there is a very zoomed in image and you have to guess what it is
        - either manual zoom out button or zooms out when guessed wrongo

-----

04/21/26

- I realized that with the way I've been coding, whatever game/application I make will only be able to run if you have Ruby installed... however for most people that is not an easy thing to do, which goes against my idea of being able to share this project easily - so I've decided for my practice today I'll look into how to make a .exe file that can be run on anyone's computer
    - may be a bigger hurdle than I initially thought, as I am running WSL, which is Linux embedded in Windows, so I have different graphics dependencies than usual... might need to try this on my Raspberry Pi running Debian
    - ok looking at the documentation more, my question has been answered:
    ```
    There is no support for building a Windows .exe from a Linux or macOS host, or vice versa. If you need builds for multiple platforms, run OCRAN in CI on each target platform separately (e.g., a Windows runner for .exe builds and a Linux runner for Linux builds).
    ```
    So no way to build it on Linux and have it run on Windows... but I could probably still write the script that runs with my usual setup and at the end deal with having it runnable from Windows? Not exactly sure, so I should test this first.
        - use
- unrelated I had an interesting idea for my final game - a choose your own adventure / terminal inspired River of Doubt game

-----

04/22/26

- did the work on my laptop early yesterday and the commit didn't go through! Dang, I'll have to count it as close enough...
- got a proper .exe working on Windows! It doesn't seem too bad actually to do that... maybe the graphical game is possible? I should try to package up the ufo game demo next
    - ended up following these links:
        - [ocran github page](https://github.com/Largo/ocran)
        - [ruby install for Windows](https://rubyinstaller.org/downloads/)
        - [getting exe in Windows](https://www.ruby-forum.com/t/distributing-ruby-program-as-a-standalone-executable-exe-for-windows/210581)

-----

04/23/26
- I think I have decided on the River Of Doubt Choose Your Own Adventure Game (RODCYOA?). Since this is kind of a big project I think its in my best interest to plan out a little before blindly jumping in to code...
- Going to do a little refreshing on the ROD story.
- As for the story, I think 8 checkpoints/stages for the user to choose seems like a good number, here are my ideas:
1. Packing for journey - Father Zahm invites TR (the player?) on the trip to the Amazon. Do you go or not? If so, do you help him pack or leave it all to him?
2. Now in the jungle, do you take canoes down the water or walk through on feet? (Maybe implement some kind of resource/danger? So it canoes, chance to get hurt or smth, but if on feet lose hunger)
3. First encounter with Cinta Larga tribe. Do you leave a peace offering, try to fight them, or just move on? (Lose food/items, get hurt, or __)
4. Simplicio taken by a whirlpool! Do you stop and take the time to look for him or cut your losses and move on? (Stopping costs more food, raises group morale, moving on lowers morale but saves food)
5. Nature is being really rough, you are being eaten by the flies and termites. Use medical resources or save them? (If not used, can develop infection?)
6. TR and Rondon are in conflict over how to handle rest of expedition. Do you push onwards quickly, forgoing the scentifical/geographical analysis you set out to do? Or, do you linger around to do this work in the harsh environment? (Save food & health, or lose food/health but get research done... maybe have something about relationship with Rondon being bad?)
7. TR is severely ill on the last stretch out of the jungle, and is suggesting to go on ahead without him. Do you leave his legacy to end there in the jungle, or drag him out? (Save food & resources but lose TR, lose food/resources but save him!)
8. The group makes it out of the jungle! However there are many people who don't believe your tall tales of your time in the Amazon. Did you collect enough specimens as proof of your journey? (Check if spent enough time researching, different endings based on results)

    