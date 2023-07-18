student = {'name': 'John', 'age': 25, 'courses': ['Math', 'CompSci']}

print(student)
print(student['name'])
print(student['age'])
print(student['courses'])
print(student.get('courses'))

student['fone'] = '555-5555'
print(student.get('fone', 'Nao encontrado'))
print(student.get('cida', 'Nao encontrado'))

student['name'] = 'VILMAR'
print(student)

student.update({'name': 'Jane', 'age': 26, 'fone': '3451-3085'})
print(student)

del student['courses']
print(student)
