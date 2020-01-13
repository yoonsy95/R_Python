# 데이터 분석 업무에서 raw data를 얻은 다음
# 머신러닝 모델링을 위해, 또는 시각화를 위해서
# 이 raw data를 저절한 형태로 변형 
# 데이터 변환, 필터링, 전처리 작업 필요함

# 이런 작업(데이터 조작)에 특화된 패키지들 존재함
# plyr: pliers(집게) + R
#       패키지 구현한 언어 R
# dplyr(디플라이알): data frame + pliers + R
#       DB 사용시
# 벡터나 데이터 프레임이 적용할 수 있는 기본 함수

View(iris)
# iris: 붓꽃의 종류와 크키에 대해 측정한 데이터
# 통계학자 피셔라는 사람이 측정해서 제공함
# 컬럼
# Species: 종: 3가지
# Sepal.Length: 꽃받침 길이
# Sepal.Width: 꽃받침 너비
# Petal.Length: 꽃잎의 길이 
# Petal.Width: 꽃잎의 너비

# 기본함수
# 1. head(): 데이터 셋의 앞에서 부터 데이터 추출
#            default: 6개
#            데이터 프레임이 아닌 경우도 적용 가능
head(iris, 3)
var1=c(1,2,3,4,5,6,7,8,9,10)
head(var1,2)

# 2. tail(): 데이터 셋의 뒤에서부터 데이터 추출
#            default: 6개
#            데이터 프레임이 아닌 경우도 적용 가능
tail(iris,3)

# 3. View(): View창에 데이터 출력
View(iris)

# 4. dim(): data frame에 적용할 때 행과 열의 개수를 알려줌
dim(iris)

# 5. nrow(): data frame의 행의 개수
nrow(iris)

# 6. ncol(): data frame의 열의 개수
ncol(iris)

# 7. str(): data frame의 일반적이 정보 추출
str(iris)
# 150 obs. of 5 variables => 150행, 5열
# $ 열이름: 데이터 타입   데이터1, 데이터2, 데이터3, ...
#     Factor인 경우 w/ 3 levels "factor1", "factor2", ...: 1 1 1 ...

# 8. summary(): data frame의 요약 통계량 보여줌
summary(iris)
# 각 컬럼의 최소, 1사분위, 중앙값, 평균, 3사분위, 최대값

# 9. ls(): data frame의 컬럼명을 벡터로 추출, 오름차순 정렬
ls(iris)

# 10. rev(): 선형 자료구조 데이터의 순서 역순으로 바꿈
rev(ls(iris))

# 11. length(): 길이를 구하는 함수
#     데이터 프레임이 적용하면 컬럼의 개수
var1 = matrix(1:12, ncol=3)
var1
length(var1)

##################################################################
# plyr package => dplyr 개량형 패키지
install.packages("plyr")
require(plyr)

# 1. 키값을 이용하여 두 개의 데이터 프레임을 병합 // 세로방향, 열방향 => join
x=data.frame(id=c(1,2,3,4,5),
             height=c(150,190,170,188,167))
y=data.frame(id=c(1,2,3,6),
             weight=c(50,100,80,78))

join(x,y) # left, default
join(x,y,by="id",type="inner")
join(x,y,type="right")
join(x,y,type="full")

# 두 개 이상의 키 결합
x=data.frame(id=c(1,2,3,4,5),
             gender=c('M','F','M','F','M'),
             height=c(150,190,170,188,167))
y=data.frame(id=c(1,2,3,6),
             gender=c('F','F','M','F'),
             weight=c(50,100,80,78))

join(x,y,by=c("id","gender"),type="inner")

# dplyr에서는 join() => left_join()처럼 사용


# 2. 범주형 변수를 이용하여 그룹별 통계량 구하기
str(iris)
unique(iris$Species) # 중복제거한 데이터 출력

# iris의 종별 꽃잎 길이의 평균을 구하세요
# tapply는 한 번에 1개의 통계만 구할 수 있움
# tapply(대상컬럼, 범주형 컬럼, 적용할 함수)
tapply(iris$Petal.Length,
       iris$Species,
       FUN = mean)

tapply(iris$Petal.Length,
       iris$Species,
       FUN = max)

# iris 종별 꽃잎 길이의 평균과 표준편차(변수간의 차이점) 구하기
# ddply(): 한 번에 여러개의 통계치 출력 가능
# ddply(dataSer, .(범주형컬럼), summarise, nowCol=mean(컬럼명), ...)
df=ddply(iris,
         .(Species),
         summarise,
         avg=mean(Petal.Length),
         sd=sd(Petal.Length))
head(df)
class(df)

################################################################# 
# plyr에서는 join()과 통계값을 구하는 함수 2개만 알아두면 됨!!

# 실제로 데이터 프레임 핸들링할 때
# plyr을 계량한 dplyr을 이용함
# dplyr은 c++로 구현되었기에 속도가 빠름!
# dplyr은 코딩시 chaining을 사용할 수 있음
# var1 <- c(1,2,3,4,5)
# var2 <- var1 * 2
# var3 <- var2 + 5
# 
# var1 <- c(1,2,3,4,5) >> *2 >> +5
# ?????????????? Error: unexpected '>' in "var1 <- c(1,2,3,4,5) >>"
# 못 알아듣겠다는데????
install.packages("dplyr")
library(dplyr)

install.packages("xlsx")
library(xlsx)
excel <- read.xlsx(file.choose(),
                   sheetIndex = 1,
                   encoding = "UTF-8")
excel
head(excel)
str(excel)
ls(excel)

# dplyr의 주요 함수들
# 1. tbl_df(): 현재 console크기에 맞추어서 data frame을 추출하라는 함수
tbl_df(iris)



# 2. rename(): 컬럼명 변경
#    rename(data frame, 
#           바꿀컬럼명1 = 이전컬럼명1,
#           바꿀컬럼명2 = 이전컬럼명2, ...)
# 컬럼명 수정한 새로운 데이터 프레임 리턴됨 // 기존 수정 아님!!!!!

# 제공된 덱셀을 읽어들여서 데이터 프레임 생성
# AMT17: 2017년도 이용금액
# Y17_CNT: 2017년도 이용횟수
df <- rename(excel,
             CNT17 = Y17_CNT,
             CNT16 = Y16_CNT)

# 3. 하나의 데이터 프레임에서
#    하나 이상의 조건을 이용하여 데이터를 추출하려면?
# filter(dataframe,
#        조건1, 조건2, ...)
filter(excel, 
       SEX=='M', # , 대신 & 가능함
       AREA=='서울')

# 지역이 서울이나 겨익인 남성 중 40살 이상인 사람 정보 출력
filter(excel,
       SEX=='M',
       AREA=='서울' | AREA== '경기',
       # 지역에 제주도 있는 경우 : AREA %in% c('서울','경기','제주')
       AGE>=40)

filter(excel,
       SEX=='M',
       # 지역에 제주도 있는 경우
       AREA %in% c('서울','경기','제주'),
       AGE>=40)

# 4. arrange(data frame,
#            column1, desc(column2), ...)
# default: asc <-> desc
# 서울사는 남자 2017 40만, 나이 내림차순으로 출력
excel_filter<- filter(excel,
                      SEX=='M',
                      AREA=='서울',
                      AMT17>=400000)

arrange(excel_filter,
        desc(AGE))

###########chaining###########

df <- filter(excel,
             SEX=='M',
             AREA=='서울',
             AMT17>=400000) %>%
      arrange(desc(AGE))
df

# 5. select(dataframe, col1, col2, ...)
# 추출하기 원하는 컬럼만 지정하여 해당 컬럼만 추출
# 위의 조건 + 아이디, 나이. 17년도 처리 건수
df2 <- filter(excel,
              SEX=='M',
              AREA=='서울',
              AMT17>=400000) %>%
       arrange(desc(AGE)) %>%
       # select('ID':'AGE', 'Y17_CNT')
       select(-SEX) # 따옴표 안에 있어도 됨
df2

# 6. 새로운 컬럼 생성할 수 있음
View(excel)

# 데이터프레임의 컬럼을 생성하는 기본기능
# excel$GRADE<-"VIP"
excel$GRADE<-ifelse(excel$AMT17>=500000,
                    "VIP",
                    'NORMAL')
# dplyr은 새로운 컬럼을 생성하기 위하여 함수 제공함
# multate(dataframe,
#         col1=수식1,
#         col2=수식2)

# 경기사는 여자, 17 처리금약의 10% 가산한 값으로
# 새 컬럼 AMT17_REAL 만듦, 45만이상이면 VIP 컬럼 T,F

# df3 <- filter(excel,
#               SEX=='F',
#               AREA=='경기')
# 
# df3$AMT17_REAL<-df3$AMT17+(df3$AMT17*.1)
# 
# df3$VIP<-ifelse(df3$AMT17_REAL>=450000,
#                        "TRUE",
#                        'FALSE')
# df3

df31 <- filter(excel,
              AREA=="경기"&SEX=='F') %>%
       mutate(AMT17_REAL=AMT17+(AMT17*.1),
              VIP=ifelse(df3$AMT17_REAL>=450000,"TRUE",'FALSE'))
df31

# 7. group_by() & summaries()
df <- filter(excel,
             AREA=='서울' & AGE>30) %>%
      group_by(SEX) %>% 
      summarise(sum=sum(AMT17), 
                cnt=n())
df

# 8. plyr packageㅡ이 join 함수가 각 기능별로 독립적인 함수로 제공됨
# left_join, right_join, inner_join, full_join

# 9. bind_rows(df1, df2)
# 컬럼명과 개수가 같아야 결합됨
# 컬럼명이 같지 않으면 컬럼 생성하여 결합됨
df1 <- data.frame(x=c("a","b","c"))
df1
df2 <- data.frame(y=c("d","e","f"))
df2
bind_rows(df1, df2)

##############################################################################
#                                 연습문제
##############################################################################
# MovieLens 데이터셋을 이용하여 처리
# 영화에 대한 평점 기록 // 1 ~ 5

# 데이터 받으면 구조확인 및 컬럼 의미 파악
rating <- read.csv(file="C:/R_Lecture/data/ml-latest-small/ratings.csv",
                   encoding = "UTF-8")
movie <- read.csv(file="C:/R_Lecture/data/ml-latest-small/movies.csv",
                  encoding = "UTF-8")

tot_movie=left_join(movie,rating,by="movieId")
head(tot_movie)


# 1. 사용자가 평가한 모든 영화의 전체 평균 평점
movie1 = mean(rating$rating)
movie1


summarise(group_by(tot_movie, userId), mean=mean(rating))

# 2. 각 사용자별 평균 평점
movie2 = summarise(group_by(rating, userId),
                   mean=mean(rating))
head(movie2)

# 3. 각 영화별 평균 평점 // 9724
movie3 = summarise(group_by(tot_movie, movieId),
                   mean=mean(rating, na.rm = TRUE)) # 왜 안먹!!!
head(movie3)
sum(is.na(movie3))

movie3<-na.omit(movie3)
movie3

# 4. 평균 평점이 가장 높은 영화 제목 내림차순 출력
#     같은 경우 모두 출력 // 296

movie4<-left_join(movie, movie3, by="movieId")%>%
        filter(mean==max(movie3$mean, na.rm = T)) %>%
        arrange(desc(mean),desc(title)) %>%
        select(title)# %>%
        
head(movie4)
max(movie3$mean)

# 5. comedy 영화 중 평점 낮은 순, 제목 오름차순 출력
#     같은 경우 모두 출력 // 25
comedy<-movie[grep("Comedy",movie$genres),]

movie5<-arrange(left_join(comedy, movie3, by="movieId"),
                mean,
                title) %>%
        filter(mean==min(movie3$mean, na.rm = T)) %>%
        select(title)
movie5

# 6. 2015년도 평가된 모든 Romance 영화의 평균 평점
install.packages("lubridate")
library(lubridate)

date<-as.POSIXct(rating$timestamp, origin="1970-01-01")
rating<-mutate(rating, year=year(date))
romance<-movie[grep("Romance",movie$genres),]

movie6<-filter(left_join(romance, rating, by="movieId"),
               year==2015)
movie6
mean(movie6$rating)
