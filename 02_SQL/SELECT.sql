-- Active: 1726199206839@@127.0.0.1@3306@mydata
USE mydata;

SELECT DATABASE();

SHOW TABLES;

SELECT * FROM tb_titanic;

/*
passengerid: 승객 id
survived: 생존 여부(0: 사망, 1: 생존)
pclass: 객실 등급(1,2,3)
gender: 성별
age: 나이
sibsp: 동반한 형제 또는 자매 또는 배우자 수
parch: 동반한 부모 또는 자식의 수
ticket: 티켓번호
fare: 운임료
cabin: 객실번호
embarked: 탑승항구(C: 프랑스, S: 영국, Q: 아일랜드)
*/

-- 컬럼을 선택해서 조회 가능
SELECT name, age FROM tb_titanic;

-- 조회한 컬럼명에 대해 별칭을 부여할 수 있다.
-- 기본적으로 "" 생략 가능하나, 문자열 중간에 공백이 있을 경우 "" 사용해야 함
SELECT name AS 이름, age AS 나이 FROM tb_titanic;

SELECT name "이 름", age 나이 FROM tb_titanic;

# WHERE를 이용하여 조건에 따라 조회하기
SELECT * FROM tb_titanic WHERE survived = 1;

-- 비교 연산자의 `같다` 만 파이썬과 다르고 나머지는 똑같다.
SELECT * FROM tb_titanic WHERE survived != 1;

SELECT * FROM tb_titanic WHERE age > 59;

-- is null
SELECT * FROM tb_titanic WHERE age IS NULL;

-- is not null
SELECT * FROM tb_titanic WHERE age IS NOT NULL;

-- 특정 문자열이 포함되어 있는지 조회
-- 대소문자 구분 안함
SELECT * FROM tb_titanic WHERE name LIKE '%miss.%';

-- 대소문자 구분하려면 BINARY 키워드 사용
SELECT * FROM tb_titanic WHERE BINARY name LIKE '%Miss.%';

-- AND
SELECT * FROM tb_titanic WHERE survived = 1 AND gender = "female";

-- OR
-- 기혼 여성이거나 미혼 여성인 승객 조회하기
SELECT *
FROM tb_titanic
WHERE
    name LIKE "%mrs%"
    OR name LIKE "%miss%";

-- IN, NOT IN
SELECT * FROM tb_titanic WHERE embarked IN ('C', 'S');

SELECT * FROM tb_titanic WHERE embarked NOT IN('C', 'S');

-- 구간 조회
SELECT * FROM tb_titanic WHERE age BETWEEN 20 AND 40;
-- age >= 20 and age <= 40

# 조회 결과 정렬하기
-- 오름차순
SELECT * FROM tb_titanic WHERE survived = 1 ORDER BY fare ASC;

-- 내림차순
SELECT * FROM tb_titanic WHERE survived = 1 ORDER BY fare DESC;

# 산술연산
SELECT name, sibsp + parch AS add_sibsp_parch FROM tb_titanic;

SELECT name, sibsp - parch AS sub_sibsp_parch FROM tb_titanic;

SELECT name, sibsp * parch AS mul_sibsp_parch FROM tb_titanic;

SELECT name, sibsp / parch AS div_sibsp_parch FROM tb_titanic;

SELECT name, sibsp % parch AS div_sibsp_parch FROM tb_titanic;

-- 정규표현식
-- Miss. , Mrs. , Mr. , Ms.
SELECT * FROM tb_titanic WHERE name REGEXP "M[rsi]{1,3}[.]";

# 함수 사용하기
-- 중복 제거하기
SELECT DISTINCT (cabin) FROM tb_titanic;

-- 조회된 결과의 총 개수 확인하기(null 무시)
SELECT COUNT(passengerid) FROM tb_titanic;

-- 합계 함수(null 무시)
SELECT SUM(fare) FROM tb_titanic;

-- 평균 함수(null 무시)
SELECT AVG(fare) FROM tb_titanic;

-- 표준편차(null 무시)
SELECT STD(fare) FROM tb_titanic;

-- pclass 1등급의 운임료 표준편차와 3등급의 운임료의 표준편차 확인해보기
SELECT STD(fare) FROM tb_titanic WHERE pclass = 1;

SELECT STD(fare) FROM tb_titanic WHERE pclass = 3;

-- 분산
SELECT VARIANCE(fare) FROM tb_titanic;

-- 거듭제곱
SELECT POW(STD(fare), 2) FROM tb_titanic;

-- 최대값
SELECT MAX(fare) FROM tb_titanic;

-- 최소값
SELECT MIN(fare) FROM tb_titanic;

-- 생존자의 나이에 대한 평균과 표준편차
SELECT AVG(age), STD(age) FROM tb_titanic WHERE survived = 1;

-- 사망자의 나이에 대한 평균과 표준편차
SELECT AVG(age), STD(age) FROM tb_titanic WHERE survived = 0;

-- 3등급(pclass)에 대한 생존률
SELECT AVG(survived) FROM tb_titanic WHERE pclass = 3;

-- 1등급 생존률, 2등급 생존률, 전체 생존률, 여성 생존률을 각각 조회해서 의견보내기
SELECT AVG(survived) FROM tb_titanic WHERE pclass = 1;

SELECT AVG(survived) FROM tb_titanic WHERE pclass = 2;

SELECT AVG(survived) FROM tb_titanic;

SELECT AVG(survived) FROM tb_titanic WHERE gender = "female";

# 등급이 높을수록 생존률이 높지만, 2등급 생존률은 평균 생존률과 크게 차이나지 않음. 여성이 남성보다 생존률이 높음.
# 1, 2등급 여성은 생존률이 매우 높고, 3등급 여성은 생존률이 평균보다 조금 윗도는 정도임.

SELECT AVG(survived)
FROM tb_titanic
WHERE
    pclass = 1
    AND gender = "female";

-- 10세 미만의 생존률
SELECT AVG(survived) FROM tb_titanic WHERE age BETWEEN 0 AND 9;

-- 생존자에 대한 sibsp 와 parch 의 평균
SELECT AVG(sibsp), AVG(parch) FROM tb_titanic WHERE survived = 1;

-- 사망자에 대한 sibsp 와 parch 의 평균
SELECT AVG(sibsp), AVG(parch) FROM tb_titanic WHERE survived = 0;

# SELECT 절 조건 주기
-- IFNULL
SELECT IFNULL(cabin, "알수없음") FROM tb_titanic;

-- IF
SELECT IF(gender = "male", "남자", "여자") FROM tb_titanic;

-- Mr. 생존률, Mrs. 생존률, Miss. 생존률, Ms. 생존률
SELECT
    AVG(
        IF(
            name LIKE "%Mr.%",
            survived,
            NULL
        )
    ) mr_rate,
    AVG(
        IF(
            name LIKE "%Mrs.%",
            survived,
            NULL
        )
    ) mrs_rate,
    AVG(
        IF(
            name LIKE "%Miss.%",
            survived,
            NULL
        )
    ) miss_rate,
    AVG(
        IF(
            name LIKE "%Ms.%",
            survived,
            NULL
        )
    ) ms_rate
FROM tb_titanic;

-- ONE HOT ENCODING
-- embarked: C, Q, S
-- C | Q | S
-- 1 | 0 | 0 # C항구
-- 0 | 1 | 0 # Q항구
-- 0 | 0 | 1 # S항구

SELECT IF(embarked = "C", 1, 0) C, IF(embarked = "Q", 1, 0) Q, IF(embarked = "S", 1, 0) S
FROM tb_titanic;

-- CASE 문
SELECT
    CASE
        WHEN embarked = "C" THEN "프랑스 항구"
        WHEN embarked = "Q" THEN "아일랜드 항구"
        ELSE "영국 항구"
    END AS em
FROM tb_titanic;

-- COUNT ENCODING(범주의 빈도수로 인코딩해주는 기법)
SET
    @embarked_c = (
        SELECT COUNT(embarked)
        FROM tb_titanic
        WHERE
            embarked = "c"
    );

SET
    @embarked_q = (
        SELECT COUNT(embarked)
        FROM tb_titanic
        WHERE
            embarked = "q"
    );

SET
    @embarked_s = (
        SELECT COUNT(embarked)
        FROM tb_titanic
        WHERE
            embarked = "s"
    );

SELECT
    CASE
        WHEN embarked = "C" THEN @embarked_c
        WHEN embarked = "Q" THEN @embarked_q
        ELSE @embarked_s
    END emb_count
FROM tb_titanic;

# GROUP BY
-- 데이터 그룹화
-- 데이터의 특정 컬럼을 기준으로 동일한 값끼리 그룹화하여 집계할 때 사용
-- 동일한 값을 가진 행들을 하나의 그룹으로 묶어주는 역할

-- pclass 별 평균 나이를 알고 싶다면?

# GROUP BY 미사용
SELECT AVG(age) FROM tb_titanic WHERE pclass = 1;

SELECT AVG(age) FROM tb_titanic WHERE pclass = 2;

SELECT AVG(age) FROM tb_titanic WHERE pclass = 3;

# GROUP BY 사용
SELECT pclass, AVG(age)
FROM tb_titanic
GROUP BY
    pclass
ORDER BY pclass;

--  pclass 별 생존률이 알고 싶다면?
SELECT pclass, AVG(survived)
FROM tb_titanic
GROUP BY
    pclass
ORDER BY pclass;

-- embarked 별 생존률
SELECT embarked, AVG(survived)
FROM tb_titanic
WHERE
    embarked IS NOT NULL
GROUP BY
    embarked;

-- gender 별 생존률
SELECT gender, AVG(survived) FROM tb_titanic GROUP BY gender;

-- survived 별 나이와 운임료의 평균과 표준편차
SELECT
    survived,
    AVG(age) AS age_avg,
    STD(age) AS age_std,
    AVG(fare) AS fare_avg,
    STD(fare) AS fare_std
FROM tb_titanic
GROUP BY
    survived;

-- 각 pclass 에 대하여 gender 별 생존률
SELECT pclass, gender, AVG(survived) AS result
FROM tb_titanic
GROUP BY
    pclass,
    gender
ORDER BY pclass, gender;

-- 각 embarked 에 대하여 pclass 별 생존률
SELECT embarked, pclass, AVG(survived) AS result
FROM tb_titanic
WHERE
    embarked IS NOT NULL
GROUP BY
    embarked,
    pclass
ORDER BY embarked;

# 등급이 높을수록 생존률 높음, embarked가 S 일 때 생존률이 가장 낮음,
# embarked가 q이고 등급이 2일 때 생존률이 많이 낮은데 이는 나이가 20~30 인 인원이 대부분이기 때문인 것으로 보여짐

-- Q항구에 대해 pclass 별 여성의 비율과, 나이의 평균
SELECT pclass, AVG(gender = "female") AS female_rate, AVG(age) AS age_avg
FROM tb_titanic
WHERE
    embarked = "Q"
GROUP BY
    pclass
ORDER BY pclass;
-- q 항구의 경우 3등급에 여자 비율이 높은 편이고, 평균 연령도 낮기 때문에
-- 다른 항구의 3등급에 비해 생존률이 높아진 것으로 추측된다.

-- 남성 승객들 중에 각 항구에 대하여 객실 등급별 생존률 확인
SELECT
    embarked,
    pclass,
    AVG(survived) AS survived_rate,
    COUNT(passengerid)
FROM tb_titanic
WHERE
    gender = "male"
GROUP BY
    embarked,
    pclass
ORDER BY embarked, pclass;

-- 각 탑승항구(embarked) 에 대하여 생존여부(survived) 별 특징
-- 가족수(sibsp+parch) 평균, 운임료 평균, 티켓번호(ticket) 고유값 개수, cabin 고유값 개수
-- 가족이 없는 승객의 비율

SELECT
    embarked,
    survived,
    AVG(sibsp + parch) AS avg_family,
    AVG(fare) AS avg_fare,
    COUNT(DISTINCT ticket) AS count_ticket,
    COUNT(DISTINCT cabin) AS count_cabin,
    AVG(sibsp + parch = 0) AS alone_rate
FROM tb_titanic
WHERE
    embarked IS NOT NULL
GROUP BY
    embarked,
    survived
ORDER BY embarked, survived;

# HAVING 절
-- GROUP BY 집계 결과에 대한 조건 부여

-- 객실번호(cabin)별 생존률이 0.6 이상의 객실만 보고 싶다면?
SELECT cabin, AVG(survived) AS survived_rate, AVG(fare)
FROM tb_titanic
GROUP BY
    cabin
HAVING
    survived_rate >= 0.6
ORDER BY survived_rate DESC;

-- 객실번호(cabin)별로 티켓번호(ticket)의 고유값 개수가 1개인 객실들만 조회
SELECT cabin, COUNT(DISTINCT ticket) nunique_ticket
FROM tb_titanic
WHERE
    cabin IS NOT NULL
GROUP BY
    cabin
HAVING
    nunique_ticket = 1;

# LIMIT 절
-- 조회결과에 대해 행 범위 지정
-- 행번호는 0번부터 시작
-- LIMIT 시작행번호, 조회할 개수
SELECT * FROM tb_titanic LIMIT 10, 5;

SELECT * FROM tb_titanic LIMIT 5;
-- 시작행번호가 자동으로 0으로 세팅

# SQL 실행 순서
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT
SELECT cabin, COUNT(DISTINCT ticket) nunique_ticket
FROM tb_titanic
WHERE
    cabin IS NOT NULL
GROUP BY
    cabin
HAVING
    nunique_ticket = 1
ORDER BY cabin
LIMIT 0, 5;