import streamlit as st
import pandas as pd

st.set_page_config(layout="wide")


def preprocessing_data(df, cat_enc=None, scaler=None):
    cols = [
        "나이",
        "연간소득",
        "주택소유상태",
        "근로기간",
        "대출목적",
        "대출금액",
        "이자율",
        "신용거래기간",
    ]
    df = df[cols].copy()

    df["근로기간"] = df["근로기간"].fillna(4.810612847130737)
    df["이자율"] = df["이자율"].fillna(10.998815774584136)

    from sklearn.preprocessing import OneHotEncoder, MinMaxScaler

    cols = df.select_dtypes("object").columns
    if cat_enc is None:
        cat_enc = OneHotEncoder(handle_unknown="ignore")
        cat_enc.fit(df[cols])

    tmp = cat_enc.transform(df[cols]).toarray()
    df[cat_enc.get_feature_names_out()] = tmp
    df = df.drop(columns=cols)

    if scaler is None:
        scaler = MinMaxScaler()
        scaler.fit(df)

    return scaler.transform(df), cat_enc, scaler


import joblib


@st.cache_data
def get_artifacts(artifacts_path="artifacts/"):
    return (
        joblib.load(f"{artifacts_path}/cat_enc.pkl"),
        joblib.load(f"{artifacts_path}/rf_model.pkl"),
        joblib.load(f"{artifacts_path}/scaler.pkl"),
    )


cat_enc, model, scaler = get_artifacts()

st.header("대출 고객 등급 예측")
with st.container(border=True):
    up_file = st.file_uploader("CSV 파일 업로드")
    if up_file is not None:
        infer_data = pd.read_csv(up_file)
        data, _, _ = preprocessing_data(infer_data, cat_enc, scaler)
        pred = model.predict(data)
        infer_data["고객대출등급"] = pred
        st.write(infer_data)

# 개별 샘플 예측
with st.form("infer_form", border=True):
    cols = [
        "나이",
        "연간소득",
        "주택소유상태",
        "근로기간",
        "대출목적",
        "대출금액",
        "이자율",
        "신용거래기간",
    ]
    data = []

    col1, col2, col3, col4 = st.columns(4)
    col5, col6, col7, col8 = st.columns(4)
    data.append(col1.number_input("나이", step=1))
    data.append(col2.number_input("연간소득", step=1))
    data.append(col3.selectbox("주택소유상태", ["임대", "모기지론", "소유", "기타"]))
    data.append(col4.number_input("근로기간", step=1))
    data.append(
        col5.selectbox(
            "대출목적", ["투자", "개인사업", "교육", "부채통합", "주택개선", "의료"]
        )
    )
    data.append(col6.number_input("대출금액", step=1))
    data.append(col7.number_input("이자율"))
    data.append(col8.number_input("신용거래기간", step=1))

    if st.form_submit_button("예상등급보기"):
        data = pd.DataFrame([data], columns=cols)
        data, _, _ = preprocessing_data(data, cat_enc, scaler)
        pred = model.predict(data)
        st.subheader(f"고객 등급 예측 결과: {pred[0] + 1} 등급")
