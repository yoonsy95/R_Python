# 같은 데이터 타입을 저장하는 자료구조
# vector(1차원), matrix(2차원), Array(3차원 이상)
# 다른 언어에서는 array 1차 2차 3차 상관없이 array라고 함


## 다른 데이터 타입을 저장하는 자료구조

# 1. List(1차원), 
# 2. data frame(2차원)
# 3. factor => 범주형 자료구조

############################################

## 1. factor
  # 범주형 데이터를 저장하기 위한 자료구조
  # 범주형 데이터는 
  # 예를 들어 방의 크기가 "대", "중", "소"=> Level
  # 일반적으로 vector를 이용해서 factor를 만든다

# 6명의 혈액형 데이터를 vector에 저장하고 factor로 변형해보자

var1 = c("A","AB","O","A","B","B")
var1

factor_var1 = factor(var1)
# factor함수 활용하면 factor형 자료구조로 받아 볼 수 있음
factor_var1

nlevels(factor_var1)      # 4, level의 개수
# factor를 인자로 주고 level의 갯수가 몇개 있는지 알려줌

levels(factor_var1)
# 어떤 정해져 있는 level이 있는지를 보여줌

is.factor(factor_var1)    # TRUE
# 이 함수가 factor데이터인지 아닌지

########################################################

# factor는 빈도를 구하는데 많이 쓰인다

# 남성과 여성의 성별데이터로 factor를 생성하고 빈도수를 구해보자

var1 = c("MAN","WOMAN","MAN","MAN","MAN","WOMAN")
var1

factor_gender = factor(var1)
factor_gender

table(factor_gender)
# 몇개가 나오는지 빈도가 나옴

plot(factor_gender)

########################################################

# 2. List
  # 1차원 선형구조, 다른데이터타입이 들어올 수 있다
  # 중첩 자료구조로 이용
  # list안에 각각의 요소안에 다른 데이터 타입넣을 수 있다

# 지금까지 했던 여러 자료구조들을 생성하여 List안에 저장해보자

var_scalar = 100; var_scalar    # scalar
  # 값이 하나짜린것 벡터라고 볼 수 있지만 
  # 값을 하나로만 저장할 수 있는 것을 스칼라라고 한다

var_vector = c(10,20,30)    # vector
var_vector

var_matrix = matrix(c(1:12), 
                    ncol=3, 
                    nrow=4,
                    byrow=T)
var_matrix

var_array = array(c(1:12), dim = c(2,2,3))
  # 3차원 이상의 배열
  # dim 알려줘야지 몇차원인지 앎
var_array

var_df = data.frame(id=1:4,      # id라는 col
                    name=c("홍길동","김길동","최길동","이길동"),
                    age=c(30,40,20,10))
var_df             
  # dataframe = matrix
  # 다른점 : 다른타입의 데이타 들어갈 수 있음
  # 다른타입 쓸때는 dataframe
  # but, matrix가 좀 더 빠르기 때문에 matrix 쓰는 이유도 있음


# 중첩 자료구조

myList = list(var_scalar,
              var_vector,
              var_matrix,
              var_array,
              var_df)
myList
# 1번째 방에는 스칼라, 2번째 방에는 벡터...
# 다른자료구조를 내부적으로 가지고 갈 수 있는 것
# 1차원 선형구조라고 볼 수 있음
myVector = c(10,20,30)
myVector[2:3]

myList
myList[1]
# key와 value로 저장되는 자료구조이고 데이터를 출력할 때 key값도 같이 출력
# 일반적으로 map, dictionary라고 표현함
# 우리는 key값이 없기 때문에 첫번째 방에 키가 없음 그냥 첫번째 방에 잇다는것만 보여줌
# 공간을 access하면 key,value가 나옴
# [[1]] 
# [1] 100

myList[[1]]
# key를 access한것 value가 나옴
# [1] 100
# key값을 이용하면 딱 끄집어 낼 수 있다.
# list는 키값을 정해서 할 수 있다

myList = list(name = c("홍길동","김길동"),
              age = c(20,30),
              address=c("서울","부산"))
# key와 value의 쌍으로 첫번째, 두번째, 세번째 방에 밀어 넣은것

myList
# []대신 키값이 나오게 됨
# $키값 을 의미함

myList[1]
# 첫번째 방에 있는 key와 value가 같이 튀어 나오게 됨

myList$name
# 해당 key값으로 해당되는 데이터를 access한 것
# List에서 key를 사용할 때는 $기호를 이용

myList$name[2]

myList[[1]]
# 이 형태도 사용 가능하지만 일반적으로 key값이있으면 key값을 이용함

myList[]
# 공간을 지칭함
myList[[]]
# key값을 지정함
myList$name
# 이 형태를 일반적으로 사용 

###############################################################

## 3. data frame

  # matrix와 같은 2차원 형태의 자료구조
  # 다른 데이터 타입을 하용할 수 있다
  # column 명을 이용할 수 있다
  # Database의 Table과 유사하다

# 간단한 예를 이용해 보자

# vector를 이용해서 data frame을 만들어 보자

no=c(1,2,3)
name=c("홍길동","김길동","최길동")
age=c(10,20,30)

df = data.frame(s_no = no,
                s_name = name,
                s_age = age)
  # 컬럼명 = 해당컬럼명에 벡터를 지칭
df

myMatrix = matrix(c(1:12), 
                    ncol=3, 
                    nrow=4,
                    byrow=T)
myMatrix
# 변수명을 키워드로 잡는 것 좋지않아.
# 변수명은 예약된 키워드로 하는 것 피해야함

# matrix를 dataframe으로 전환 가능
df_mat = data.frame(myMatrix)
df_mat
# column명을 줄 수 없어
# 변형시킬 수는 있음

df[1]
# 첫번째 열을 지칭함
df$s_name
# dataframe안에 있는 s_name이라는 컬럼을 내가 알고 싶을때
# list에서 $ : key
# df에서 $ : column

# [1] 홍길동 김길동 최길동
# Levels: 김길동 최길동 홍길동

# 범주형으로 잡힘
# 나중에 범주형으로 안되는법 배움

# data.frame의 함수
str(df)
# 전반적인 내용을 보여줌
# 3 obs. : 3개의 관측치, 3개의 행
# 3 variables : 3개의 변수, 3개의 열
# s_no : 첫번째 col...
# 각각의 col 데이터 타입 (num factor,,,)

summary(df)
# data frame 의 요약 통계를 볼 수 있다

apply()
# data frame에도 적용가능

df = data.frame(x=c(1:5),
                y=seq(2,10,2),
                z=c("a","b","c","d","e"),  # datatype default= factor
                stringsAsFactors = F)      # dt -> not factor
df
df[1]

# 연습문제
# 주어진 data frame의 1,2번째 column에 대해서 각각 합계를 구하세요
sum(df[1])
sum(df[2])
apply(X = df[1], MARGIN = 2, FUN=sum)
apply(X = df[2], MARGIN = 2, FUN=sum)
apply(X = df[1:2], MARGIN = 2, FUN = sum)

apply(X = df[,c(1:2)], MARGIN = 2, FUN = sum)
# apply는 2차원으로 보통 씀

# subset()
# 하나의 df에서 조거네 맞는 행을 추출해서 독립적인 data frame을 생성

subset(df,x > 3)
# x col값이 3이 넘어가는 것을 뽑아 볼것이다

# x가 3보다 작고 y가 5보다 큰 데이터를 추출해 볼때
df_sub <- subset(df,x<3 & y >= 4)
# 일반적으로는 변수 저장을 해주자

#########################################################

# 6개의 자료구조에 대해서 알아보았다
# 배운내용을 복습하기 위해서 간단한 연습문제를 풀어보아요

# 1. 4,6,5,7,10,9,4 데이터를 이용해서 숫자형 vector x 를 생성해봐라
x <- c(4,6,5,7,10,9,4); x

# 2. 아래의 두 벡터의 연산 결과는?
x1 = c(3,5,6,8)
x2 = c(3,3,4)

x1+x2
# 6  8 10 11
# recycling rule

# 3. data frame을 이용하여 다음의 결과를 도출하라
Age <- c(22,25,18,20)
Name <- c("James","Mathew","Olivia","Stella")
Gender <- c("M","M","F","F")

## 출력형태

##   Age    Name    Gender
## 1  22   James      M
## 2  25   Mathew     M
# data frame의 형태
# 일부만 출력
df = data.frame(age=Age,
                name=Name,
                gender=Gender)
df
subset(df, Gender == "M")
subset(df, Gender != "F")
subset(df, Age >= 22)

# 4. 아래의 구문을 실행한 결과는?
x<- c(1,2,3,4,5)
(x*x)[!is.na(x) & x >2]  # 9 16 25
    #(T T T T T) & (F F T T T)
# (백터연산)[각각의 요소에 대해서 na가 아니야?]
# 각자 위치에서 곱하기, 
# (1 4 9 16 25)[(F F T T T)]   # fancy indexing
#  이 벡터에     indexing 하는것
# 원본벡터와 분리된 logical type = fancy indexing
# 사이즈가 똑같은 벡터가 들어와야하고 그대로 mapping 시킴, T부분만 남기고 다 날라감

# 5. 다음의 계산 결과는?
x <- c(2,4,6,8)
y <- c(T,T,F,T) # 14
sum(x[y])
# 같은 사이즈의벡터가 logical type으로

# 6. 제공된 vector에서 결측치(NA)의 개수를 구하는 코드를 작성해라
var1 <- c(34,55,89,45,NA,22,12,NA,99,NA,100)
sum(is.na(var1))
# 이 데이터에 결측치가 몇개 있는지
# 결측치를 제외한 평균을 구하시오
mean(var1[!is.na(var1)])

# 7. 두 개의 벡터를 결합하려한다
x1 <- c(1,2,3)
x2 <- c(4,5,6)
c(x1,x2)
# c =  combine
# 벡터는 중첩구조 X , list 중첩구조

# vector를 결합해서 matrix를 만들어보자
rbind(x1,x2)
cbind(x1,x2)
# 두개의 벡터 열을 세운다

# 8. 다음 코드의 실행 결과는?
x = c("Blue",10, TRUE, 20)
is.character(x)     # TRUE

# 벡터 데이터 타입이 다를 경우 우선순위 따라 통일됨