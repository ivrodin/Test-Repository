"""
Description
Create a class SchoolMember that represents any person in school. Classes Teacher and Student are inherited from SchoolMember.

Classes should have the same interface as the public show () method. Teacher accepts name (str), age (int), and salary (int). Student accepts name (str), age (int), and grades. Move the same logic of initialization to the class SchoolMember.

Method show() returns a string (see string patterns in the Example).

All attributes that were accepted should be public.

Example
>>> teacher = Teacher("Mr.Snape", 40, 3000)
>>> teacher.name
"Mr.Snape"

>>> persons = [teacher, Student("Harry", 16, 75)]

>>> for person in persons:
       print(person.show())

"Name: Mr.Snape, Age: 40, Salary: 3000"
"Name: Harry, Age: 16, Grades: 75"
"""

# Complete the following code according to the task in README.md.
# Don't change names of classes. Create names for the variables
# exactly the same as in the task.
class SchoolMember:
    pass


class Teacher:
    pass


class Student:
    pass

