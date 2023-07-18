class Employee:
    raise_amount = 1.10
    tot_empregados = 0

    def __init__(self, first, last, pay):
        self.first = first
        self.last = last
        self.pay = pay
        self.email = first + '.' + last + '@gmail.com'
        self.empregados = 0
        Employee.tot_empregados += 1

    def fullname(self):
        yield '{} {}'.format(self.first, self.last)

    def apply_raise(self):
        self.pay = int(self.pay * self.raise_amount)
        return self.pay

    @classmethod
    def set_raise_amt(cls, amount):
        cls.raise_amount = amount

    @classmethod
    def from_string(cls, emp_str):
        first, last, pay = emp_str.split('-')
        return cls(first, last, pay)

    @staticmethod
    def is_workday(day):
        print(day.weekday())
        if day.weekday() == 0 or day.weekday == 7:
            return False
        return True


class Developer(Employee):
    raise_amount = 1.50

    def __init__(self, first, last, pay, prog_lang):
        super(self).__init__(first, last, pay)
        self.prog_lang = prog_lang

    @classmethod
    def from_string(cls, emp_str):
        first, last, pay, prog_lang = emp_str.split('-')
        return cls(first, last, pay, prog_lang)


emp_str1 = 'John-Doe-7000'
emp_str2 = 'Jane-Doe-7000'
emp_str3 = 'Stive-Smith-7000-Clipper'

emp1 = Employee('Vilmar', 'Catafesta', 5000)
emp2 = Employee('Teste', 'User', 5000)
emp3 = Employee.from_string(emp_str1)

dev1 = Developer('Vilmar', 'Catafesta', 5000, 'Python')
dev2 = Developer('Teste', 'User', 5000, 'Java')
dev3 = Developer.from_string(emp_str3)

print(emp1)
print(emp2)
print(emp3)

print(dev1)
print(dev2)
print(dev3)

print(emp1.email)
print(emp2.email)
print(emp3.email)
print(dev1.email)
print(dev2.email)
print(dev3.email)

print(emp1.fullname())
print(emp2.fullname())
print(emp3.fullname())

print(dev1.fullname())
print(dev2.fullname())
print(dev3.fullname())

Employee.raise_amount = 1.10
Employee.set_raise_amt(2.00)

Developer.raise_amount = 1.10
Developer.set_raise_amt(2.00)

for i in emp2.fullname():
    print(emp1.__dict__)
    print(emp1.apply_raise())
    print(i)

print(emp1.__dict__)
print(emp1.empregados)
print(emp2.empregados)
print(Employee.tot_empregados)

import datetime

my_date = datetime.date(2017, 9, 3)
print(Employee.is_workday(my_date))

# print(help(Employee))
# print(help(Developer))
