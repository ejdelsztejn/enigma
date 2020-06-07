require_relative './test_helper'
require './lib/enigma'
require 'date'

class EnigmaTest < MiniTest::Test
  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
  end

  def test_it_has_characters
    enigma = Enigma.new

    assert_instance_of Array, enigma.characters
    assert_equal 27, enigma.characters.size
  end

  def test_it_can_generate_key_string
    enigma = Enigma.new

    assert_equal 5, enigma.generate_key_string.length
  end

  def test_it_can_generate_keys
    enigma = Enigma.new
    key = "02715"

    assert_equal ({
      a: 2,
      b: 27,
      c: 71,
      d: 15
    }), enigma.generate_keys(key)
  end

  def test_it_can_generate_todays_date
    enigma = Enigma.new

    assert_equal Time.now.strftime("%d%m%y"), enigma.generate_date
  end

  def test_it_can_generate_offsets
    enigma = Enigma.new
    date = "040895"

    assert_equal ({
      a: 1,
      b: 0,
      c: 2,
      d: 5
      }), enigma.generate_offsets(date)
  end

  def test_it_can_generate_shifts
    enigma = Enigma.new
    key = "02715"
    keys = enigma.generate_keys(key)
    date = "040895"
    offsets = enigma.generate_offsets(date)

    assert_equal ({
      a: 3,
      b: 27,
      c: 73,
      d: 20
      }), enigma.generate_shifts(keys, offsets)
  end

  def test_it_can_encrypt
    enigma = Enigma.new

    assert_equal ({
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }), enigma.encrypt("hello world", "02715",  "040895")
  end

  def test_it_can_encrypt_capital_letters
    enigma = Enigma.new

    assert_equal ({
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }), enigma.encrypt("HELLO WORLD", "02715",  "040895")
  end

  def test_it_can_encrypt_all_characters
    enigma = Enigma.new

    assert_equal ({
      encryption: "98!*!5*7!*!89",
      key: "02715",
      date: "040895"
    }), enigma.encrypt("98!*!5*7!*!89", "02715",  "040895")
  end

  def test_it_can_create_encrypted_hash
    enigma = Enigma.new

    enigma.encrypt("hello world", "02715",  "040895")
    assert_equal ({
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }), enigma.create_encrypted_hash("keder ohulw", "02715",  "040895")
  end

  def test_it_can_shift_character
    enigma = Enigma.new
    character = "h"
    shift_letter = :a
    key_hash = { a: 3, b: 27, c: 73, d: 20 }
    shifted_string = ''

    assert_equal "k", enigma.shift_character(character, shift_letter, key_hash, shifted_string)
  end

  def test_it_can_decrypt
    enigma = Enigma.new

    assert_equal ({
      encryption: "hello world",
      key: "02715",
      date: "040895"
    }), enigma.decrypt("keder ohulw", "02715",  "040895")
  end

  def test_it_can_unshift_character
    enigma = Enigma.new
    character = "k"
    shift_letter = :a
    key_hash = { a: 3, b: 27, c: 73, d: 20 }
    shifted_string = ''

    assert_equal "h", enigma.unshift_character(character, shift_letter, key_hash, shifted_string)
  end
end
