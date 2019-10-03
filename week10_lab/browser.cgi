#!/bin/sh


# print HTTP header
# its best to print the header ASAP because 
# debugging is hard if an error stops a valid header being printed

echo Content-type: text/html
echo

host_name=`host $REMOTE_ADDR | sed 's/.*pointer //' | sed 's/\.$//'`
# print page content

cat <<eof
<!DOCTYPE html>
<html lang="en">
<head>
<title>Browser IP, Host and User Agent</title>
</head>
<body>
Your browser is running at IP address: <b>$REMOTE_ADDR</b>
<p>
Your browser is running on hostname: <b>$host_name</b>
</p><p>
Your browser identifies as: <b>$HTTP_USER_AGENT</b>
</p>
</body>
</html>
eof