"""
레이아웃 구성 관련 기능 알아보기
"""

import pandas as pd
import streamlit as st

DATA_PATH = "data/"
df = pd.read_csv(f"{DATA_PATH}loan_grade_train.csv")

# 박스 컨테이너 만들기
with st.container(border=True, height=200):
    st.write(df)

# 옆으로 요소 배치하기
col1, _, col2, _, col3 = st.columns([2, 1, 2, 1, 2])  # [0.6, 0.3, 0.1]
chk1 = col1.checkbox("선택1")
chk2 = col2.checkbox("선택2")
chk3 = col3.checkbox("선택3")
st.write(chk1, chk2, chk3)

tmp = df.groupby("주택소유상태")["이자율"].std().reset_index()
with st.container():
    col_bar, col_scatter = st.columns(2)
    col_bar.bar_chart(tmp, x="주택소유상태", y="이자율")
    col_scatter.scatter_chart(df, x="연간소득", y="대출금액")

# 탭으로 구성된 컨테이너 만들기
tabs_name = ["주택소유상태별 이자율의 표준편차", "연간소득과 대출금액의 산점도"]
tab1, tab2 = st.tabs(tabs_name)
tab1.bar_chart(tmp, x="주택소유상태", y="이자율")
tab2.scatter_chart(df, x="연간소득", y="대출금액")

# 컨테이너 확장 및 축소
import plotly.express as px

expander = st.expander("연간소득의 분포")
px_obj = px.histogram(df, x="연간소득")
expander.plotly_chart(px_obj)
