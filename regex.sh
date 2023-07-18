#!/usr/bin/env bash

ifconfig | grep -Eo '(([[:xdigit:]]{2}):){5}[[:xdigit:]]{2}'
