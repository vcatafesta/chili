#Import required module
from colorama import Fore, Back, Style

#Print text using font color
print(Fore.CYAN + 'Welcome to Linuxhint')
#Print text using background color and DIM style
print(Back.YELLOW + Style.DIM + 'Learn Python', end='')
#Reset all style
print(Style.RESET_ALL)
#Print text using font color and BRIGHT style
print(Fore.RED + Style.BRIGHT + 'Bright Text', end='')
#Print reset all style again
print(Style.RESET_ALL)
#Print text without any color and normal style
print(Style.NORMAL + 'Normal Text')
