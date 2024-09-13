# MySQL 주석
-- 한줄 주석
# 한줄 주석
/*
여러 줄 주석
...
*/

# DDL
-- 데이터베이스와 테이블을 정의하는 언어
-- 학습내용: database 와 table 생성, 수정, 삭제

## 데이터베이스 생성하기
CREATE DATABASE shop;

## 데이터베이스 삭제하기
DROP DATABASE IF EXISTS shop;

## 데이터베이스 목록 확인하기
SHOW DATABASES;

## 선택된 데이터베이스 확인해보기
SELECT DATABASE();

## 데이터베이스 선택하기
USE shop;

## 테이블 생성하기
CREATE TABLE tb_user (
    user_id int,
    user_name varchar(10),
    phone char(13)
);

## 테이블 구조확인하기
DESC tb_user;

## 테이블 삭제하기
-- DROP TABLE IF EXISTS tb_user;

## 제약 조건이란?
-- 데이터를 삽입할 때 어떠한 조건이 만족했을 경우만 삽입 가능하게 하는 제약
-- primary key(기본키): 테이블의 각 행을 고유하게 식별하는 역할을 하는 컬럼
-- auto_increment 는 해당 컬럼에 값을 넣어주지 않아도 자동으로 1씩 증가하면서 들어간다.
-- unique: 중복을 허용하지 않음
-- not null: null 값을 허용하지 않음

CREATE TABLE tb_product (
    product_id int PRIMARY KEY AUTO_INCREMENT,
    product_name varchar(20) UNIQUE NOT NULL,
    product_price int
);

DESC tb_product;

## 테이블 수정하기
DESC tb_user;

-- 컬럼 추가하기
ALTER TABLE tb_user ADD user_addr varchar(255);

-- 컬럼명 수정하기
ALTER TABLE tb_user CHANGE phone user_phone varchar(50);

-- 컬럼 타입 수정하기
ALTER TABLE tb_user MODIFY COLUMN user_phone varchar(13);

-- 컬럼에 제약조건과 속성 추가
ALTER TABLE tb_user
MODIFY COLUMN user_id int PRIMARY KEY AUTO_INCREMENT;

-- 컬럼 삭제하기
ALTER TABLE tb_user ADD user_age int;

ALTER TABLE tb_user DROP user_age;

-- not null 제약조건 추가
ALTER TABLE tb_user MODIFY COLUMN user_name varchar(10) NOT NULL;

ALTER TABLE tb_user MODIFY COLUMN user_phone varchar(13) NOT NULL;

ALTER TABLE tb_user MODIFY COLUMN user_addr varchar(255) NOT NULL;

## 주문 테이블 만들기
-- 주문id, 고객id, 상품id, 주문시간

## foreign key(외부키)
-- 한 테이블의 컬럼이 다른 테이블의 기본 키와 연결되어 있음을 나타내는 제약조건
-- 다른 테이블의 기본 키를 참조하는 컬럼 데이터
-- 기본키를 보유한 테이블을 부모, 외부키를 보유한 테이블을 자식

CREATE TABLE tb_order (
    order_id int PRIMARY KEY AUTO_INCREMENT,
    user_id int,
    product_id int,
    order_dt datetime DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES tb_user (user_id),
    FOREIGN KEY (product_id) REFERENCES tb_product (product_id)
);

DESC tb_order;