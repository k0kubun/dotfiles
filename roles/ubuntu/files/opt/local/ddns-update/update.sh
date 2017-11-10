#!/bin/bash -e

here="$(cd "$(dirname $0)" && pwd)"

domain="dip.jp"
username="$(cat "${here}/username")"
password="$(cat "${here}/password")"

if [ "_${username}" = "_" -o "_${password}" = "_" ]; then
  echo "username or password is not set. Skipping."
  exit 1
fi

old_ip="$(cat "${here}/current")"
new_ip="$(curl -s http://ieserver.net/ipcheck.shtml)"

if [ "_${old_ip}" = "_${new_ip}" ]; then
  echo "[$(date)] Not changed from: ${old_ip}"
  exit 0
fi

response="$(curl -v -d "domain=${domain}&username=${username}&password=${password}&updatehost=1" "https://ieserver.net/cgi-bin/dip.cgi")"
echo "$response"

if echo "$response" | grep -q "$new_ip"; then
  echo "[$(date)] Succeeded to change: ${old_ip} -> ${new_ip}"
  echo "$new_ip" > "${here}/current"
else
  echo "[$(date)] Failed to change: ${old_ip} -> ${new_ip}"
  exit 1
fi
