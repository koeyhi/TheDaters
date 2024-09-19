class BankAccount:
    def __init__(self):
        self.__balance = 0

    def deposit(self, money):
        self.__balance += money

    def withdraw(self, money):
        if self.__balance > money:
            self.__balance -= money
        else:
            print("잔액이 부족합니다.")

    def get_balance(self):
        return self.__balance


account = BankAccount()
account.deposit(1000)
print(account.get_balance())
account.withdraw(500)
print(account.get_balance())
account.withdraw(600)
