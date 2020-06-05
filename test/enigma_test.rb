require_relative './test_helper'
require './lib/enigma'

class EnigmaTest < MiniTest::Test
  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
  end

  def test_it_can_generate_a_key
    skip
  end

  def test_it_can_return_if_there_is_a_date
    skip
  end

  def test_it_can_generate_todays_date
    skip
  end

  def test_it_can_generate_offsets
    skip
  end

  def test_it_can_generate_shifts
    skip
  end

  def test_it_can_encrypt
    skip
  end
end
