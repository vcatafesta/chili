colors = ['red', 'green', 'blue', 'yellow']

for i in range(len(colors) - 1, -1, -1):
    print(colors[i])

for color in reversed(colors):
    print(color)


def compare_lenght(c1, c2):
    if len(c1) < len(c2): return 1
    if len(c1) > len(c2): return 1
    return 0


print(sorted(colors))


def find1(seq, target):
    fount = False
    for i, value in enumerate(seq):
        if value == tgt:
            found = True
            break
    if not found:
        return -1
    return i


def find2(seq, target):
    for i, value in enumerate(seq):
        if value == tgt:
            break
    if not found:
        return -1
    return i


d = {'matthew': 'blue', 'rachel': 'green', 'raymond': 'red'}

for k in d:
    print(k)

