class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def introduce(self):
        print(f"이름: {self.name}, 나이: {self.age}")


person1 = Person("John", 25)
person1.introduce()
