File.open("This_is_a_test.txt", "r") do |f|
  f.each_line do |line|
    matches = (/\A(?<ip_address>\S+) \S+ \S+ \[(?<time>[^\]]+)\] "(?<method>GET|POST) (?<url>\S+) \S+?" (?<status>\d+) (?<bytes>\S+)/).match(line)
    ip = matches[:ip_address]
    url = matches[:url]
    status = matches[:status]
    method = matches[:method]
    puts ip
    puts method
    puts url
    puts status
  end
end
