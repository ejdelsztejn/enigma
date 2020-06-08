class Enigma
  attr_reader :characters
  def initialize
    @characters = ("a".."z").to_a << " "
  end

  def generate_keys(key_string)
    {
    a: key_string[0, 2].to_i,
    b: key_string[1, 2].to_i,
    c: key_string[2, 2].to_i,
    d: key_string[3, 2].to_i
  }
  end

  def generate_offsets(date)
    offset_date = (date.to_i * date.to_i).to_s[-4..-1]
    {
      a: offset_date[0].to_i,
      b: offset_date[1].to_i,
      c: offset_date[2].to_i,
      d: offset_date[3].to_i
    }
  end

  def generate_shifts(keys, offsets)
    keys[:a] += offsets[:a]
    keys[:b] += offsets[:b]
    keys[:c] += offsets[:c]
    keys[:d] += offsets[:d]
    keys
  end

  def encrypt(message, key, date = Time.now.strftime("%d%m%y"))
    keys = generate_keys(key)
    offsets = generate_offsets(date)
    key_hash = generate_shifts(keys, offsets)
    shifted_string = ''
    shift = 0
    message.downcase.chars.each do |char|
      if shift == 0
        shift_character(char, :a, key_hash, shifted_string)
        shift += 1
      elsif shift == 1
        shift_character(char, :b, key_hash, shifted_string)
        shift += 1
      elsif shift == 2
        shift_character(char, :c, key_hash, shifted_string)
        shift += 1
      else
        shift_character(char, :d, key_hash, shifted_string)
        shift = 0
      end
    end
    create_encrypted_hash(shifted_string, key, date)
  end

  def decrypt(message, key, date = Time.now.strftime("%d%m%y"))
    keys = generate_keys(key)
    offsets = generate_offsets(date)
    key_hash = generate_shifts(keys, offsets)
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
    create_encrypted_hash(shifted_string, key, date)
  end

  def shift_character(character, shift_letter, key_hash, shifted_string)
    if characters.include?(character.downcase)
      new_arr = characters.rotate(characters.index(character.downcase))
      num = key_hash[shift_letter]
      num -= 27 until num <= 27
      num = 0 if num == 27
      shifted_string << new_arr[num]
    else
      shifted_string << character
    end
  end

  def unshift_character(character, shift_letter, key_hash, shifted_string)
    if characters.include?(character)
      new_arr = characters.rotate(characters.index(character))
      num = key_hash[shift_letter]
      num -= 27 until num <= 27
      location = new_arr[0 - num]
      shifted_string << location
    else
      shifted_string << character
    end
  end

  def create_encrypted_hash(message, key, date)
    {
      encryption: message,
      key: key,
      date: date
    }
  end

  # CRACK STUFF

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

  def unshift_character_crack(character, key_hash, shifted_string)
    characters = ("a".."z").to_a << " "
    if characters.include?(character)
      new_arr = characters.rotate(characters.index(character))
      num = key_hash[letter]
      num -= 27 until num <= 27
      location = new_arr[0 - num]
      shifted_string << location
    else
      shifted_string << character
    end
    shifted_string
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
