class Employee():
    def __init__(self, name, email) -> None:
        self.name = name
        self.email = email

    def send_email(self, who_to, email_to , text):
        print(f'From: {self.name}, {self.email}\nTo: {who_to}, {email_to}\nMessage: {text}')

    def work(self, project):
        print (f'{self.name} is currently working on {project}')

class TeamLead(Employee):
    def __init__(self, name, email) -> None:
        super().__init__(name, email)

    def control(self, who):
        print(f'{self.name} is contolling {who}')

class Junior(Employee):
    def __init__(self, name, email) -> None:
        super().__init__(name, email)
        del Employee.work

class Senior(Employee):
    def __init__(self, name, email) -> None:
        super().__init__(name, email)
        

a = TeamLead('Chris', 'chris@mail.org')
b = Junior('Page', 'page@mail.org')

a.send_email(b.name, b.email, 'where r u?')
a.work('deployment')

# b.work('nothing')

