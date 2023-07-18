from consolecolor import FontColor as font
from consolecolor import Colors as color

print(font.set_color("hello", color.red, underline=True))
print(font.set_backcolor("hello", color.blue))

def a_function(number):
    # when a_function(value) is called, the calling code is paused
        # then a new scope is created,
            # and a variable called number is created with the argument in it
                # the function's code is then run in the new scope

                    return number + 1  # the function's code stops here, and result is sent to the calling code.


function_result = a_function(41)
                    # calling a_function, where argument is set to 41
                    # function_result is set to the value returned from a_function

print(function_result)  # print is a function too! it returns None
print("Evili")

html_doc = """
                    <html><head><title>The Dormouse's story</title></head>
                    <body>
                    <p class="title"><b>The Dormouse's story</b></p>

                    <p class="story">Once upon a time there were three little sisters; and their names were
                    <a href="http://example.com/elsie" class="sister" id="link1">Elsie</a>,
                    <a href="http://example.com/lacie" class="sister" id="link2">Lacie</a> and
                    <a href="http://example.com/tillie" class="sister" id="link3">Tillie</a>;
                    and they lived at the bottom of a well.</p>

                    <p class="story">...</p>
                    """

from bs4 import BeautifulSoup
soup = BeautifulSoup(html_doc, 'html.parser')
print(soup.prettify())

print(soup.title)
# <title>The Dormouse's story</title>

print(soup.title.name)
# u'title'

print(soup.title.string)
# u'The Dormouse's story'

print(soup.title.parent.name)
# u'head'

print(soup.p)
# <p class="title"><b>The Dormouse's story</b></p>

print(soup.p['class'])
# u'title'

print(soup.a)
# <a class="sister" href="http://example.com/elsie" id="link1">Elsie</a>

print(soup.find_all('a'))
# [<a class="sister" href="http://example.com/elsie" id="link1">Elsie</a>,
#  <a class="sister" href="http://example.com/lacie" id="link2">Lacie</a>,
#  <a class="sister" href="http://example.com/tillie" id="link3">Tillie</a>]

print(soup.find(id="link3"))
# <a class="sister" href="http://example.com/tillie" id="link3">Tillie</a>

for link in soup.find_all('a'):
    print(link.get('href'))
    # http://example.com/elsie
    # http://example.com/lacie
    # http://example.com/tillie
