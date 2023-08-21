# -*- coding: utf-8 -*-
# 设置pycharm控制台字体颜色
# 代码格式：\033[显示方式;前景色;背景色m code \033[0m

class Colors():
    # 颜色枚举
    white = "white" # default
    red = "red"
    green = "green"
    brown = "brown"  # 棕色
    Pink = "Pink"
    Violet = "Viole"  #紫色
    blue = "blue"
    black = "black"

class FontColor():
    """不同的版本可能颜色不一样
    调用方式：颜色/背景色/+下划线标志 + 需要加颜色的文字 + 结束标志
    """
    # 颜色码
    white = "\033[30;"  # default
    red = "\033[31;"
    green = "\033[32;"
    brown = "\033[33;"
    Pink = "\033[34;"
    Violet = "\033[35;"  # 紫色
    blue = "\033[36;"
    black = "\033[37;"

    # 背景色
    white_background = "\033[40;"  # default
    red_background = "\033[41;"
    green_background = "\033[42;"
    brown_background = "\033[43;"
    Pink_background = "\033[44;"
    Violet_background = "\033[45;"  # 紫色
    blue_background = "\033[46;"
    black_background = "\033[47;"

    # 下划线标志
    default = "0m"  # default
    underline = "4m"

    # 结束标志位
    end = "\033[0m"

    # 设置字体色方法
    @classmethod
    def set_color(self, text, color="white", underline=False):
        if hasattr(self, color):
            if underline:
                return getattr(self, color) + self.underline + text + self.end
            else:
                return getattr(self, color) + self.default + text + self.end
        else:
            return text

    # 设置背景色
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
    # 颜色测试
    for i in range(30, 48):
        print("{} \033[{};1mhello\033[0m".format(i, str(i)))

    # 1.原始调用方式：
    print("\033[31;1mhello\033[0m")  # 红色

    print("\033[31;4mhello\033[0m")  # 红色加下划线

    print("\033[41;1mhello\033[0m")  # 红色背景

    print("\033[41;4mhello\033[0m")  # 红色背景加下划线

    # 2.通过FontColor类变量设置
    # 绿色
    print(FontColor.green + FontColor.default + "hello" + FontColor.end)

    # 绿色加下划线
    print(FontColor.green + FontColor.underline + "hello" + FontColor.end)

    # 绿色背景
    print(FontColor.green_background + FontColor.default + "hello" + FontColor.end)

    # 绿色背景加下划线
    print(FontColor.green_background + FontColor.underline + "hello" + FontColor.end)

    # 3.通过FontColor类方法设置
    print(FontColor.set_color("你好", "red"))  # 红色

    print(FontColor.set_color("你好", Colors.green))  # 绿色

    #  绿色加下划线
    print(FontColor.set_color("你好", Colors.green, underline=True))

    print(FontColor.set_backcolor("你好", Colors.blue))  # 蓝色背景

    #  蓝色背景加下划线
    print(FontColor.set_backcolor("你好", Colors.blue, underline=True))
