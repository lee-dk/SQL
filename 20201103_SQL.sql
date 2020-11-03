--unicodb.emp 불러오기
SELECT * 
FROM unicodb.emp;

--unicodb.emp에서 입사일이 빠른 순서대로 정렬
SELECT * 
FROM unicodb.emp
ORDER BY hiredate;

--unicodb.emp에서 부서번호가 30인 직원들만 출력
SELECT * 
FROM unicodb.emp
WHERE deptno = 30;

--unicodb.emp에서 부서번호별로 급여의 종합 출력
SELECT deptno, SUM(sal) 
FROM unicodb.emp
GROUP BY deptno;

--unicodb.emp에서 부서번호별 급여의 총합 출력(부서번호가 NULL 제외)
SELECT deptno, SUM(sal) 
FROM unicodb.emp
WHERE deptno IS NOT null
GROUP BY deptno;

--unicodb.emp에서 ename과 sal만 출력하는데 급여가 높은 순(ORDER BY sal DESC)으로 출력
--DESC : 내림차순
--ASC : 오름차순
SELECT ename, sal 
FROM unicodb.emp
ORDER BY sal DESC;

--unicodb.emp에서 rank() over (ORDER BY sal DESC)와 sal을 출력하는데
--rank() over (ORDER BY sal DESC)는 급여(sal)가 높은 순서대로 순위를 정해줌(단, 동률 데이터가 있을 시 중복된 순위가 정해지고 순서대로 번호가 정해짐)
SELECT rank() over (ORDER BY sal DESC), sal
FROM unicodb.emp;

--동률 데이터가  있을 시 중복된 순위가 정해지고 다음 숫자로 넘어감
SELECT dense_rank() over (ORDER BY sal DESC), sal
FROM unicodb.emp;

--급여가 높은 순으로 번호 지정
SELECT row_number() over (ORDER BY sal DESC), sal
FROM unicodb.emp;

--unicodb.emp에서 부서별로 나눈다음에 그 안에서 급여가 높은 순서대로 순위를 정한다
SELECT rank() over (partition by deptno ORDER BY sal DESC), sal, deptno
FROM unicodb.emp;

--unicodb.emp에서 ename과 sal, grade를 출력한다
--grade는 급여별로 조건(CASE WHEN sal BETWEEN 4000 AND 5000 THEN 'A'__sal이 4000에서 5000사이면(4000,5000포함) 'A' ..)을 정해 등급을 지정한다.
SELECT ename, sal, CASE WHEN sal BETWEEN 4000 AND 5000 THEN 'A'
		WHEN sal BETWEEN 3000 AND 3999 THEN 'B'
		WHEN sal BETWEEN 2000 AND 2999 THEN 'C'
		WHEN sal BETWEEN 1000 AND 1999 THEN 'D'
		ELSE 'E' END grade
FROM unicodb.emp;	


--테이블명에 DB명 생략 가능.
USE edudb;

--edudb.dataset4 전체 출력
SELECT * FROM dataset4;

--edudb.dataset4 데이터 중 위에서 10개만 출력
SELECT *
FROM dataset4 LIMIT 10;

--dataset4에서 PASSENGERID를 카운트 해주고, 죽복된 값이 있는지 확인해준다
SELECT COUNT(PASSENGERID) N_PASSENGERS,
COUNT(DISTINCT PASSENGERID) N_D_PASSENGERS
FROM dataset4;

--성별에따른 승객 수와 생존자 수를 파악
-- [그림 8-4 결과]
SELECT SEX,
COUNT(PASSENGERID) N_PASSENGERS,
SUM(SURVIVED) N_SURVIVED
FROM dataset4
GROUP
BY 1 --그냥 SEX(컬럼명)을 주고 처리하는게 더 좋음
;

--성별에 따른 탐승객 수와 생존자 수의 비율을 구한다
-- [그림 8-5 결과]
SELECT SEX,
COUNT(PASSENGERID) N_PASSENGERS,
SUM(SURVIVED) N_SURVIVED,
SUM(SURVIVED)/ COUNT(PASSENGERID) SURVIVED_RATIO
FROM dataset4
GROUP
BY 1
;

--연령(10세 단위로 분류)에따른 생존율
-- [그림 8-6 결과]
SELECT FLOOR(AGE/10)*10 AGEBAND,
AGE
FROM dataset4
;

--연령별로 탑승객 수 와 생존자 수, 생존율
-- [그림 8-7 결과]
SELECT FLOOR(AGE/10)*10 AGEBAND,
COUNT(PASSENGERID) N_PASSENGERS,
SUM(SURVIVED) N_SURVIVED,
SUM(SURVIVED)/COUNT(PASSENGERID) SURVIVED_RATE
FROM dataset4
GROUP
BY 1
;

--위에서 나온 결과를 연령 순으로 정렬
-- [그림 8-8 결과]
SELECT FLOOR(AGE/10)*10 AGEBAND,
COUNT(PASSENGERID) N_PASSENGERS,
SUM(SURVIVED) N_SURVIVED,
SUM(SURVIVED)/COUNT(PASSENGERID) SURVIVED_RATE
FROM dataset4
GROUP
BY 1
ORDER
BY 1
;

--연령에 성별을 추가해서 세부적인 생존율 파악(여성-남성 순서)
-- [그림 8-9 결과]
SELECT FLOOR(AGE/10)*10 AGEBAND,
SEX,
COUNT(PASSENGERID) N_PASSENGERS,
SUM(SURVIVED) N_SURVIVED,
SUM(SURVIVED)/COUNT(PASSENGERID) SURVIVED_RATE
FROM dataset4
GROUP
BY 1,2
ORDER
BY 2,1
;

--연령에 성별을 추가해서 세부적인 생존율 파악(남성만 출력)
-- [그림 8-10 결과]
SELECT FLOOR(AGE/10)*10 AGEBAND,
SEX,
COUNT(PASSENGERID) N_PASSENGERS,
SUM(SURVIVED) N_SURVIVED,
SUM(SURVIVED)/COUNT(PASSENGERID) SURVIVED_RATE
FROM dataset4
GROUP
BY 1,2
HAVING SEX = 'male'
;

--연령에 성별을 추가해서 세부적인 생존율 파악(여성만 출력)
-- [그림 8-11 결과]
SELECT FLOOR(AGE/10)*10 AGEBAND,
SEX,
COUNT(PASSENGERID) N_PASSENGERS,
SUM(SURVIVED) N_SURVIVED,
SUM(SURVIVED)/COUNT(PASSENGERID) SURVIVED_RATE
FROM dataset4
GROUP
BY 1,2
HAVING SEX = 'female'
;

--남성 생존율과 여성생존율을 조인하여 성별과 동일 연령대별로 생존율 차이를 비교
-- [그림 8-12 결과]
SELECT A.AGEBAND,
A.SURVIVED_RATE MALE_SURVIVED_RATE,
B.SURVIVED_RATE FEMALE_SURVIVED_RATE,
B.SURVIVED_RATE - A.SURVIVED_RATE SURVIVED_RATE_DIFF
FROM
(SELECT FLOOR(AGE/10)*10 AGEBAND,
SEX,
COUNT(PASSENGERID) N_PASSENGERS,
SUM(SURVIVED) N_SURVIVED,
SUM(SURVIVED)/COUNT(PASSENGERID) SURVIVED_RATE
FROM dataset4
GROUP
BY 1,2
HAVING SEX = 'male') A
LEFT
JOIN
(SELECT FLOOR(AGE/10)*10 AGEBAND,
SEX,
COUNT(PASSENGERID) N_PASSENGERS,
SUM(SURVIVED) N_SURVIVED,
SUM(SURVIVED)/COUNT(PASSENGERID) SURVIVED_RATE
FROM dataset4
GROUP
BY 1,2
HAVING SEX = 'female') B
ON A.AGEBAND = B.AGEBAND
ORDER
BY A.AGEBAND
;


--객실 등급 출력
-- [그림 8-14]
SELECT DISTINCT PCLASS
FROM dataset4
;

--객실 등급 별로 승객 수와 생존자 수, 생존율을 계산
-- [그림 8-16 결과]
SELECT PCLASS,
COUNT(PASSENGERID) N_PASSENGERS,
SUM(SURVIVED) N_SURVIVED,
SUM(SURVIVED)/COUNT(PASSENGERID) SURVIVED_RATE
FROM dataset4
GROUP
BY PCLASS
ORDER
BY 1
;

--객실 등급 별로 성별을 조합해 승객 수와 생존자 수, 생존율을 계산
-- [그림 8-17 결과]
SELECT PCLASS,
SEX,
COUNT(PASSENGERID) N_PASSENGERS,
SUM(SURVIVED) N_SURVIVED,
SUM(SURVIVED)/COUNT(PASSENGERID) SURVIVED_RATE
FROM dataset4
GROUP
BY PCLASS,SEX
ORDER
BY 2,1
;

--객실 등급 별로 성별과 연령대를 조합해 승객 수와 생존자 수, 생존율을 계산
-- [그림 8-18 결과]
SELECT PCLASS,
SEX,
FLOOR(AGE/10)*10 AGEBAND,
COUNT(PASSENGERID) N_PASSENGERS,
SUM(SURVIVED) N_SURVIVED,
SUM(SURVIVED)/COUNT(PASSENGERID) SURVIVED_RATE
FROM dataset4
GROUP
BY PCLASS,SEX, FLOOR(AGE/10)*10
ORDER
BY 2,1
;

-- [그림 8-19 결과]
SELECT EMBARKED,
COUNT(PASSENGERID) N_PASSENGERS
FROM dataset4
GROUP
BY 1
ORDER
BY 1
;

-- [그림 8-20 결과]
SELECT EMBARKED,
SEX,
COUNT(PASSENGERID) N_PASSENGERS
FROM dataset4
GROUP
BY 1,2
ORDER
BY 1,2
;

-- [261 페이지, 승선 항구별 전체 승객 수]
SELECT EMBARKED,
COUNT(PASSENGERID) N_PASSENGERS
FROM dataset4
GROUP
BY 1
;

-- [261 페이지, 승선 항구별, 성별 승객 수]
SELECT EMBARKED,
SEX,
COUNT(PASSENGERID) N_PASSENGERS
FROM dataset4
GROUP
BY 1,2
;

-- [262 페이지, 테이블 결합]
SELECT A.EMBARKED,
A.SEX,
A.N_PASSENGERS,
B.N_PASSENGERS N_PASSENGERS_TOT,
A.N_PASSENGERS/B.N_PASSENGERS PASSENGERS_RAT
FROM
(SELECT EMBARKED,
SEX,
COUNT(PASSENGERID) N_PASSENGERS
FROM dataset4
GROUP
BY 1,2) A
LEFT
JOIN
(SELECT EMBARKED,
COUNT(PASSENGERID) N_PASSENGERS
FROM dataset4
GROUP
BY 1) B
ON A.EMBARKED = B.EMBARKED
;

-- [그림 8-21 결과]
SELECT BOARDED,
DESTINATION,
COUNT(PASSENGERID) N_PASSENGERS
FROM dataset4
GROUP
BY BOARDED,
DESTINATION
ORDER
BY 3 DESC
;

-- [그림 8-23 결과]
SELECT *,
ROW_NUMBER() OVER(ORDER BY N_PASSENGERS DESC) RNK
FROM
(SELECT BOARDED,
DESTINATION,
COUNT(PASSENGERID) N_PASSENGERS
FROM dataset4
GROUP
BY BOARDED,
DESTINATION) BASE
;

-- [265 페이지, 상위 5개 경로]
CREATE TEMPORARY TABLE ROUTE AS
SELECT BOARDED,
DESTINATION
FROM
(SELECT *,
ROW_NUMBER() OVER(ORDER BY N_PASSENGERS DESC) RNK
FROM
(SELECT BOARDED,
DESTINATION,
COUNT(PASSENGERID) N_PASSENGERS
FROM dataset4
GROUP
BY BOARDED,
DESTINATION) BASE) BASE
WHERE RNK BETWEEN 1 AND 5
;

-- [그림 8-24 결과]
SELECT NAME_WIKI,
A.BOARDED,
A.DESTINATION
FROM dataset4 A
INNER
JOIN ROUTE B
ON A.BOARDED = B.BOARDED AND A.DESTINATION = B.DESTINATION
;

-- [그림 8-25 결과]
SELECT HOMETOWN,
SUM(1) N_PASSENGERS,
SUM(SURVIVED)/SUM(1) SURVIVED_RATIO
FROM dataset4
GROUP
BY 1
;

-- [그림 8-26 결과]
SELECT HOMETOWN,
SUM(1) N_PASSENGERS,
SUM(SURVIVED)/SUM(1) SURVIVED_RATIO
FROM dataset4
GROUP
BY 1
HAVING SUM(SURVIVED)/SUM(1) >= 0.5 AND SUM(1) >= 10
;

