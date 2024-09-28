import random


def rock_scissiors_paper():
    choices = ["rock", "scissors", "paper"]

    while True:
        computer_choice = random.choice(choices)
        user_choice = input("rock, scissors, paper: ")

        if user_choice == "exit":
            print("게임이 종료되었습니다.")
            break
        elif user_choice not in ["rock", "scissors", "paper"]:
            print("올바른 입력이 아닙니다.")
            continue

        print(f"컴퓨터 선택: {computer_choice}, 유저 선택: {user_choice}")  # f-string

        if computer_choice == user_choice:
            print("비겼습니다!")
        elif (
            (computer_choice == "rock" and user_choice == "paper")
            or (computer_choice == "scissiors" and user_choice == "rock")
            or (computer_choice == "paper" and user_choice == "scissors")
        ):  # 조건 여러개
            print("이겼습니다!")
        else:
            print("졌습니다!")


rock_scissiors_paper()
