# 구글 지도 서비스

# Google Map Platform 사용하려면 특정 패키지 필요함
# CRAN에 등록 안되어 있음 => github에 공유되어 있음

# VCS(Version Control System)
# 공동작업문제 해결위하여 나옴

# CVCS(Centralized Version Contron System)
# 원본을 중앙서버가 1개 들고 있고 나머지 사람들이 복사본을 가져다가 작업함
# 충돌 등의 문제를 CVCS가 해결
# 서버 터지거나 삭제되면 데이터 날아감

# DVCS(Distributed Version Contron System)
# 원본을 여러 곳에 보관 => Git
# Git repository(저장소)
# 이런 Git repository를 서비스 해주는 회사 => Github

######################################################
# 1. Github에 공유되어있는 ggmap package 설치해야 험
# 버전특성을 탐
# package들은 dependency(의존성)에 신경써야 함
sessionInfo() # 현재 R ver 확인: 3.6.1
# ggmap은 3.5.1에서 돌아감 => 해당 버전 설치해야

install.packages() # CRAN에서 받아서 설치

install.packages("devtools")
library(devtools)

install_github("dkahle/ggmap") # 이용하려면 devtools 패키지 설치해야 함
library(ggmap)

# https://cloud.google.com/maps-platform/terms
# 에서 이용약관 동의해야함
ggmap

# 구글 api key
# 지역코드 api 위로 올려줘야함 // 아래에 있음
googleAPIKey<-"AIzaSyDb8Oqv9AqTVBFWUKyOZh1SkSv_9SeEtKI"

# 구글 키 이용해서 인증 받아야 함
register_google(key=googleAPIKey)

gg_seoul <- get_googlemap("seoul",
                          maptype = "satellite",)
ggmap(gg_seoul)

#########
library(dplyr)
library(ggplot2)

# 한글 깨짐으로 유티코드로 변경
geo_code = geocode(enc2utf8("공덕역"))
geo_code

# google map을 그리려면(center) 위도 경도가 숫자형태의 벡터로 되어 있어야 함
geo_data = as.numeric(geo_code)
geo_data

get_googlemap(center=geo_data, # 해당 위도경도를 가운데로
              maptype = "roadmap",
              zoom=16) %>%
  ggmap() + 
  geom_point(data = geo_code,
             aes(x=lon, y=lat),
             size=5,
             color="red")

#######################

addr <- c("공덕역","역삼역")
gc <- geocode(enc2utf8(addr))
# as.data.type == ?
df <- data.frame(lon=gc$lon, lat=gc$lat)

cen <- c(mean(df$lon), mean(df$lat))

get_googlemap(center = cen,
              maptype="roadmap",
              zoom = 13,
              markers = df) %>%
  ggmap()
 
#######################

# 지하철역 주변 아파트 정보:
# 서울 열린 데이터 광장

# 아파트 실거래 금액: 국토부

#######################

# zoom
# interactive Graph
install.packages("plotly")
library(plotly)

# mpg data set을 이용하여 // in ggplot2
# 배기량과 고속도로 연비에 대한 산점도 그리기

df <- as.data.frame(mpg)
head(df)

g <- ggplot(df,
            aes(x=displ,
                y=hwy)) + 
  geom_point(size=3, col="blue")

ggplotly(g)
# 영역잡으면 확대, 마우스 올라가면 해당 값 보여줌
#     시계열 안됨
# html으로 보는 것도 가능

addr <- c("공덕역","역삼역")
gc <- geocode(enc2utf8(addr))
# as.data.type == ?
df <- data.frame(lon=gc$lon, lat=gc$lat)

cen <- c(mean(df$lon), mean(df$lat))

result <-get_googlemap(center = cen,
                       maptype="roadmap",
                       zoom = 13,
                       markers = df) %>%
  ggmap()

ggplotly(result)


#######################

# 시계열 그래프
# 시간에 따른 선그래프는 단순 확대만으로느 사용 힘듦
# 특정 구간에 대한 자세한 사항을 보기 위해서는 다른 패키지 사용

install.packages("dygraphs")
library(dygraphs)

# 예제 data set: econonomics

# 데이터르를 xts라는 형식으로 변환시켜줘야
# 시간에 따른 개인 저축를 변환 추이를선 그래프로 그림
ggplot(economics,
       aes(x=date,
           y=psavert)) + 
  geom_line()

library(xts)

save_rate <- xts(economics$psavert, # 데이터 형태 변환
                 order.by =economics$date)

unemp_rate <- xts(economics$unemploy/1000, # 데이터 형태 변환
                 order.by =economics$date)


unemp_save <- cbind(save_rate,unemp_rate)

dygraph(unemp_save) %>% 
  dyRangeSelector()






#######################
# 패널데이터 실습 (정형)
# MovieLens (정형)
# 로튼토마토 크롤링 (반정형: xml, html)
# kakao api (반정형: 글, 이미지?)
# 네이버댓글 크롤링 후 워드 클라우드드 (비정형)


















