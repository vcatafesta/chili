#!/usr/bin/python3
# -*- coding: utf-8 -*-
from pathlib import Path
import datetime
import psutil

def kill_process(pidfile_path=Path("/var/run/sshd.pid")):
    try:
        pid=int(pidfile_path.read_text())
    except FileNotFoundError:
        print(f"No {pidfile_path}")
        return
    except ValueError:
        print(f"Invalid {pidfile_path}")
        return

    try:
        proc = psutil.Process(pid)
        print("Killing", proc.name())
        proc.kill()
    except psutil.NoSuchProcess as ex:
        print(f"({pid}) - no succh process")

def date(format="%Y%m%d"):
    return datetime.datetime.utcnow().strftime(format)

def make_output_dir() -> Path:
    today = date("%Y%m%d")
    output_dir = Path(".")/f"results_{today}"
    output_dir.mkdir(exist_ok=True)
    return output_dir

def run_analytics():
    pass

def copy_to_current():
    pass

if __name__ == "__main__":
#    kill_process()
    make_output_dir()
    run_analytics()
    copy_to_current()
