#!/usr/bin/ruby

# simple program demonstrating how to get user input from command line

puts "Enter your name: "
name = gets.chomp()     
    # chomp gets rid of new line character after pressing enter
#puts ("Hello " + name + ", nice to meet you!")

puts "Now enter your age: "
age = gets.chomp()
puts ("Hello " + name + ", you are " + age + " years old")