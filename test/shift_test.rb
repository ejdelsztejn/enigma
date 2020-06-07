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

  def test_it_can_take_a_date_as_argument
    shift1 = Shift.new("040895")

    assert_equal "040895", shift1.date

    shift2 = Shift.new
    assert_equal Time.now.strftime("%d%m%y"), shift2.date
  end
end
