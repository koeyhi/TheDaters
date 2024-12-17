"""
chart 그리기 기능 알아보기
"""

import pandas as pd
import seaborn as sns
import streamlit as st

DATA_PATH = "data/"
df = pd.read_csv(f"{DATA_PATH}covid.csv")
st.write(df)

# bar chart
tmp = df.groupby("지역")["사망자수"].sum().reset_index()
st.bar_chart(tmp, x="지역", y="사망자수")

# line chart
locations = df["지역"].unique()
location = st.selectbox("지역", locations)
mask = df["지역"] == location
st.line_chart(df.loc[mask], x="날짜", y="확진자수")

st.line_chart(df, x="날짜", y="확진자수", color="지역")

# scatter chart
st.scatter_chart(df.loc[mask], x="확진자수", y="사망자수")

st.scatter_chart(df, x="확진자수", y="사망자수", color="지역", size="사망자수")

# 지도 그리기
agg_dict = {"사망자수": "sum", "위도": "mean", "경도": "mean"}
tmp = df.groupby("지역").agg(agg_dict).reset_index()
tmp["사망자수"] /= 50
st.map(
    tmp,
    latitude="위도",
    longitude="경도",
    size="사망자수",
)

# plotly 라이브러리 활용
import plotly.express as px

px_obj = px.scatter(df, x="사망자수", y="확진자수", color="지역")
st.plotly_chart(px_obj)

# seaborn 라이브러리 활용(한글깨짐 방지 코드 추가해야 함)
import matplotlib.pyplot as plt

plt.rcParams["font.family"] = "Malgun Gothic"  # AppleGothic
plt.rcParams["axes.unicode_minus"] = False

plot = sns.heatmap(df.corr(numeric_only=True), annot=True)
st.pyplot(plot.figure)
