class Enigma
  include Shiftable, Crackable

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
end
