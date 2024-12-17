"""
텍스트 데이터, 미디어를 화면에 표시하는 기능 사용해보기
"""

import pandas as pd
import streamlit as st

DATA_PATH = "data/"
df = pd.read_csv(f"{DATA_PATH}loan_grade_train.csv")

# st.write
## 문자열 뿐만 아니라 객체도 화면에 표시(print와 비슷)
st.write(df)

# 텍스트 관련 함수
st.title("제목 텍스트")
st.header("헤더 텍스트")
st.subheader("하위 헤더 텍스트")
st.text("텍스트")

# st.markdown
## 마크다운 문서 렌더링
md_text = """
# 마크다운
- 목록1
- 목록2
```python
for i in range(10):
    print(i)
```
"""
st.markdown(md_text)

# st.code
## language 파라미터에 프로그래밍 언어 문자열 전달(기본값 파이썬)
code_text = """
import numpy
arr = np.array([1,2,3])
"""
st.code(code_text)

import time

text_obj = st.text("데이터 불러오는 중 ...")
time.sleep(1)
text_obj.text("완료")

# st.latex
## 라텍스 문법으로 렌더링
st.latex(r"""{\displaystyle f(x)=x^{+}=\max(0,x)}""")

# st.image
## 이미지 렌더링
## 첫 번째 인수로 이미지 경로 지정(url, ndarray 가능)
st.image(f"{DATA_PATH}titanic.png")

# st.audio
## 오디오 렌더링
with open(f"{DATA_PATH}titanic.mp3", "rb") as f:
    st.subheader("타이타닉 피아노 버전")
    audio_data = f.read()
    st.audio(audio_data, format="audio/mpeg")

# st.audio(f"{DATA_PATH}titanic.mp3")

# st.video
## 영상 렌더링
with open(f"{DATA_PATH}titanic_trailer.mp4", "rb") as f:
    st.subheader("타이타닉")
    video_data = f.read()
    st.video(video_data)

# st.video(f"{DATA_PATH}titanic_trailer.mp4")

# 스트림 출력
text = "Streamlit은 데이터 과학 및 머신러닝 프로토타이핑 개발을 위해 사용되는 유용한 파이썬 오픈소스 라이브러리입니다."


def stream_data(text):
    for c in text:
        yield c
        time.sleep(0.1)


gen = stream_data(text)
st.write_stream(gen)
