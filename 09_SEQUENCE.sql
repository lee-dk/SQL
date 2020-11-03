--09_SEQUENCE.sql

--기본 키 (Private Key) : 각 행을 유일하게 구분 할 수 있는 컬럼
--기본키는 유일한 값을 가져야 하는데, 사용자가 그것을 매번 직접 생성하려면 너무 불편하다
--기본키로 사용할 목적으로 자동으로 겹치지 않는 숫자를 생성하는 프로그램을 구현해 놓은 것을 DB의 시퀀스라고 한다
--즉, 시퀀스는 자동 번호 발생기이다

/*
        CREATE SEQUENCE 시퀀스명
                        INCREMENT BY 증감숫자       --기본값 +1, 양수/음수 모두 사용가느,ㅇ
                        START WITH 시작숫자            --시작값을 설정할 수 있다, 설정 하지 않는 경우 기본값은 증가일 때 MINVALUE, (음수일때는 MAX값에서 -1)감소일 때 MAXVALUE
                        MINVALUE 최소값 : 시퀀스의 최소값을 설정한다
                        MAXVALUE 최대값 : 시퀀스의 최대값을 설정한다
                        CYCLE   |   NOCYCLE  : Cycle인 경우 최대값에 도달하면 최소값부터  다시 시작 
                        CACHE    |   NOCACHE : 다음 번호를 미리 설정해 놓을지 말지를 결정한다
*/
--시퀀스 데이터 딕셔너리
SELECT * FROM all_sequences;
SELECT * FROM user_sequences;

SELECT * FROM my_member;
DELETE FROM my_member;
COMMIT;

--시퀀스 생성
CREATE SEQUENCE my_member_memno_seq NOCYCLE NOCACHE;

--시퀀스를 사용해 데이터 추가
INSERT INTO my_member(mem_no, mem_name, mem_age) VALUES (my_member_memno_seq.NEXTVAL, 'tester', 10);    --시퀀스명.NEXTVAL : 다음 숫자를 꺼내서 사용한다. 숫자를 갱신한다

--서브쿼리를 이용해 데이터를 생성하면서 시퀀스 이용
INSERT INTO my_member(mem_no, mem_name. mem_age) 
(SELECT my_member_memno_seq.NEXTVAL, mem_name, mem_age FROM my_member);

--DUAL : 테스트용 테이블
SELECT my_member_memno_seq.CURRVAL FROM DUAL;


/*
    시퀀스 수정
    ALTER SEQUENCE 시퀀스명
                INCREMENT BY 증감숫자
                START WITH 시작숫자
                MINVALUE 최소값
                MAXVALUE 최대값
                CYCLY   |   NOCYCLE
                CACHE   |   NOCACHE
            **한번 지나가버린 시퀀스값을 예전으로 돌릴수는 없다
*/

DESC HEALTH_MEMBER;
SELECT * FROM HEALTH_MEMBER;
--연습문제 : 만들어온 테이블에 시퀀스를 추가하고 INSERT로 데이터를 여러개 추가하기
    --1. 시퀀스를 사용할 적당한 컬럼을 고른다 (없다면 ALTER TABLE로 추가)
    --2. 시퀀스 생성
    --3. 데이터 생성
CREATE SEQUENCE health_member_memno_seq NOCYCLE NOCACHE;
INSERT INTO health_member(mem_no, mem_name, mem_age,joindate, mem_inbody) VALUES (health_member_memno_seq.NEXTVAL, '한민관', 38, '', 0); 

