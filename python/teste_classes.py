class A(object):
    @property
    def x(self):
        "I am the 'x' property."
        return self._x

    @x.setter
    def x(self, value):
        self._x = value

    @x.deleter
    def x(self):
        del self._x


class Celsius:
    def __init__(self, temperature = 0):
        self._temperature = temperature

    def to_fahrenheit(self):
        return (self.temperature * 1.8) + 32

    @property
    def temperature(self):
        print("Getting value")
        return self._temperature

    @temperature.setter
    def temperature(self, value):
        if value < -273:
            raise ValueError("Temperature below -273 is not possible")
        print("Setting value")
        self._temperature = value


class D(object):
    def getx(self): return self._x

    def setx(self, value): self._x = value

    def delx(self): del self._x

    x = property(getx, setx, delx, "I'm the 'x' property.")


c = Celsius()
c.temperature = 100
print(c.temperature)
print(c._temperature)
print(c.to_fahrenheit())

d = D()
d.x = 100
print(d)
print(d.x)
print(d.getx())
print(d.setx(1000))
print(d.getx())
print(d.__doc__)
print(d.__sizeof__())
print(d.__module__)
print(d.__class__)
print(type(d.__class__))
print(d.__getattribute__('x'))
print(d.__hash__())
print(d.__repr__())
print(d.__slots__)
print(d.__str__())
