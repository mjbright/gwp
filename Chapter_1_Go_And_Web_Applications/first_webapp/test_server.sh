#!/bin/bash

PORT=8080

echo
#wget -O - http://localhost:${PORT}/Your_Name 2>/dev/null
curl http://localhost:${PORT}/Your_Name
echo



