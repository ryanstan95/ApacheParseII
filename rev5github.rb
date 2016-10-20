require 'date'

File.open("This_is_a_test.txt", "r") do |f|
line_counter = 0
url_array = []
failarray = []
redirectarray = []
successarray = []
errors_array = []
  f.each_line do |line|
    matches = (/\A(?<ip_address>\S+) \S+ \S+ \[(?<time>[^\]]+)\] "(?<method>GET|POST) (?<url>\S+) \S+?" (?<status>\d+) (?<bytes>\S+)/).match(line)
    #checks for bustted-ass lines and dumps them into an array of errors
    if !matches then
	    errors_array.push(line)
	    next
    end
    whole_day = Date.strptime(matches[:time], '%d/%b/%Y:%H:%M:%S')
    last2 = whole_day.strftime('%Y-%m')
    puts last2
    ip = matches[:ip_address]
    url = matches[:url]
    status = matches[:status]
    method = matches[:method]
    url_array.push(url)
    #add to the line counter
    line_counter = line_counter+1
    time = matches[:time]
    puts status[0]
  end
  #the parsing of the file is finished at this point
  puts "DONE"
  print "There were", " ", line_counter,  " " ,"requests"
  puts failarray
end
#test to revert comments
