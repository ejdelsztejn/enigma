require './lib/enigma'
require './lib/shift'

enigma = Enigma.new
shift = Shift.new

handle = File.open(ARGV[0], "r")
to_encrypt = handle.read
handle.close

encrypted = enigma.encrypt(to_encrypt, shift.key, shift.date)[:encryption]

writer = File.open(ARGV[1], "w")
writer.write(encrypted)
writer.close

puts "Created '#{ARGV[1]}' with the key #{shift.key} and date #{shift.date}"
