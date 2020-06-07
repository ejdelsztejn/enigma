class Enigma
  attr_reader :characters
  def initialize
    @characters = ("a".."z").to_a << " "
  end

  def generate_key_string
    rand(99999).to_s.rjust(5, "0")
  end

  def generate_keys(key_string)
    {
    a: key_string[0, 2].to_i,
    b: key_string[1, 2].to_i,
    c: key_string[2, 2].to_i,
    d: key_string[3, 2].to_i
  }
  end

  def generate_date
    Time.now.strftime("%d%m%y")
  end

  def generate_offsets(date = generate_date)
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

  def encrypt(message, key, date = generate_date)
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

  def decrypt(message, key, date = generate_date)
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
