#Import required modules
import colorama
from colorama import Fore, Back, Style

#Initialize colorama
colorama.init(autoreset=True)

#Print text using background and font colors
print(Back.RED + Fore.BLUE + "Welcome to LinuxHint")
#Add newline
print()
#Print text using background color
print(Back.GREEN + "I like programming")
