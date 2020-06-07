require_relative './test_helper'
require './lib/shift'
require 'date'

class ShiftTest < MiniTest::Test
  def test_it_exists
    shift = Shift.new

    assert_instance_of Shift, shift
  end

  def test_it_has_attributes
    shift = Shift.new

    assert_equal Time.now.strftime("%d%m%y"), shift.date
    assert_equal 5, shift.key.length
  end
end
