require './lib/enigma'

enigma = Enigma.new

handle = File.open(ARGV[0], "r")
to_crack = handle.read.chomp
handle.close

cracked = enigma.crack(to_crack, ARGV[2])
cracked_message = cracked[:decryption]

writer = File.open(ARGV[1], "w")
writer.write(cracked_message)
writer.close

puts "Created '#{ARGV[1]}' with the key #{cracked[:key]} and date #{ARGV[2]}"
