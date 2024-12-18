import pandas as pd
import streamlit as st
import plotly.express as px

st.set_page_config(layout="wide")
DATA_PATH = "data/"

df = pd.read_csv(f"{DATA_PATH}loan_grade_train.csv")

st.header("고객 대출 등급 데이터셋")
with st.expander("데이터 보기"):
    st.write(df)

col_heatmap, col_scatter = st.columns(2, border=True)

px_heatmap = px.imshow(df.corr(numeric_only=True), text_auto=True)
col_heatmap.plotly_chart(px_heatmap)

px_scatter = px.scatter(df, x="나이", y="신용거래기간")
col_scatter.plotly_chart(px_scatter)

with st.container(border=True):
    px_hist = px.histogram(df, x="대출금액", text_auto=True)
    st.plotly_chart(px_hist)


# 사용자와 상호작용하는 막대 차트 만들기
## 범주형 컬럼명, 수치형 컬럼명, 집계 방식
def view_bar_chart(df, cat_col, num_col, agg_func):
    tmp = df.groupby(cat_col)[num_col].agg(agg_func).reset_index()
    st.bar_chart(tmp, x=cat_col, y=num_col)


# view_bar_chart(df, "주택소유상태", "대출금액", "mean")
st.header("Bar chart")
with st.form("bar_chart_form"):
    cat_cols = df.iloc[:, 1:].select_dtypes("object").columns.tolist()
    cat_selected = st.selectbox("범주형 컬럼 선택", cat_cols)

    num_cols = df.iloc[:, :-1].select_dtypes("number").columns.tolist()
    num_selected = st.selectbox("수치형 컬럼 선택", num_cols)

    agg_selected = st.radio("집계 방식 선택", ["mean", "sum", "std"], horizontal=True)

    if st.form_submit_button("그리기"):
        view_bar_chart(df, cat_selected, num_selected, agg_selected)
