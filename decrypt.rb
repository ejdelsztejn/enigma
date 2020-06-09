require './lib/enigma'
require './lib/shift'

enigma = Enigma.new

handle = File.open(ARGV[0], "r")
to_decrypt = handle.read
handle.close

decrypted = enigma.decrypt(to_decrypt, ARGV[2], ARGV[3])[:decryption]

writer = File.open(ARGV[1], "w")
writer.write(decrypted)
writer.close

puts "Created '#{ARGV[1]}' with the key #{ARGV[2]} and date #{ARGV[3]}"
