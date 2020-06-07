require_relative './test_helper'
require './lib/enigma'

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

  def test_it_can_generate_keys
    skip
    enigma = Enigma.new

    p enigma.generate_keys
    # assert_equal 5, key.length
  end

  def test_it_can_return_if_there_is_a_date
    skip
  end

  def test_it_can_generate_todays_date
    skip
    enigma = Enigma.new

    p enigma.generate_date
  end

  def test_it_can_generate_offsets
    skip
    enigma = Enigma.new

    p enigma.generate_offsets
  end

  def test_it_can_generate_shifts
    skip
    enigma = Enigma.new

    p enigma.generate_shifts
  end

  def test_it_can_encrypt
    skip
    enigma = Enigma.new
  end

  def test_it_can_decrypt
    skip
    enigma = Enigma.new
  end
end
