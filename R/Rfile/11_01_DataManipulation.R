## 3주차
## 데이터 조작, 정제
## 시각화에 대한 내용 // ggplot2

## mpg dta set을 이용하여 데이터 조작 정제에 대한 내용 학습
## 사용하려면 페키지 설치하여야
install.packages("ggplot2")
library(ggplot2)

class(mpg) # 테이블 data frame
# [1] "tbl_df"     "tbl"        "data.frame"

# mpg는 table data frame 형태
#   => 출력 용이하게 하기 위한 형태
#   => 콘솔 크기에 맞추어 data frame 출력

df <- as.data.frame(mpg)
df
class(df)

names(df) # 벡터형태로 컬럼이름 불러옴 정렬ㄴㄴ
ls(df)    # 벡터형태로 컬럼이름 오름차순으로 가져옴!!!

# mpg에 대한 document를 확인해서 column의 의미를 먼저 파악해야
# displ: 배기량
# cyl: 실린더 개수
# trans: 자동, 수동
# drv: 전륜, 사륜, 구륜
# cty: 도시에서 주행할 때의 연비
# hwy: 고속도로에서 주행할 때의 연비
# class: suv, compoterble, 용달...???

head(df)
tail(df)

dim(df) # 데이터프레임이 몇 개의 행과 열로 구성되어 있는지 확인
nrow(df)
ncol(df)
length(df)  ## 벡터와 매트릭스에서는 행의 개수!!!!
            ## 데이터프레임에서는 행의 개수 출력!!!!

str(df) # 자료구조, 행의 개수, 열의 개수
        # 컬럼명, 데이터 타입 등 종합적으로 보여줌

summary(df) # 해당 데이터 프레임의 기본통계 알려줌
            # 가장 기본적인 통계 데이터 추출

rev() # 벡터에 대해서 데이터를 역순으로 변환하는 기능

##################################################################
# pylr => r로 구현되었기에 속도 느림
# dplyr => c++로 구현되었기에 빠름
#          pylr 기능 모두 구현 가능함
#          같이 사용하면 같은 기능일 경우 기능이 꼬일 수 있음
#          필요한 것만 로딩하여 사용하도록

# 데이터 조작(dplyr: 디플라이알)
# 데이터 프레임 조작시 가장 많이 사용하는 패키지
# 속도에 강함: c++로 구현되어있음
# chaining이 가능함 // %>%
# dplyr이 제공하는 여러 함수 이용하여 우리 원하는 데이터 추출
library(dplyr)

# 1. tbl_df()
df
df <- tbl_df(df)         # table data frame
df <- as.data.frame(df)  # data frame

# 2. rename(): 컬럼의 이름을 변경 가능
# raw data를 이용할 경우 컬럼명이 없을 때 새로 명시해야 사용해야 함!
# 모두 소문자, 대문자로 변경해서 사용하면 편함
# df의 컬럼명을 모두 소문자 혹은 대문자로 변경
names(df)<-toupper(names(df))
names(df)<-tolower(names(df))
names(df)

# data frame 리턴 => df 새로 만들어서 저장해야
new_df <- rename(df,
                 model = MODEL) 
head(new_df)

# 3. 조건 만족하는 행 추출함수
# filter(data frame,
#        option1, option2, option3, ...)
# mpg data set에서
# 2000년도에 생산된 차량 몇 개?
df <- as.data.frame(mpg)
nrow(filter(df, year==2008))

# 모든 차량에 대해 평균 도시연비보다 높은 차량의 모델명
avg_cty <- mean(df$cty, na.rm = T)
avg_cty


df1<-filter(df, cty >= avg_cty) %>%
        select(model)
df1
distinct(df1)

unique(filter(df,
              cty>avg_cty)$model)

# 고속도로 연비가 상위 75% 이상인 차량을 제조하는 제조사
unique(filter(df, 
              hwy >= quantile(hwy, probs = c(0.75)))$manufacturer)

length(unique(filter(df, 
              hwy >= summary(df$hwy)[5])$manufacturer))

# 4분위 알아내는 방법
# 1. quantile(hwy, probs = c(0.75))
# 2. summary(df$hwy) 에서 3사분위 추출
#     벡터로 추출되므로 5번째 값 추출
#     최소  1사분위  중앙값  평균  3사분위  최대값

# 오토 차량 중 배기량이 2500cc 이상인 차량수?
df2 <- df[grep("auto", df$trans),]
nrow(filter(df2, displ>=2.5))

library(stringr)
nrow(filter(df,
       displ >= 2.5,
       str_detect(trans, "auto")))

# 4. arrange(): 정렬하는 함수
# arrange(data frame,
#         col1,    # default: asc
#         desc(col2))

avg_cty <- mean(df$cty, na.rm = T)
model <- unique(filter(df,
                       cty>avg_cty)$model)
# 위의 모델명을 오름차순으로 정리하고 같은 모델이 있음??
# 같은 모델에 대해서는 생산년도가 빠른순으로 정렬
arrange(filter(df, cty>avg_cty),
        model,
        year)

# 모든 차량에 대해 평균 도시연비보다 도시연비가 높은 차량 모델명 출력
model
model[order(model)]

df %>% filter(cty > mean(cty)) %>%
       select(model) %>%
       distinct() %>%
       arrange(model)

# 5. select() : data frame에서 원하는 컬럼만 추출하는 함수
# select(dataframe, col1, col2, ...)

# 6. 새로운 컬럼 생성
# 도시연비와 고속도로 연비를 합쳐서 평균 연비컬럼 만듦
df$mean_rate <- (df$cty+df$hwy)/2
head(df)

df <- as.data.frame(mpg)
head(df)
new_df <- df %>% mutate(mean_rate = (cty+hwy)/2)
head(new_df)

# 7. summarise(): 통계량을 구하여 새로운 컬럼으로 생성하는 함수
# model: a4, 배기량(displ): 2.0이상이 차들 평균 연비계산

df %>% filter(model=='a4',
              displ>=2.0) %>%
       summarise('평균연비'=mean(c(hwy, cty)))
       # 왜 바로 mean(mean_rate)사용하면 NA가 나오는가?!
       # mean 안에 데이터프레임 들어오면 에러!!!!!!!!!!!
       # 1 row, 多 col
       # + , hahaha = max(cty)

df3<-df %>% filter(model=='a4',
                   displ>=2.0)
mean(df3$mean_rate)

#######비추ㅇㅇ
result <- df %>% 
          filter(model=="a4", 
                 displ>=2.0) %>%
          mutate(avg_rate=(cty+hwy)/2) %>%
          select(avg_rate) 
mean(result$avg_rate)

# 8. group_by(): 범주형 변수에 대한 grouping
# 배기량이 2000이 넘는 자동차제조사별 연비 통계
df %>% filter(displ >= 2.0) %>%
       group_by(manufacturer) %>%
       summarise(avg_rate = mean(c(cty, hwy)))

# 9. join => left_join, right_join, inner_join, outer_join

























