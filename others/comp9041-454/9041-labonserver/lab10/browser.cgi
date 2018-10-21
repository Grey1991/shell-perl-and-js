#!/bin/sh


# print HTTP header
# its best to print the header ASAP because
# debugging is hard if an error stops a valid header being printed

echo Content-type: text/html
echo

# print page content

cat <<eof
<!DOCTYPE html>
<html lang="en">
<head>
<title>Browser IP, Host and User Agent</title>
</head>
<body>
eof

# print all environment variables
# This is interpreted as HTML so we replace some chars by the equivalent HTML entity.
# Note this will not guarantee security in all contexts.
echo -n "Your browser is running at IP address: <b>"
ip_address=$(env|egrep "REMOTE_ADDR="|sed 's/REMOTE_ADDR=//')
echo "$ip_address</b>"
echo "<p>"

echo -n "Your browser is running on hostname: <b>"
host_name=$(host $ip_address|sed 's/.\+in-addr\.arpa domain name pointer//'|sed 's/\.$//')
echo "$host_name</b>"

echo "<p>"
echo -n "Your browser identifies as: <b>"
user_agent=$(env|egrep "HTTP_USER_AGENT="|sed 's/HTTP_USER_AGENT=//')
echo "$user_agent</b>"

cat <<eof
</body>
</html>
eof
