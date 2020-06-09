require_relative './test_helper'
require './lib/shift'
require './lib/enigma'
require 'date'

class EnigmaTest < MiniTest::Test
  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
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
    date = "040895"
    keys = enigma.generate_keys(key)
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

  def test_it_can_encrypt_with_a_key
    enigma = Enigma.new

    assert_equal ({
      encryption: "nib udmcxpu",
      key: "02715",
      date: Time.now.strftime("%d%m%y")
      }), enigma.encrypt("hello world", "02715")
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
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }), enigma.decrypt("keder ohulw", "02715",  "040895")
  end

  def test_it_can_decrypt_with_a_key
    enigma = Enigma.new

    assert_equal ({
      decryption: "hello world",
      key: "02715",
      date: Time.now.strftime("%d%m%y")
    }), enigma.decrypt("nib udmcxpu", "02715")
  end

  def test_it_can_unshift_character
    enigma = Enigma.new
    character = "k"
    shift_letter = :a
    key_hash = { a: 3, b: 27, c: 73, d: 20 }
    shifted_string = ''

    assert_equal "h", enigma.unshift_character(character, shift_letter, key_hash, shifted_string)

    character2 = "!"

    assert_equal "!", enigma.unshift_character(character2, shift_letter, key_hash, shifted_string)
  end

  def test_it_can_determine_letters_for_end
    enigma = Enigma.new
    message = "vjqtb"

    assert_equal [:a, :b, :c, :d, :a], enigma.determine_letters_for_end(message)
  end

  def test_it_can_determine_shifts_for_end
    enigma = Enigma.new
    message = "vjqtbeaweqihssi"

    assert_equal ({:d=>8, :a=>14, :b=>5, :c=>5}), enigma.determine_shifts_for_end(message)
  end

  def test_it_can_subtract_offsets
    enigma = Enigma.new
    message = "vjqtbeaweqihssi"
    date = "090620"

    assert_equal ({:d=>8, :a=>10, :b=>1, :c=>5}), enigma.subtract_offsets(message, date)
  end

  def test_it_can_determine_key
    enigma = Enigma.new
    message = "vjqtbeaweqihssi"
    date = "291018"

    assert_equal "08304", enigma.determine_key(message, date)
  end

  def test_it_can_crack_with_date
    enigma = Enigma.new
    message = "vjqtbeaweqihssi"
    date = "291018"

    assert_equal ({
      decryption: "hello world end",
      date: "291018",
      key: "08304"
    }), enigma.crack("vjqtbeaweqihssi", "291018")
  end

  def test_it_can_crack_without_date
    enigma = Enigma.new
    message = "qhmetkxettdnlmdjslojxmsgakwcsyfi"

    assert_equal ({
      decryption: "you are a little sweet birdy end",
      key: "15093",
      date: "090620"
      }), enigma.crack(message)
  end
end
