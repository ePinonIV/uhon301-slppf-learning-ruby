#!/usr/bin/ruby3.0

=begin
Ruby program to demonstrate ranges; can be one of these types:
1. Sequence
2. Condition
3. Interval
=end

$, =", "

# using start_point..end_point
# to_a is used to convert it into array
range_op = (7 .. 10).to_a
range_op1 = (7 ... 10).to_a

#displaying results
puts "\nUse ranges to make arrays:"
puts "#{range_op}"
puts "#{range_op1}"

# ---- 1. Ranges as sequences ----
puts "\nUse ranges as sequences:"

ranges = 6..8

# print true if value lies between range, false otherwise
val = 3
puts "Is " + val.to_s + " in " + ranges.to_s + "?"
puts ranges.include?(3)

# print max value in range
ans = ranges.max
puts "Maximum value = #{ans}"

# print min value in range
ans = ranges.min
puts "Minimum value = #{ans}"

# iterate 3 times and print value
ranges.each do |digit|
    puts "In Loop #{digit}"
end

# ---- 2. Ranges as conditions ----
puts "\nUse ranges as conditions"

# given num
num = 6230

result = case num
    when 1000..2000 then "Lies btw 1000 and 2000"
    when 2000..3000 then "Lies btw 2000 and 3000"
    when 3000..4000 then "Lies btw 3000 and 4000"
    when 4000..5000 then "Lies btw 4000 and 5000"
    when 5000..6000 then "Lies btw 5000 and 6000"
    when 6000..7000 then "Lies btw 6000 and 7000"

    else "Above 7000"
end

puts result

# ---- 3. Ranges as intervals ----
puts "\nUse ranges as intervals"

char = 'F'
# using if statement
if (('A'..'Z') === char) 
    # display the value
    puts char + " lies in the range of A to Z"
end

# same but with numbers
num = 77
if ((1..100) === num)
    puts num.to_s + " lies in the range of 1 to 100"
end