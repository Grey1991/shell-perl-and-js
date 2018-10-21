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
<title>Environment Variables</title>
</head>
<body>

Here are the environment variables the web server has passed to this CGI script:
<pre>
eof

# print all environment variables
# This is interpreted as HTML so we replace some chars by the equivalent HTML entity.
# Note this will not guarantee security in all contexts.

env|
sed 's/&/\&amp;/;s/</\&lt;/g;s/>/\&gt;/g'

cat <<eof
</pre>
</body>
</html>
eof
