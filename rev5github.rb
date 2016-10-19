File.open("This_is_a_test.txt", "r") do |f|
line_counter = 0
url_array = []
  f.each_line do |line|
    matches = (/\A(?<ip_address>\S+) \S+ \S+ \[(?<time>[^\]]+)\] "(?<method>GET|POST) (?<url>\S+) \S+?" (?<status>\d+) (?<bytes>\S+)/).match(line)
    ip = matches[:ip_address]
    url = matches[:url]
    status = matches[:status]
    method = matches[:method]
    url_array.push(url)
    #add to the line counter
    line_counter = line_counter+1
    time = matches[:time]
    puts time
  end
  #the parsing of the file is finished at this point
  puts "DONE"
  puts url_array
  print "There were", " ", line_counter,  " " ,"requests"
end
