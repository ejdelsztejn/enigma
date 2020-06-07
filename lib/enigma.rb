class Enigma
  attr_reader :characters
  def initialize
    @characters = ("a".."z").to_a << " "
  end

  def generate_key_string
    rand(99999).to_s.rjust(5, "0")
  end

  
end
