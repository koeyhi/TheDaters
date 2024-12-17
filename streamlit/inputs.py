"""
사용자의 입력 등 상호작용을 하는 요소들 알아보기
"""

import pandas as pd
import streamlit as st

DATA_PATH = "data/"
df = pd.read_csv(f"{DATA_PATH}loan_grade_train.csv")

# st.button
## 버튼을 화면에 렌더링하고, 클릭 시 True 반환

## 다른 작업을 수행해도 텍스트가 사라지지 않게 함
# 세션 상태 초기화
if "button_clicked" not in st.session_state:
    st.session_state.button_clicked = False

# 버튼 클릭 이벤트
if st.button("확인"):
    st.session_state.button_clicked = True  # 클릭 상태를 저장

# 클릭 상태에 따라 텍스트 표시
if st.session_state.button_clicked:
    st.text("확인되었습니다.")

# if st.button("확인"):
#     st.text("확인되었습니다.")

# st.download_button
## 파일을 다운로드 할 수 있는 함수로, 클릭 시 다운로드 수행
## mime: 인터넷을 통한 파일 전송 시 표준 파일 형식
st.download_button(
    "CSV 다운로드",  # 버튼 이름
    df.to_csv(index=False),  # 데이터 객체 전달
    "다운로드.csv",  # 다운로드된 파일이름
    "text/csv",  # mime type
)

with open(f"{DATA_PATH}titanic.png", "rb") as f:
    st.download_button("이미지 다운로드", f, "다운로드.png", "image/png")

# 링크 이동 버튼
st.link_button("네이버 새 창으로 열기", "https://www.naver.com")

# 체크박스 버튼
if st.checkbox("I agree"):
    st.text("체크 완료")
else:
    st.text("체크 미완료")

# 토글 버튼
if st.toggle("데이터 보기"):
    st.write(df)

# 라디오 버튼
radio_list = ["아이템1", "아이템2", "아이템3"]
item_radio = st.radio("원하는 아이템 선택", radio_list, index=None)
st.write(f"{item_radio} 선택되었습니다.")

# selectbox
select_list = ["아이템1", "아이템2"]
item_select = st.selectbox("원하는 아이템 선택", select_list)
st.text(item_select)

# 다중 선택 가능한 selectbox(선택된 아이템들이 리스트에 담겨 반환)
lst = st.multiselect("원하는 아이템 선택", ["컬럼1", "컬럼2", "컬럼3", "컬럼4"])
st.write(lst)

# 슬라이더 버튼
## 버튼 레이블, 최소값, 최대값, 기본값, step
s = st.slider("당신의 연봉은?(만단위)", 3000, 15000, 5000, 100)
st.text(f"{s} 만원")

# 텍스트 입력 버튼
name = st.text_input("이름", placeholder="이름")
st.text(name)

# 숫자 입력 버튼
number = st.number_input("나이", 0, 100, None, placeholder="나이")
st.text(number)

# 날짜 입력 버튼
import datetime

min_value = datetime.date(2000, 1, 1)
max_value = datetime.date(2024, 12, 31)
date_value = st.date_input("상담일자 선택", min_value=min_value, max_value=max_value)
st.write(date_value)

# text area
txt = st.text_area("내용 입력", placeholder="상담 내용을 입력하세요.", height=300)
st.text(txt)

# 파일 업로드
## 파일 첨부가 안되어 있을 경우 None 반환
up_file = st.file_uploader("CSV 파일 업로드")
if up_file is not None:
    data = pd.read_csv(up_file)
    st.write(data)

# form 전송
## 입력 받은 데이터를 한 번에 서버로 전송
## 첫 번째 인수로 form을 html 문서 내에서 유일하게 식별할 수 있는 문자열 전달
with st.form("my_form"):
    st.write("form데이터 서버에 전송해보기")
    slider_val = st.slider("몸무게")
    number_val = st.number_input("나이", step=1)

    # 버튼 클릭 시 True 반환
    # True 반환 시 form 안에 있는 input 요소들의 값이 서버로 전달
    if "submit_clicked" not in st.session_state:
        st.session_state.submit_clicked = False

    if st.form_submit_button():
        st.session_state.submit_clicked = True

    if st.session_state.submit_clicked:
        st.write(slider_val, number_val)
