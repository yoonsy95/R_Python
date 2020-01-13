install.packages("lubridate")
library(lubridate)
library(dplyr)

# incheon_1618 csv 파일 불러와 incheon1618에 저장
incheon1618<-read.csv('C:\\python_DA\\semi\\semiprj\\incheon_1618.csv')

# 원본 보존을 위하여 incheon1618을 in1618에 옮김
in1618<-incheon1618

# date열을 year month day hour 열로 나누기
# in1618$date<-as.character(in1618$date)
# in1618<-transform(in1618, 
#                   year=as.numeric(substr(date,1,4)),
#                   month=as.numeric(substr(date,5,6)),
#                   day=as.numeric(substr(date,7,8)),
#                   hour=as.numeric(substr(date,9,10)))

in1618$date<-ymd_h(in1618$date)
in1618$year<-year(in1618$date)
in1618$month<-month(in1618$date)
in1618$day<-day(in1618$date)
in1618$hour<-hour(in1618$date)

head(in1618)

# firstcloudtop 결측치 -> 10
in1618$firstcloudtop[is.na(in1618$firstcloudtop)] <- 10

# prep 열 삭제
in1618<-in1618[,-13]

# 대기오염 평균으로
in1618$SO2[is.na(in1618$SO2)] <- mean(in1618$SO2, na.rm = TRUE)
in1618$CO[is.na(in1618$CO)] <- mean(in1618$CO, na.rm = TRUE)
in1618$O3[is.na(in1618$O3)] <- mean(in1618$O3, na.rm = TRUE)
in1618$NO2[is.na(in1618$NO2)] <- mean(in1618$NO2, na.rm = TRUE)
in1618$PM10[is.na(in1618$PM10)] <- mean(in1618$PM10, na.rm = TRUE)
in1618$PM25[is.na(in1618$PM25)] <- mean(in1618$PM25, na.rm = TRUE)

# 값이 없는 한 행 날리기
in161801<-na.omit(in1618)
sum(is.na(in1618$wind_direction))
sum(is.na(in161801))


# 시 -> 일: pivot table
intotpivot<-summarise(group_by(in161801, year, month, day),
                      windy=as.integer(mean(windy, na.rm = T)),
                      visibility=median(visibility, na.rm=T),
                      octa=as.integer(median(octa, na.rm=T)),
                      temp=mean(temp), 
                      dewpoint_temp=mean(dewpoint_temp),
                      humi=mean(humi),
                      sealevelpressure=mean(sealevelpressure),
                      airpressure=mean(airpressure),
                      SO2=mean(SO2),
                      CO=mean(CO),
                      O3=mean(O3),
                      NO2=mean(NO2),
                      PM10=mean(PM10),
                      PM25=mean(PM25)) %>%
  as.data.frame()

# (단, 인천공항의 경우 30분 간격으로 정시관측을 실시하므로 특별관측보고를 생략한다.) 
# 1) 평균풍향이 가장 최근에 보고한 풍향보다 60 ° 이상 변화하고, 변화전과/또는 후의 
# 평균풍속이 10 kt ( 5 m/s) 이상일 때 
# 2) 평균풍속이 가장 최근에 보고한 평균풍속으로부터 10 kt (5 m/s) 이상 변화할 때 
# 3) 평균풍속의 변동(gust)이 최종보고에 주어진 값보다 10 kt ( 5m/s)이상 변화 하고 
# 전과 또는 후의 평균풍속이 15 kt (7.7 m/s)이상 일 때 
# 4) 시정이 호전되면서 다음 기준치 중 하나이상의 값과 같아지거나 경과 할 때 또는 
# 악화되면서 기준치 중 하나이상의 값을 경과 할 때 
# - 기준치(m) : 800, 1500, 3000 또는 5000 
# 5) 활주로가시거리가 호전되면서 다음 기준치 중 하나이상의 값과 같아지거나 경과 
# 할 때 또는 악화되면서 기준치 중 하나이상의 값을 경과 할 때 
# - 기준치(m) : 50, 175, 300, 550 또는 800 
# 6) 다음의 기상현상이 시작, 종료 또는 강도의 변화가 발생할 때 
# - 어는 강수 
# - 보통 또는 강한 강수(소나기 포함) 
# - 뇌전(강수 유) 
# - 먼지폭풍 
- 모래폭풍 
- 깔때기구름(토네이도 또는 용오름) 
7) 다음의 기상현상이 시작 또는 종료될 때 
- 어는 안개 
- 낮게 날린 먼지, 모래 또는 눈 
- 높게 날린 먼지, 모래 또는 눈 
- 뇌전(강수 무) 
- 스콜 
3-2 
항공기상업무지침8) BKN 또는 OVC 이상의 최하층의 운저 높이가 상승하면서 다음 기준치 중 하나 
이상의 값과 같아지거나 경과 할 때 또는 하강하면서 다음 기준치 중 하나이상의 
값을 경과 할 때 
- 기준치(ft/m) : 100/30, 200/60, 500/150, 1000/300, 1500/450 
9) 1500 ft (450 m) 미만의 높이에 있는 운량이 다음과 같이 변할 때 
- SCT이하 에서 BKN 또는 OVC로 변화 
- BKN 또는 OVC에서 SCT이하로 변화 
10) 하늘이 차폐되었을 때 수직시정이 호전되면서 다음 기준치 중 하나이상의 값과 같아 
지거나 경과 할 때 또는 악화되면서 기준치중 하나이상의 값을 경과 할 때 
- 기준치(ft/m) : 100/30, 200/60, 500/150 또는 1000/300 

