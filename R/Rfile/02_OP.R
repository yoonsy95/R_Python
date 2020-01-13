#Operator
var1<-100
var2<-3

var1/var2 # Java 언어: 33 => 정수/정수=정수
          # R은 마치 실생활의 연산처럼 수행함

# 몫 구하기 => 33
var1 %/% var2

# 나머지 구하기 => 1
var1 %% var2

# 비교 연산자
var1 == var2 # boolean 보다는 logical type이라는 말 많이 사용
var1 != var2 # 결과값은 대문자로 (true => X, TRUE, T => O)

# 논리 연산자
# &, &&: 양 쪽 값이 True 이면 TRUE
TRUE & FALSE
TRUE && FALSE
# => 둘 다 AND 논리 연산자
# |, ||: 하나라도 TRUE이면 TRUE
TRUE | FALSE
FALSE || FALSE

# 단일변수는 1개짜리 공간
# R은 여러가지 자료구조가 있음
# 가장 대표적인 자료구조(데이터 저장하는 구조)에는 vector가 있음
# R에서 vector는 연속적인 저장공간, 1차원 자료구조
# 다른 언어의 array와 같은 구조
# 저장공간 안에 모두 같은 데이터 타입
# 함수 이용하여 vector 저장
# c() <= combine
c(10,20,30)
c(FALSE, 20, 3.14) # 우선순위 위하여 데이터타입 일치시킴
# 같은 데이터타입으로 벡터 생성됨

c(TRUE, FALSE) & c(TRUE, TRUE)
# 원소 하나인 벡터: 스칼라
# 같은 인덱스끼리 계산함
# 벡터 연산 결과값 => 벡터

c(TRUE, FALSE) && c(FALSE, TRUE)
# &&이면 인덱스 0(첫번째 요소)만 계산함

c(TRUE, F, TRUE) & c(F, T)
# 길이 맞아야 // RESULT: F F F
# 결과값은 나오지만 연산 힘드니 사용 말 것

!c(T, F, T, F)

# 다른언어와 마찬가지로 다양한 수학함수 내장
# 매우 많으니 모두 외우기보단 그 때 그 때 찾아서
abs(-3)
round(3.1415, 2)
sqrt(4)
