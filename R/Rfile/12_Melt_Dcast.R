# reshape2 package
# 데이터의 형태를 바꿀 수 있음
# 가로로 되어 있는 데이터를 세로로 바꿀 수 있음
# 컬럼 데이터를 row 형태로 만듦
# 혹은 반대도 가능

library(ggplot2)
library(stringr)
library(dplyr)

# melt_mpg.csv
# sample_mpg.csv

melt_mpg <- read.csv("C:\\R_Lecture\\data\\melt_mpg.csv",
                     sep=",",  # default // 생략 가능
                     header=T, # default
                     fileEncoding = "UTF-8") # 한글일 경우 해야 // 습관 들이렴 
sample_mpg <- read.csv("C:\\R_Lecture\\data\\sample_mpg.csv",
                       sep=",",  
                       header=T,
                       fileEncoding = "UTF-8")

melt_mpg
sample_mpg

# 두 개의 df에 대해서 평균 도시 연비
mean(sample_mpg$cty)

melt_mpg %>% 
  filter(variable=='cty') %>%
  summarise(avg_rate = mean(value))

# 두 개의 데이터 프레임에 대해서 평균 연비 열 만들어 붙이기
# 평균 연비 = (도시연비 + 고속도로연비) / 2
sample_mpg %>%
  mutate(avg_rate = (cty+hwy)/2)

melt_mpg # 어려움

## reshape2 package는 수집한 데이터를 
## 분석하기 편한 형태로 가공할 때 사용하는 
## 대표적인 package

## 1. melt()
# column을 row형태로 바꾸어서 가로로 긴 데이터를 세로로 길게 전환하는 함수
# melt()의 기본동작은  numeric을 포함하고 있는 모든 컬럼을 row로 변환

# 간단한 예시로 melt() 동작방식 알아보자
install.packages("reshape2")
library(reshape2)

help("airquality") # document
airquality
ls(airquality)     # colName
head(airquality)
str(airquality)

df <- airquality # 원본으로 작업하지 말아
nrow(melt(df))            # 153 * 6 = 918
nrow(melt(df, na.rm = T)) # 874 // except NA
melt(df, id.vars = c("Month","Day")) # 153 * 4 = 612
melt_df <- melt(df, id.vars = c("Month","Day"),
                measure.vars = "Ozone",  # melt 시킬 컬럼
                variable.name = "Item",
                value.name = "Item_value")

## 2. cast()
# row로 되어 있는 데이터를 column형태로 전환
# 항상 되는 것은 아님 // ...?? 언제 안된다구???
# dcast(): data frame에 대한 cast 작업
# row로 되어 있는 데이터를 column 형태로 전환

dcast(melt_df,
      formula = Month + Day ~ ...) # ... is all col

dcast(melt_df,
      formula = Month ~ Item,
      fun=mean,
      na.rm = T)

dcast(melt_df,
      Month ~ Item,
      fun=mean,
      na.rm = T)

# 처음에 받은 csv 파일 원산복귀 시키기 => 망 to the 함
dcast(melt_mpg,
      manufacturer + model + class + trans + year ~ variable,
      value.var = "value")
# error: Aggregation function missing: defaulting to length
# 원래있는 컬럼 유효하지 않아(?) 복구 불가
# => 다 같고 키 값만 다른 경우 원상복귀 불가함

## 제공된 파일을 이용한 melt 형식의 데이터 프레임은 원상복귀 될 수 없음
# duplicate // 중복되어 있기에 불가함

# melt()된 데이터를 생성
# mpg 가지고 melt dta set 생성
df <- mpg
head(df)
audi_df <- df %>% 
           filter(manufacturer == "audi",
                  model == "a4")
audi_df

melt_audi_df <- melt(audi_df,
                     id.vars = c("manufacturer", "model", "year", "cyl", "trans"),
                     measure.vars = c("displ", "cty", "hwy"))
melt_audi_df

dcast(melt_audi_df,
      manufacturer + model + year + cyl + trans ~ variable,
      value.var = "value")





