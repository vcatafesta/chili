# -*- coding: utf-8 -*-

class Colors():
    white  = "white" # default
    red    = "red"
    green  = "green"
    brown  = "brown"
    pink   = "pink"
    violet = "violet"
    blue   = "blue"
    black  = "black"

class FontColor():
    white     = "\033[30;"  # default
    red       = "\033[31;"
    green     = "\033[32;"
    brown     = "\033[33;"
    pink      = "\033[34;"
    violet    = "\033[35;"
    blue      = "\033[36;"
    black     = "\033[37;"

    white_background  = "\033[40;"  # default
    red_background    = "\033[41;"
    green_background  = "\033[42;"
    brown_background  = "\033[43;"
    pink_background   = "\033[44;"
    violet_background = "\033[45;"
    blue_background   = "\033[46;"
    black_background  = "\033[47;"
    default           = "0m"  # default
    underline         = "4m"
    end               = "\033[0m"

    @classmethod
    def set_color(self, text, color="white", underline=False):
        if hasattr(self, color):
            if underline:
                return getattr(self, color) + self.underline + text + self.end
            else:
                return getattr(self, color) + self.default + text + self.end
        else:
            return text

    @classmethod
    def set_backcolor(self, text, backcolor="white", underline=False):
        color = backcolor + "_background"
        if hasattr(self, color):
            if underline:
                return getattr(self, color) + self.underline + text + self.end
            else:
                return getattr(self, color) + self.default + text + self.end
        else:
            return text

if __name__ == "__main__":
    for i in range(0, 48):
        print("{} \033[{};1mhello\033[0m".format(i, str(i)))

    print("\033[31;1mhello\033[0m")
    print("\033[31;4mhello\033[0m")
    print("\033[41;1mhello\033[0m")
    print("\033[41;4mhello\033[0m")
    print(FontColor.green + FontColor.default + "hello" + FontColor.end)
    print(FontColor.green + FontColor.underline + "hello" + FontColor.end)
    print(FontColor.green_background + FontColor.default + "hello" + FontColor.end)
    print(FontColor.green_background + FontColor.underline + "hello" + FontColor.end)
    print(FontColor.set_color('Vilmar', "red"))
    print(FontColor.set_color("Vilmar", Colors.green))
    print(FontColor.set_color("Vilmar", Colors.green, underline=True))
    print(FontColor.set_backcolor("Vilmar", Colors.blue))
    print(FontColor.set_backcolor("Vilmar", Colors.blue, underline=True))
