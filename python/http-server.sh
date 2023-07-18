#!/usr/bin/env bash

#python3 -m http.server
#python -m http.server 8000
#python -m http.server --bind 127.0.0.1
#python -m http.server --directory /tmp/
#python -m http.server --cgi
python -m http.server 8000 --cgi --directory /srv/http

