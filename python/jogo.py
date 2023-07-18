import tkinter

altura  = 1080
largura = 1920

def Area_Rectangulo(largura, altura):
    return largura * altura

print(Area_Rectangulo(largura, altura))


def tic():
    print(tic)

def tac():
    print(tac)

""" Simplified GUI generation using Tkinter

    Copyright (c) 2013 by Florian Berger <fberger@florian-berger.de>
"""

# This file is part of simplegui.
#
# simplegui is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# simplegui is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with simplegui.  If not, see <http://www.gnu.org/licenses/>.

# work started on 22. Jan 2013

# Checked, but insufficient:
#
# pytkmdiapp http://pypi.python.org/pypi/pytkmdiapp/0.1.1
# Grun http://www.manatlan.com/page/grun
# EasyGUI http://easygui.sourceforge.net/

VERSION = "0.1.0"

from tkinter import *

class GUI:
    """Base class for a window to add widgets to.
    """

    def __init__(self):
        """Initialise. Call this first before calling any other Tkinter routines.
        """

        self.root = tkinter.Tk()
        #self.root = Tkinter.Toplevel()

        self.root.title = "simplegui GUI"

        self.frame = tkinter.Frame(master = self.root,
                                   padx = 10,
                                   pady = 10,
                                   width = 800,
                                   height = 600)

        self.frame.pack()

        self.statusbar = tkinter.Label(master = self.frame,
                                       text = "simplegui (Tkinter {0})".format(tkinter.TkVersion))

        self.statusbar.pack()

        return

    def status(self, text):
        """Display the new status text in the status bar.
        """

        self.statusbar["text"] = text

        return

    def run(self):
        """ Run the Tkinter mainloop.
        """

        self.root.mainloop()

        return

    def button(self, label, callback):
        """Add a button.
        """
        tkinter.Button(master = self.frame,
                       text = label,
                       command = callback).pack()

        return

    def listbox(self, stringlist, callback):
        """Add a listbox.
           Klicking an entry in listbox will call callback(entry),
           where entry is a string.
        """

        stringvar = tkinter.StringVar(value = tuple(stringlist))

        listbox = tkinter.Listbox(master = self.frame,
                                  height = len(stringlist),
                                  listvariable = stringvar)

        listbox.pack()

        def callbackwrapper(event):
            callback(event.widget.get(event.widget.curselection()[0]))

        listbox.bind("<<ListboxSelect>>", callbackwrapper)

        return

    def scale(self, scalelabel, callback):
        """Add a scale.
           Moving the scale will call callback(value), where value is a
           float 0..1.
        """

        def callbackwrapper(value):
            callback(int(value) / 100.0)

        tkinter.Scale(master = self.frame,
                                  label = scalelabel,
                                  orient = "horizontal",
                                  length = 100,
                                  showvalue = "true",
                                  sliderlength = 10,
                                  command = callbackwrapper).pack()

        return


simplegui = GUI()
simplegui.run()
