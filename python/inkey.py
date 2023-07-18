from msvcrt import getch
while True:
    print("Tecle um tecla: ");
    key = ord(getch())
    print(key)
    if key == 0 or key == 27:
        exit(0)
