puts "enter a number"
x = gets.chomp


if x.include?('⁄') && x.length == 3 || x.include?('/') && x.length == 3
  puts x
# else
#   puts "wrong"
end
