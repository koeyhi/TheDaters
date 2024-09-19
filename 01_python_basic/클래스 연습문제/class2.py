class Car:
    total_car = 0

    def __init__(self, brand, model):
        self.brand = brand
        self.model = model
        Car.total_car += 1

    @classmethod
    def total_count(cls):
        return f"총 {cls.total_car}대의 차량이 생성되었습니다."


car1 = Car("Toyota", "Corolla")
car2 = Car("Honda", "Civic")
print(Car.total_count())
