# coding: utf-8
from progress_bar import InitBar
from progress_bar import *

pbar = InitBar()
# pbar(10)  # update % to 10%
# pbar(20)  # update % to 20%
pbar(15)  # simulate a Microsoft progress bar
# pbar(100) # done

del pbar  # write the newline

print(TerminalSize())
logging.debug("terminal size from termios")

bar = ProgressBar("heading", offset=2, total_width=50)
for i in range(22):
    bar(i)
