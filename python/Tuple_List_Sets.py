courses = ['History', 'Math', 'Physics', 'CompSci']
teste = list(['Gato', 'Macaco', 'Leao', 'Zebra'])

# print(type(courses))
# print(courses)
# print(type(teste))
# print(teste)

# print(courses[0])
# print(courses[1])
# print(courses[2])
# print(courses[3])
# print(courses[-1])  # ultimo registro

# print(courses[0:2])  # ['History', 'Math']
# print(courses[:2])  # ['History', 'Math']
# print(courses[2:])  # ['Physics', 'CompSci']

# courses.append('Art')
# print(courses)  # ['History', 'Math', 'Physics', 'CompSci', 'Art']

# courses.insert(0, 'Biology')
# print(courses)  # ['History', 'Math', 'Physics', 'CompSci', 'Art']

# courses.insert(0, teste)
# print(courses)  # [['Gato', 'Macaco', 'Leao', 'Zebra'], 'Biology', 'History', 'Math', 'Physics', 'CompSci', 'Art']
# print(courses[0])  # ['Gato', 'Macaco', 'Leao', 'Zebra']

# courses.extend(teste)
# print(courses)  # [['Gato', 'Macaco', 'Leao', 'Zebra'], 'Biology', 'History', 'Math', 'Physics', 'CompSci', 'Art', 'Gato', 'Macaco', 'Leao', 'Zebra']

# courses.remove('History')
# print(courses)  # ['Math', 'Physics', 'CompSci']

# popped = courses.pop()
# print(popped)
# print(courses)  # ['History', 'Math', 'Physics']

# courses.reverse()
# print(courses)  # ['CompSci', 'Physics', 'Math', 'History']

# courses.sort()
# print(courses)  # ['CompSci', 'History', 'Math', 'Physics']

nums = [1, 5, 2, 4, 3]
# nums.sort()
# print(nums)  # [1, 2, 3, 4, 5]

# courses.sort(reverse = True)
# nums.sort(reverse = True)
# print(courses)  # ['Physics', 'Math', 'History', 'CompSci']
# print(nums)  # [5, 4, 3, 2, 1]

# print(min(nums))  # 1
# rint(min(courses))  # CompSci
# print(max(nums))  # 5
# print(max(courses))  # Physics

# print(sum(nums)) # 15

# print(courses.index('CompSci'))  # 3
# print('Art' in courses)  # False
# print('Math' in courses)  # True

# for item in courses:
#    print(item)  # History Math Physics CompSci

# for item in enumerate(courses):
#   print(item)
# (0, 'History')
# (1, 'Math')
# (2, 'Physics')
# (3, 'CompSci')

for index, item in enumerate(courses, start = 1):
    print(index, item)
    # (1, 'History')
    # (2, 'Math')
    # (3, 'Physics')
    # (4, 'CompSci')

courses_str = ', '.join(courses)
print(courses_str)  # History, Math, Physics, CompSci
courses_str = ' - '.join(courses)
print(courses_str)  # History - Math - Physics - CompSci

new_list = courses_str.split(' - ')
print(new_list)  # ['History', 'Math', 'Physics', 'CompSci']

# mutaveis
list_1 = ['History', 'Math', 'Physics', 'CompSci']
list_2 = list_1
print(list_1)
print(list_2)

list_1[0] = 'Art'
print(list_1)
print(list_2)

# Imutaveis
tuple_1 = ('History', 'Math', 'Physics', 'CompSci')
tuple_2 = tuple_1
print(tuple_1)
print(tuple_2)

# tuple_1[0] = 'Art' # Erro
print(tuple_1)
print(tuple_2)

# sets
cs_course = {'C', 'A', 'B', 'D'}
art_course = {'C', 'F', 'B', 'G'}
print(cs_course)
print("B" in cs_course)
print(cs_course.intersection(art_course))
print(cs_course.difference(art_course))
print(cs_course.union(art_course))
# cs_course[0] = 'Art'  # 'set' object does not support item assignment
