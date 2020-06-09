module Crackable
  CHARACTERS = ("a".."z").to_a << " "
  DATE = Time.now.strftime("%d%m%y")

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

  def determine_shifts_for_end(message)
    message_end = message[-4..-1]
    shift_hash = { " " => 0, "e" => 0, "n" => 0, "d" => 0 }
    message_end.downcase.chars.each_with_index do |char, indx|
      shift = 0
      if indx == 0
        new_arr = CHARACTERS.rotate(CHARACTERS.index(" "))
        new_arr.each do |character|
          break if character == char
          shift += 1
        end
        shift_hash[" "] += shift
      elsif indx == 1
        new_arr = CHARACTERS.rotate(CHARACTERS.index("e"))
        new_arr.each do |character|
          break if character == char
          shift += 1
        end
        shift_hash["e"] += shift
      elsif indx == 2
        new_arr = CHARACTERS.rotate(CHARACTERS.index("n"))
        new_arr.each do |character|
          break if character == char
          shift += 1
        end
        shift_hash["n"] += shift
      else
        new_arr = CHARACTERS.rotate(CHARACTERS.index("d"))
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

  def crack(message, date = DATE)
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
    create_decrypted_hash(shifted_string, determine_key(message, date), date)
  end

  def subtract_offsets(message, date)
    offsets = generate_offsets(date)
    keys = determine_shifts_for_end(message)
    keys[:a] -= offsets[:a]
    keys[:b] -= offsets[:b]
    keys[:c] -= offsets[:c]
    keys[:d] -= offsets[:d]
    keys
  end

  def determine_key(message, date)
    key_string = ''
    keys = subtract_offsets(message, date).sort.to_h
    key_string << keys[:a].to_s.rjust(2, "0")
    keys.delete(:a)
    keys.each do |key, value|
      next_key = key_string[-1].to_i * 10
      until next_key % 27 == value
        next_key += 1
      end
      key_string << next_key.to_s[-1]
    end
    key_string
  end
end
