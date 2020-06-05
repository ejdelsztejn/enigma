require_relative './test_helper'
require './lib/enigma'

class EnigmaTest < MiniTest::Test
  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
  end
end
