#!/bin/bash

PORT=8080

URL=http://localhost:${PORT}/Your_Name

# Provide info on response headers:
#INFO="-i"
INFO=""

echo
#wget -O - $INFO ${URL} 2>/dev/null
echo ">>>> Sending a GET request"
curl -s ${INFO} ${URL}
echo

echo ">>>> Sending a POST request with data"
curl -s --data "param1=value1&param2=value2" -X POST $INFO ${URL}
echo

echo ">>>> Sending a HEAD request"
#curl -s -X HEAD -l $INFO ${URL}
curl -s -I $INFO ${URL}
echo



