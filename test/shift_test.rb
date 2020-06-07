require_relative './test_helper'
require './lib/shift'
require 'date'

class ShiftTest < MiniTest::Test
  def test_it_exists
    shift = Shift.new

    assert_instance_of Shift, shift
  end
end
