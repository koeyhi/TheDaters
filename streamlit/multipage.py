"""
다중 페이지 앱 만들기
"""

import streamlit as st

# st.Page 함수
## streamlit의 page 객체를 생성하는 함수
## 페이지 객체들을 리스트에 담아 st.navigation에 전달하면 다중 페이지 구성
## page 파라미터: 페이지 소스에 해당하는 콜백함수 또는 py파일의 경로 전달
## title 파라미터: 페이지 제목으로 네비게이션 바에 표시되는 이름

# st.navigation 함수
## 다중 페이지를 구성하는 네비게이션 바 생성
## 이 함수에 반환되는 객체의 run 메서드를 실행해야 함


def page1():
    st.title("1번 페이지 입니다.")


def page2():
    st.title("2번 페이지 입니다.")


pg_list = [
    st.Page("main.py", title="메인 페이지"),
    st.Page(page1, title="1번 페이지"),
    st.Page(page2, title="2번 페이지"),
]

nav = st.navigation(pg_list)
nav.run()
