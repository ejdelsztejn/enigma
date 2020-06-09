require_relative './shift'

module Shiftable
  SHIFT = Shift.new
  KEY = SHIFT.key
  DATE = SHIFT.date

  def generate_keys(key_string)
    {
    a: key_string[0, 2].to_i,
    b: key_string[1, 2].to_i,
    c: key_string[2, 2].to_i,
    d: key_string[3, 2].to_i
  }
  end

  def generate_offsets(date)
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
end
