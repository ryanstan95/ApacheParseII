apache_logs = File.readlines "This_is_a_test.txt"

apache_logs(/\A(?<ip_address>\S+) \S+ \S+ \[(?<time>[^\]]+)\] "(?<method>GET|POST) (?<url>\S+) \S+?" (?<status>\d+) (?<bytes>\S+)/)
print ip_address
print bytes