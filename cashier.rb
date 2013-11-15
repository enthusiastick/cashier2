def number_check(xyz)
  (xyz).match(/^\d+(?:\.\d{0,2})?$/)
end

def zero_check(abc)
  abc.to_s.reverse.index('.') == 2
end

def in_pennies(r)
  (r.to_f*100).to_i
end

def in_dollars(t)
  t.to_f / 100.0
end

price_input = nil
running_total_in_pennies = 0
sale_list = []
puts "Hello!"
while true
  puts "What is the sale price?"
  price_input = gets.chomp
  if price_input == "exit"
    running_total_in_dollars = in_dollars(running_total_in_pennies)
    puts ""
    puts "---"
    puts ""
    puts "Item list:"
    for items in sale_list do
      puts "  $#{items}"
    end
    puts ""
    puts "---"
    puts ""
    if zero_check(running_total_in_dollars) != true
      puts "Total: $#{running_total_in_dollars}0"
    else
      puts "Total: $#{running_total_in_dollars}"
    end
    puts "What is the amount tendered?"
    paid_input = gets.chomp
    paid_input_in_pennies = in_pennies(paid_input)
    if number_check(paid_input) == nil
      puts "No sale! I didn't understand that amount tendered."
      abort
    elsif paid_input_in_pennies < running_total_in_pennies
      still_owed_in_pennies = running_total_in_pennies - paid_input_in_pennies
      still_owed_in_dollars = in_dollars(still_owed_in_pennies)
        if zero_check(still_owed_in_dollars) != true
          puts "No sale! Customer still owes: $#{still_owed_in_dollars}0"
          abort
        else
          puts "No sale! Customer still owes: $#{still_owed_in_dollars}"
          abort
        end
    else
      change_in_pennies = paid_input_in_pennies - running_total_in_pennies
      change_in_dollars = in_dollars(change_in_pennies)
      if zero_check(change_in_dollars) != true
        puts "Thank you! The change is $#{change_in_dollars}0"
        abort
      else
        puts "Thank you! The change is: $#{change_in_dollars}"
        abort
      end
    end
  elsif number_check(price_input) == nil
    puts "I don't understand that sale price. Please try again."
  else
   sale_list.push price_input
   price_input_in_pennies = in_pennies(price_input)
   running_total_in_pennies = running_total_in_pennies + price_input_in_pennies
   running_total_in_dollars = in_dollars(running_total_in_pennies)
   if zero_check(running_total_in_dollars) != true
    puts "Added: $#{price_input}"
    puts "Total: $#{running_total_in_dollars}0"
   else
   puts "Added: $#{price_input}"
   puts "Total: $#{running_total_in_dollars}"
   end
  end
end
