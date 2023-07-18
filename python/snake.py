from tkinter import *

width = 800
height = 600
gri_size = 20

class square:
    def __init__(self, x, y, color):
        self.x = x
        self.y = y
        self.color = color
        self.velx = 0
        self.vely = 0
        self.dim = [0,0,0,grid_size, grid_size, grid_size, grid_size, 0]

    def setVel(self, newx, newy):
        self.velx = newx
        self.vely = newy


class Game:
    def __init__(self):
        self.window = Tk()
        self.canvas = Canvas(self.window, bg='black', width=width, height=height)
        self.canvas.pack()

    def run(self):
        while (True):
            self.canvas.after(70)
            self.window.update_idletasks()
            self.window.update()

g = Game()
g.run()