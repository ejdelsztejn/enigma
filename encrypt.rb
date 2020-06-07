handle = File.open(ARGV[0], "r")
to_encrypt = handle.read
handle.close

puts to_encrypt
