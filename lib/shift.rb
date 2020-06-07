class Shift
  attr_reader :key,
              :date
  def initialize(date = Time.now.strftime("%d%m%y"))
    @key = rand(99999).to_s.rjust(5, "0")
    @date = date
  end
end
