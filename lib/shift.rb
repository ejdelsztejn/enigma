class Shift
  attr_reader :key,
              :date
  def initialize
    @key = rand(99999).to_s.rjust(5, "0")
    @date = Time.now.strftime("%d%m%y")
  end
end
