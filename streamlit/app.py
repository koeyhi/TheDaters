import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# 한글깨짐 방지
plt.rcParams["font.family"] = "Malgun Gothic"  # AppleGothic
plt.rcParams["axes.unicode_minus"] = False

# 제목
st.title("📊 Streamlit 데이터 분석 대시보드")

# 파일 업로드
uploaded_file = st.file_uploader("CSV 파일을 업로드하세요", type=["csv"])

# 파일이 업로드된 경우
if uploaded_file is not None:
    # 데이터 불러오기
    df = pd.read_csv(uploaded_file)
    st.write("### 데이터 미리보기")
    st.dataframe(df.head())

    # 데이터 기본 정보
    st.write("### 데이터 정보")
    st.write(f"데이터 행: {df.shape[0]}, 열: {df.shape[1]}")

    # 결측치 확인
    st.write("### 결측치 확인")
    st.write(df.isnull().sum())

    # 컬럼 선택
    st.write("### 컬럼별 데이터 시각화")
    column = st.selectbox("시각화할 컬럼을 선택하세요", df.columns)

    # 시각화
    st.write("### 히스토그램 📊")
    fig, ax = plt.subplots()
    sns.histplot(df[column], kde=True, ax=ax)
    st.pyplot(fig)

    # 상관관계 분석
    st.write("### 상관관계 히트맵 🔥")
    if st.button("상관관계 보기"):
        fig, ax = plt.subplots(figsize=(8, 6))
        sns.heatmap(df.corr(numeric_only=True), annot=True, cmap="coolwarm", ax=ax)
        st.pyplot(fig)

else:
    st.info("CSV 파일을 업로드해주세요.")
