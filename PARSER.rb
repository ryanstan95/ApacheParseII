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
monthly_requests = {}
  f.each_line do |line|
    matches = (/\A(?<ip_address>\S+) \S+ \S+ \[(?<time>[^\]]+)\] "(?<method>GET|POST) (?<url>\S+) \S+?" (?<status>\d+) (?<bytes>\S+)/).match(line)
    #checks for bustted-ass lines and dumps them into an array of errors
    if !matches then
	    errors_array.push(line)
	    next
    end
    whole_day = Date.strptime(matches[:time], '%d/%b/%Y:%H:%M:%S')
    last2 = whole_day.strftime('%d-%Y-%m')
    #puts last2
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
    unless monthly_requests[last2] then monthly_requests[last2] = [] end
    monthly_requests[last2].push(line)
  end
  #the parsing of the file is finished at this point
  puts "DONE"
  print "There were", " ", line_counter,  " " ,"requests"
  #calculates the failures and redirects
  successpercent = success.to_f / line_counter.to_f * 100
  failpercent = fail.to_f / line_counter.to_f * 100
  redirpct = redirect.to_f / line_counter.to_f * 100
  puts ' '
  print failpercent, '% of requests were unsucessful'
  puts ' '
  print redirpct, '% of lines were redirects'
  #print redirpct
  #figures out the most and least requested files
  freq = url_array.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
  url_array.max_by { |v| freq[v] }
  puts ' '
  print 'The most requested file was', ' ', url_array[0]
  puts ' '
  print 'The least requested file was', ' ' , url_array[-1]
  puts monthly_requests
end
#test to revert comments
