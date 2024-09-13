# DML
-- 테이블 안의 데이터를 조작하는
-- insert: 테이블 안에 데이터를 삽입하는 구문
-- update: 테이블 안의 데이터를 수정하는 구문
-- delete: 테이블 안의 데이터를 삭제하는 구문
-- select: 테이블 안의 데이터를 조회하는 구문

USE shop;

SELECT DATABASE();

## insert
-- 데이터 삽입하기
DESC tb_user;

INSERT INTO
    tb_user (
        user_name,
        user_phone,
        user_addr
    )
VALUES (
        "권지혁",
        "010-0000-0000",
        "대전시 중구"
    );

SELECT * FROM tb_user;

-- 허용하는 길이를 초과할 경우 에러발생
-- INSERT INTO tb_user(user_name, user_phone, user_addr) VALUES ("철수", "010-1111-11111", "대전시 중구");

-- not null 로 제약조건이 설정된 컬럼에 데이터를 삽입하지 않는 경우 에러 발생
-- INSERT INTO tb_user(user_name, user_phone) VALUES("길동", "010-0000-0000");

-- 데이터 여러개 삽입하기
DESC tb_product;

INSERT INTO
    tb_product (product_name, product_price)
VALUES ("에어컨", 1200000),
    ("스마트TV", 2000000),
    ("컴퓨터", 1000000),
    ("모니터", 200000);

SELECT * FROM tb_product;

-- 민수, 철수, 만수, 훈수 tb_user 테이블에 삽입해주세요.
INSERT INTO
    tb_user (
        user_name,
        user_phone,
        user_addr
    )
VALUES (
        "민수",
        "010-1111-1111",
        "대전시 동구"
    ),
    (
        "철수",
        "010-2222-2222",
        "대전시 서구"
    ),
    (
        "만수",
        "010-3333-3333",
        "대전시 유성구"
    ),
    (
        "훈수",
        "010-4444-4444",
        "대전시 대덕구"
    );

SELECT * FROM tb_user;

-- unique 제약 조건이 있는 컬럼에 중복 데이터를 삽입할 경우 에러 발생
-- INSERT INTO tb_product (product_name, product_price) VALUES ("에어컨", 200)

DESC tb_order;

SELECT * from tb_user;

SELECT * FROM tb_product;

INSERT INTO tb_order (user_id, product_id) VALUES (1, 3);

SELECT * FROM tb_order;

-- tb_user 테이블에 없는 user_id 를 tb_order 테이블에 삽입해보기(에러발생)
INSERT INTO tb_order (user_id, product_id) VALUES (100, 3);

-- tb_product 테이블에 없는 product_id 를 tb_order 테이블에 삽입해보기(에러발생)
INSERT INTO tb_order (user_id, product_id) VALUES (3, 200);

## update
-- 데이터 수정하기
SELECT * FROM tb_product;

UPDATE tb_product SET product_name = "삼성 에어컨" WHERE product_id = 1;

## delete
-- 데이터 삭제하기
SELECT * FROM tb_user;

DELETE FROM tb_user WHERE user_name = "훈수";

SELECT * FROM tb_order;

-- 자식 테이블에서 참조하고 있는 데이터가 있을 경우 해당 데이터는 삭제가 되지 않는다.(에러 발생)
-- DELETE FROM tb_user WHERE user_id = 1;

-- 자식 테이블에서 참조하고 있는 행을 먼저 제거한 후에 부모테이블의 해당 행을 제거할 수 있다.
DELETE FROM tb_order WHERE user_id = 1;

DELETE FROM tb_user WHERE user_id = 1;

# DCL
-- GRANT: 사용자에게 권한을 주는 명령어
-- REVOKE: 사용자의 권한을 회수하는 명령어
-- COMMIT: INSERT, UPDATE, DELETE 문에 대한 내용을 데이터베이스에 실제 반영
-- ROLLBACK: INSERT, UPDATE, DELETE 문에 대한 내용을 복구

-- 계정 생성
USE mysql;

CREATE USER "koeyhi" @"%" IDENTIFIED BY "1111";

SELECT * FROM USER;

-- 권한 주기
GRANT SELECT, INSERT , DELETE, UPDATE ON *.* TO "koeyhi" @"%";

FLUSH PRIVILEGES;

GRANT ALL PRIVILEGES ON *.* TO "koeyhi" @"%";
# WITH GRANT OPTION : GRANT 옵션까지 포함해서 권한 부여
FLUSH PRIVILEGES;

-- 권한 회수
REVOKE SELECT, INSERT , DELETE, UPDATE ON *.* FROM "koeyhi" @"%";

FLUSH PRIVILEGES;

-- 계정 삭제
DROP USER "koeyhi" @"%";

USE shop;

SELECT @@AUTOCOMMIT;
# AUOTOCOMMIT 상태 확인
SET @@AUTOCOMMIT = 0;
# AUOTOCOMMIT 해제

SELECT * FROM tb_product;

DELETE FROM tb_product WHERE product_name = "모니터";

ROLLBACK;
# 복구하기
DELETE FROM tb_product WHERE product_name = "모니터";

COMMIT;
# 실제 반영

ROLLBACK;
# 이미 커밋을 실행했기 때문에 복구되지 않음

SET
    @@AUTOCOMMIT = 1
    # AUTOCOMMIT 모드 적용