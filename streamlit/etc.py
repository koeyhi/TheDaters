import streamlit as st
import time


@st.cache_data()  # persist="disk"
def get_data():
    lst = []
    for i in range(5):
        time.sleep(1)
        lst.append(i)

    return lst


st.write(get_data())

# 메시지 관련 기능
st.success("성공 메시지", icon="🔥")
st.info("정보 메시지")
st.warning("경고 메시지")
st.error("에러 메시지")
st.toast("짧은 메시지 표시")
st.balloons()
st.snow()

# 프로그레스 바 표시
my_bar = st.progress(0)
for p in range(1, 100):
    time.sleep(0.05)
    my_bar.progress(p, text="다운로드 중...")
my_bar.progress(100, text="다운로드 완료")
time.sleep(1)
my_bar.empty()  # 해당 객체 화면에서 사라지게 하는 메소드
