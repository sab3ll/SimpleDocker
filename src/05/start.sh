#!/bin/bash

spawn-fcgi -p 8080 ./server
service nginx start
tail -f /dev/null
