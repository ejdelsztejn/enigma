require_relative './shiftable'
require_relative './crackable'

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
    create_decrypted_hash(shifted_string, key, date)
  end

  def create_encrypted_hash(message, key, date)
    {
      encryption: message,
      key: key,
      date: date
    }
  end

  def create_decrypted_hash(message, key, date)
    {
      decryption: message,
      key: key,
      date: date
    }
  end
end
