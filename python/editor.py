from Tkinter import *
import os


def Load():
    global loadf
    loadtop = Toplevel()
    loadtop.title = ("Load")
    loadf = Entry(loadtop)
    loadf.pack()
    loadb = Button(loadtop, text = "Load", command = Load2)
    loadb.pack()


def Load2():
    in_file = open(loadf, "r")
    text = in_file.read()
    in_file.close()


def Print():
    printer = os.popen('lpq', 'w').readlines()
    printer.write(text.get("1.0", END))
    printer.close()


def Save2():
    fileObj = open(str(saven), "w")
    fileObj.write(text.get("1.0", END))
    fileObj.close()


def Save():
    global saven
    top = Toplevel()
    top.title("Save")
    saven = Entry(top)
    saven.pack()
    button = Button(top, text = "Save", command = Save2)
    button.pack()


if __name__ == "__main__":
    root = Tk()
    root.geometry("650x400")
    root.title("Macrosot Editor")

    textframe = Frame(root)

    text = Text(textframe)
    save_button = Button(textframe, text = "Save", command = Save)
    load_button = Button(textframe, text = "Load", command = Load)
    load_button.pack(side = LEFT)
    text.pack(side = LEFT, fill = X, expand = 1)
    save_button.pack(side = LEFT)

    print_button = Button(textframe, text = "Print", command = Print)
    print_button.pack(side = RIGHT)

    textframe.pack(fill = X)

    root.mainloop()
