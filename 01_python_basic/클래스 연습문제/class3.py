class Animal:
    def __init__(self, name):
        self.name = name

    def sound(self):
        print("This animal makes a sound")


class Dog(Animal):
    def sound(self):
        print(f"{self.name} says Bark")


class Cat(Animal):
    def sound(self):
        print(f"{self.name} says Meow")


dog = Dog("Buddy")
cat = Cat("Kitty")

dog.sound()
cat.sound()
