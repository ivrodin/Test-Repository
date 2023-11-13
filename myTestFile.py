class NotChangableDescriptor:

    @classmethod
    def validate_instance_name(cls, instance, name):
        if not getattr(instance, name, None):
            raise TypeError

    def __set_name__(self, owner, name):
        self.name = '_' + name

    def __get__(self, instance, owner = None):
        return getattr(instance, self.name)
    
    def __set__(self, instance, value):
        print(instance.__dict__)
        # self.validate_instance_name(instance, self.name)
        if instance.__dict__.get(self.name, None) is None:
            setattr(instance, self.name, value)

class TestClass:
    a = NotChangableDescriptor()
    b = NotChangableDescriptor()

    def __init__(self, a, b) -> None:
        self.a = a
        self.b = b


tst = TestClass(1,2)
print(tst.__dict__)
tst.a = 3 

print(tst.__dict__)

# print(tst.__a)

# print(TestClass.a) # 'NoneType' object has no attribute '__a'