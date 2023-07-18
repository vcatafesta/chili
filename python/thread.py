import threading
import time


def worker():
    """thread worker function"""
    print(time.ctime())
    return (time.ctime())


def teste():
    t = threading.Thread(target=worker)
    while time.sleep(1):
        t.start()

teste()
print(time.ctime())
