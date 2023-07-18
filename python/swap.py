import sys
import string

a1 = 10
b1 = 20

print a1, b1
a1,b1 = b1,a1
print(a1, b1)

class CodeGeneratorBackend:
    def begin(self, tab="\t"):
        self.code = []
        self.tab = tab
        self.level = 0

    def end(self):
        self.code.append("") # make sure there's a newline at the end
        return compile(string.join(self.code, "\n"), "<code>", "exec")

    def write(self, string):
        self.code.append(self.tab * self.level + string)

    def indent(self):
        self.level += 1

    def dedent(self):
        if self.level == 0:
            raise SyntaxError, "internal error in code generator"
            self.level -= 1

def main():
    c = CodeGeneratorBackend()
    c.begin()
    c.write("for i in range(5):")
    c.indent()
    c.write("print 'code generation made easy!'")
    c.dedent()
    exec c.end()
    return

if __name__ == "__main__":
    main()
    print __name__

def erro(msg):
    print "Erro:", msg
    sys.exit(1)

def inc(x):
    return x + 1

def dec(x):
    return x - 1

def quadrado(x):
    return x ** 2

print inc(10)  # deve mostrar 11
print dec(10)  # deve mostrar 9
print quadrado(5)  # deve mostrar 25

