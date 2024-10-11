import pandas as pd

# df = pd.read_csv("C:/Users/kwon3/Desktop/Netflix Userbase.csv")

# df["Join Date"] = pd.to_datetime(df["Join Date"], format="%d-%m-%y").dt.strftime(
#     "%y-%m-%d"
# )
# df["Last Payment Date"] = pd.to_datetime(
#     df["Last Payment Date"], format="%d-%m-%y"
# ).dt.strftime("%y-%m-%d")

# df.to_csv("C:/Users/kwon3/Desktop/converted_file.csv", index=False)
DATA_PATH = "data/"
df = pd.read_csv(f"{DATA_PATH}converted_file.csv")
df
