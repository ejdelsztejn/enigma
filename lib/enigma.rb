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

  
end
