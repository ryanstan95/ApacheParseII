require 'date'
require 'open-uri'
#initialization
SLOW_URL = 'https://s3.amazonaws.com/tcmg412-fall2016/http_access_log'
LOCALIZE = 'downloaded_file.bak'
success = 0
fail = 0
redirect = 0

#downloads the file
#makelocal = open(SLOW_URL)
#save the file
# reference code http://stackoverflow.com/questions/2515931/how-can-i-download-a-file-from-a-url-and-save-it-in-rails
#IO.copy_stream(makelocal, LOCALIZE)
#start parsing the file
File.open("This_is_a_test.txt", "r") do |f|
line_counter = 0
url_array = []
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
    if status[0] == "4"
	    fail += 1
    elsif status[0] == "3"
	    redirect += 1
    elsif status[0] == '2'
	    success += 1
    end
    line_counter = line_counter+1
    time = matches[:time]
    puts status[0]
  end
  #the parsing of the file is finished at this point
  puts "DONE"
  print "There were", " ", line_counter,  " " ,"requests"
  #successpercent = success /= line_counter *= 100
  #failpercent = fail /= line_counter
  #redirpct = redirect /= line_counter
  #print successpercent
  #print failpercent
  #print redirpct
  
end
#test to revert comments
