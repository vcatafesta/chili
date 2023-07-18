from msvcrt import getch

def readkey():
    nkey = ord(getch())
    return nkey


while True:
    nkey = readkey()
    print(nkey)
    nkey = readkey()
    print(nkey)
