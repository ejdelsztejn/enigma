class Enigma
  attr_reader :characters
  def initialize
    @characters = ("a".."z").to_a << " "
  end

  def generate_key_string
    rand(99999).to_s.rjust(5, "0")
  end

  def generate_keys(key_string)
    {
    a: key_string[0, 2].to_i,
    b: key_string[1, 2].to_i,
    c: key_string[2, 2].to_i,
    d: key_string[3, 2].to_i
  }
  end

  def generate_date
    Time.now.strftime("%d%m%y")
  end

  def generate_offsets(date = generate_date)
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
