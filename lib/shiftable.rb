require_relative './shift'

module Shiftable
  SHIFT = Shift.new
  KEY = SHIFT.key
  DATE = SHIFT.date
  CHARACTERS = ("a".."z").to_a << " "

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

  def shift_character(character, shift_letter, key_hash, shifted_string)
    if CHARACTERS.include?(character.downcase)
      new_arr = CHARACTERS.rotate(CHARACTERS.index(character.downcase))
      num = key_hash[shift_letter]
      num -= 27 until num <= 27
      num = 0 if num == 27
      shifted_string << new_arr[num]
    else
      shifted_string << character
    end
  end

  def unshift_character(character, shift_letter, key_hash, shifted_string)
    if CHARACTERS.include?(character)
      new_arr = CHARACTERS.rotate(CHARACTERS.index(character))
      num = key_hash[shift_letter]
      num -= 27 until num <= 27
      location = new_arr[0 - num]
      shifted_string << location
    else
      shifted_string << character
    end
  end
end
