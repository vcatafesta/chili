#!/usr/bin/python3
# -*- coding: utf-8 -*-

from pathlib import Path
import datetime

def date(format="%Y%m%d"):
    return datetime.datetime.utcnow().strftime(format)

def make_output_dir() -> Path:
    today = date("%Y%m%d")
    output_dir = Path(".")/f"results_{today}"
    output_dir.mkdir(exist_ok=True)
    return output_dir
