# **** cores.py ****

for letra in ["0", "1", "2", "3", "4", "5", "6", "7"]:
    for bold in ["", ";1"]:
        for fundo in ["0", "1", "2", "3", "4", "5", "6", "7"]:
            seq = "4" + fundo + ";3" + letra
            saida = "\033[" + seq + bold + "m" + (seq + bold).center(8) + "\033[m"
            print("%s" % saida)
        print


# **** cores.py ****

import os
import sys

modules = ["termcolor"]

for module in modules:
    try:
        __import__(module)
    except Exception as e:
        print("Installing modules...")
        os.system("pip3 install " + str(module))
    #        os.system('clear')

for frente in range(8):
    for bold in "", ";1":
        for fundo in range(8):
            seq = "4%d;3%d%s" % (fundo, frente, bold)
            saida = "\033[%sm %s" % (seq, seq.ljust(8))
            sys.stdout.write(saida)
            sys.stdout.write("\033[0m\n")


RED = "\033[1;31m"
BLUE = "\033[1;34m"
CYAN = "\033[1;36m"
GREEN = "\033[0;32m"
RESET = "\033[0;0m"
BOLD = "\033[;1m"
REVERSE = "\033[;7m"
print(RED + "ERROR!" + RESET + "Something went wrong...")
print(BOLD + RED + "ERROR!" + RESET + "Something went wrong...")


class printer:
    _colors_ = {
        **dict.fromkeys(("RED", "ERROR", "NO", "FAIL"), "\033[1;31m"),
        **dict.fromkeys(("GREEN", "OK", "YES", "SUCCESS"), "\033[0;32m"),
        **dict.fromkeys(("YELLOW", "WARN", "MAYBE", "RETRY"), "\033[0;93m"),
        "BLUE": "\033[1;34m",
        "CYAN": "\033[1;36m",
        "RESET": "\033[0;0m",
        "BOLD": "\033[;1m",
        "REVERSE": "\033[;7m",
    }

    def _get_color_(self, key):
        # Gets the corresponding color ANSI code...
        try:
            return self._colors_[key]
        except:
            return self._colors_["RESET"]

    def print(self, msg, color="RESET"):
        # Get ANSI color code.
        color = self._get_color_(key=color)

        # Printing...
        print("{}{}{}".format(color, msg, self._colors_["RESET"]))


p = printer()
p.print(msg="SUCCESS Test...", color="GREEN")
p.print(msg="WARN Test...", color="YELLOW")
p.print(msg="ERROR Test...", color="RED")
p.print(msg="OK Test...", color="OK")
p.print(msg="fail Test...", color="WARN")
p.print(msg="fail Test...", color="FAIL")

from termcolor import colored

print(colored("Error Test!!!", "red"))
print(colored("Warning Test!!!", "yellow"))
print(colored("Success Test!!!", "green"))

from sty import fg, bg, ef, rs

print(fg.red + "ERROR Test!" + fg.rs)
print(fg.li_yellow + "WARNING Test!" + fg.rs)
print(fg.green + "SUCCESS Test!" + fg.rs)
