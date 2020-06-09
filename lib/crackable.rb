module Crackable
  def determine_letters_for_end(message)
    shifts = []
    indx = 0
    message.chars.each do |char|
      if indx == 0
        shifts << :a
        indx += 1
      elsif indx == 1
        shifts << :b
        indx += 1
      elsif indx == 2
        shifts << :c
        indx += 1
      else
        shifts << :d
        indx = 0
      end
    end
    shifts
  end

  def create_end_letter_hash(message)
    end_letters = determine_letters_for_end(message)[-4..-1]
    {
      " " => end_letters[0],
      "e" => end_letters[1],
      "n" => end_letters[2],
      "d" => end_letters[3]
    }
  end

  def determine_shifts_for_end(message)
    message_end = message[-4..-1]
    shift_hash = { " " => 0, "e" => 0, "n" => 0, "d" => 0 }
    message_end.downcase.chars.each_with_index do |char, indx|
      shift = 0
      if indx == 0
        new_arr = characters.rotate(characters.index(" "))
        new_arr.each do |character|
          break if character == char
          shift += 1
        end
        shift_hash[" "] += shift
      elsif indx == 1
        new_arr = characters.rotate(characters.index("e"))
        new_arr.each do |character|
          break if character == char
          shift += 1
        end
        shift_hash["e"] += shift
      elsif indx == 2
        new_arr = characters.rotate(characters.index("n"))
        new_arr.each do |character|
          break if character == char
          shift += 1
        end
        shift_hash["n"] += shift
      else
        new_arr = characters.rotate(characters.index("d"))
        new_arr.each do |character|
          break if character == char
          shift += 1
        end
        shift_hash["d"] += shift
      end
    end
    end_letters = determine_letters_for_end(message)[-4..-1]
    {
      end_letters[0] => shift_hash[" "],
      end_letters[1] => shift_hash["e"],
      end_letters[2] => shift_hash["n"],
      end_letters[3] => shift_hash["d"]
    }
  end

  def create_end_letter_hash(message)
    end_letters = determine_letters_for_end(message)[-4..-1]
    shift_hash = determine_shifts_for_end(message)
    {
      end_letters[0] => shift_hash[" "],
      end_letters[1] => shift_hash["e"],
      end_letters[2] => shift_hash["n"],
      end_letters[3] => shift_hash["d"]
    }
  end

  def crack(message)
    key_hash = determine_shifts_for_end(message)
    shifted_string = ''
    shift = 0
    message.downcase.chars.each do |char|
      if shift == 0
        unshift_character(char, :a, key_hash, shifted_string)
        shift += 1
      elsif shift == 1
        unshift_character(char, :b, key_hash, shifted_string)
        shift += 1
      elsif shift == 2
        unshift_character(char, :c, key_hash, shifted_string)
        shift += 1
      else
        unshift_character(char, :d, key_hash, shifted_string)
        shift = 0
      end
    end
    shifted_string
  end
end
