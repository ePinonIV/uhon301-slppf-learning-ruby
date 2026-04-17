#!/usr/bin/ruby
# ^ not sure if this is necessary honestly but its shown up in all of the code examples

# Program to illustrate instance variables
# - these are variables that start with an @ sign
# - similar to class variables but are local to specific instances of an object

class Student

    def initialize(id, name, email)
        # instance variables
        @student_id = id
        @student_name = name
        @student_email = email
    end

    # dipslaying result
    def display_details()
        puts "Student id: #@student_id"
        puts "Student name: #@student_name"
        puts "Student email: #@student_email"
    end

end

# create objects
st1 = Student.new("01", "John", "johnp23@unm.edu")
st2 = Student.new("02", "Sam", "sammy53@unm.edu")

# call methods
st1.display_details()
st2.display_details()