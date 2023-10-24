--쇼핑몰 데이터베이스 설계


commit;     --항상 수정후 커밋하기
--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
--삭제
DROP TABLE bs_member;
DROP TABLE bs_member_roles; --member의 권한 테이블
DROP TABLE bs_address;
DROP TABLE bs_category;
DROP TABLE bs_item;
DROP TABLE bs_cart;
DROP TABLE bs_wish_list;
DROP TABLE bs_review;
DROP TABLE bs_order;
DROP TABLE bs_order_cash;

DROP SEQUENCE bs_member_seq;
DROP SEQUENCE bs_address_seq;
DROP SEQUENCE bs_category_seq;
DROP SEQUENCE bs_item_seq;
DROP SEQUENCE bs_cart_seq;
DROP SEQUENCE bs_wish_list_seq;
DROP SEQUENCE bs_review_seq;
DROP SEQUENCE bs_order_seq;
DROP SEQUENCE bs_order_cash_seq;

--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
select * from bs_member_roles;
SELECT * FROM bs_member;

select * from persistent_logins;

--회원 테이블 >>JPA로 만들거라 안만들어도 됨
create table bs_member(
    m_id VARCHAR2(30) PRIMARY KEY, 
    m_pwd VARCHAR2(300),        
    m_name VARCHAR2(30),
    m_birth VARCHAR2(100),                        --20020201 형식으로 받음
    m_email VARCHAR2(300),                       --이메일 앞 부분
    m_phone VARCHAR2(30),                        --폰 번호
    m_tel VARCHAR2(10),
    m_state NUMBER default 1,                     --회원 상태여부(ex: 1은 평범한 상태 0은 탈퇴회원 9는 관리자)
    m_regdate DATE DEFAULT sysdate          --가입일자
);

--회원 테이블 전용 시퀀스
CREATE SEQUENCE bs_member_seq
START WITH 1 INCREMENT BY 1 NOCACHE;  --시퀀스1부터시작, 1씩증가, 캐시사용안함

insert into bs_member values(bs_member_seq.nextval, 'z', 'z', '조성관', '19960307', 'zaq3195@naver.com', '01038882488', 'LG', 1, sysdate);

insert into bs_member values(bs_member_seq.nextval, 'zzzz', 'z', '조성관', '1996-03-07', 'zaq3195@naver.com', '010-3888-2488', 'LG', 1, sysdate);

delete from bs_member;
ALTER SEQUENCE bs_member_seq RESTART START WITH 1; --시퀀스 다시 1부터 시작


SELECT * FROM bs_member;

commit;
--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ


--카테고리 테이블
CREATE TABLE bs_category(
 category_num NUMBER,                                   --1차 카테고리 번호
 category_num2 NUMBER PRIMARY KEY,               --2차 카테고리 번호 (EX: 1-1 = 반팔 , 1-2 = 긴팔)
 category_name VARCHAR2(100)                     --카테고리 이름
);
--카테고리 테이블 전용 시퀀스
CREATE SEQUENCE bs_category_seq
START WITH 1 INCREMENT BY 1 NOCACHE;  --시퀀스1부터시작, 1씩증가, 캐시사용안함


--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ


--상품 테이블
CREATE TABLE bs_item(
    i_num NUMBER PRIMARY KEY, --상품 고유번호
    i_category number,      --상품 카테고리(종류)
    i_name VARCHAR2(150), --상품 이름
    i_price NUMBER,         --상품 원래 가격
    i_sale NUMBER,          --상품 판매 가격
    i_count NUMBER,         --상품 재고 개수
    i_img1 VARCHAR2(150),   --상품 이미지1
    i_img2 VARCHAR2(150),   --상품 이미지2
    i_img3 VARCHAR2(150),   --상품 이미지3
    i_cont VARCHAR2(1000), --상품 설명
    i_state VARCHAR2(10) default '판매중',       --판매유무
    i_regdate DATE DEFAULT sysdate  --상품 등록 일자

);
--상품 테이블 전용 시퀀스
CREATE SEQUENCE bs_item_seq
START WITH 1 INCREMENT BY 1 NOCACHE;  --시퀀스1부터시작, 1씩증가, 캐시사용안함


--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ


--회원의 주소
CREATE TABLE bs_address(
    addr_num NUMBER PRIMARY KEY,
    addr_m_id VARCHAR2(30),
    address VARCHAR2(200),
    address2 VARCHAR2(200),
    addr_code VARCHAR2(10),
    FOREIGN KEY (addr_m_id) REFERENCES bs_member(m_id) ON DELETE CASCADE
);

--주소 테이블 전용 시퀀스
CREATE SEQUENCE bs_address_seq
START WITH 1 INCREMENT BY 1 NOCACHE; --시퀀스1부터시작, 1씩증가, 캐시사용안함


--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ


--장바구니

CREATE TABLE bs_cart(
    cart_num NUMBER PRIMARY KEY,                      --장바구니 번호
    cart_mid VARCHAR2(30),                                     --장바구니 이용 회원
    cart_item_no NUMBER,                                     --상품 고유 번호
    cart_count NUMBER,                                        --상품 구매 수량
    cart_delivery VARCHAR2(10) default '배송전',         --배송상태
    cart_date DATE DEFAULT sysdate,                      --장바구니에 담은 날짜
    
    FOREIGN KEY (cart_mid) REFERENCES bs_member(m_id) ON DELETE CASCADE,
    FOREIGN KEY (cart_item_no) REFERENCES bs_item(i_num) ON DELETE CASCADE
);

--장바구니 테이블 전용 시퀀스
CREATE SEQUENCE bs_cart_seq
START WITH 1 INCREMENT BY 1 NOCACHE;  --시퀀스1부터시작, 1씩증가, 캐시사용안함


--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

--찜목록

CREATE TABLE bs_wish_list(
    wish_num NUMBER PRIMARY KEY,
    wish_mid VARCHAR2(30),          -- 회원 ID를 저장할 컬럼
    wish_i_num NUMBER,             -- 찜한 아이템의 고유 번호

    FOREIGN KEY (wish_mid) REFERENCES bs_member(m_id) ON DELETE CASCADE,
    FOREIGN KEY (wish_i_num) REFERENCES bs_item(i_num) ON DELETE CASCADE
);

--찜목록 테이블 전용 시퀀스
CREATE SEQUENCE bs_wish_list_seq
START WITH 1 INCREMENT BY 1 NOCACHE;  --시퀀스1부터시작, 1씩증가, 캐시사용안함


--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

--리뷰 테이블

CREATE TABLE bs_review(
    r_id NUMBER PRIMARY KEY,
    r_i_num NUMBER, -- 상품 고유번호
    r_m_id VARCHAR2(30), -- 리뷰 작성자 ID
    r_rating NUMBER, -- 평점
    r_cont VARCHAR2(1000), -- 리뷰 내용
    r_date DATE DEFAULT sysdate, -- 리뷰 작성 날짜
    FOREIGN KEY (r_i_num) REFERENCES bs_item(i_num) ON DELETE CASCADE,
    FOREIGN KEY (r_m_id) REFERENCES bs_member(m_id)ON DELETE CASCADE
);

--찜목록 테이블 전용 시퀀스
CREATE SEQUENCE bs_review_seq
START WITH 1 INCREMENT BY 1 NOCACHE;  --시퀀스1부터시작, 1씩증가, 캐시사용안함


--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ


-- 주문 테이블
CREATE TABLE bs_order(
    order_num NUMBER PRIMARY KEY,                         --주문하는 상품 번호
    order_id VARCHAR2(30),                                       -- 회원 아이디
    order_iname_no NUMBER,                                    -- 주문 상품 고유번호
    order_price NUMBER,                                             --주문 상품 가격
    order_order_no VARCHAR2(100),                               -- 주문 번호
    order_status VARCHAR2(30) DEFAULT 'wait' NOT NULL --결제 상태 확인
);

--주문 테이블 전용 시퀀스
CREATE SEQUENCE bs_order_seq
START WITH 1 INCREMENT BY 1 NOCACHE;  --시퀀스1부터시작, 1씩증가, 캐시사용안함



--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ


--결제 정보 저장 테이블
create table bs_order_cash (
    id number primary key,
    buyer_id varchar2(100),                      --구매자 아이디
    buyer_phone varchar2(20),                   --구매자 폰번호
    buyer_email varchar2(255),                  --구매자 이메일
    buy_date DATE default sysdate,              --결제 일자
    item_name varchar2(255),                    --구매 물품
    item_price number,                              --물품 가격
    buy_id varchar2(255),                           --가맹점 번호
    merchant_id varchar2(255),                     --주문번호 ★
    card_num varchar2(255),                         --카드 번호
    pay_status varchar2(50),                           --결제 상태
    post_code number                                  --?
);

--주문 테이블 전용 시퀀스
CREATE SEQUENCE bs_order_cash_seq
START WITH 1 INCREMENT BY 1 NOCACHE;  --시퀀스1부터시작, 1씩증가, 캐시사용안함



--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ


