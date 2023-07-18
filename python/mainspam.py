from spam import blah
import sys

def main():
    c = blah()
    print(dir(c))
    print(blah.__module__)
    sys.modules['spam']
    print(sys.modules['spam'])

if __name__ == "__main__":
    main()
