# HTTP Request Smuggling

The backend server (unicorn) serves up two pages, /hello and /flag.
The proxy servers (haproxy:8001, mitmproxy:8003, squidproxy:8003, nginxproxy:8004) only serve up /hello and should 403 any requests to /flag

The smuggle script tests mutations of CL-TE loaded via mutations.csv

The script aims to smuggle a request to /flag on the proxy that effectively bypasses the 403 restriction by the same.

## Run the lab

    cd labs/request-smuggling
    docker-compose up

## Test the target proxies by port

    labs/request-smuggling/smuggle.sh 8001
    💀 line-appendix-vtab
    💀 colon-post-vtab
