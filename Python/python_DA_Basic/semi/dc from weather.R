require(xlsx)
require(dplyr)
library(ggplot2)
library(stringr)
require(reshape2)

incheon_1618 <- read.csv("C:/python_DA/semi/semiprj/incheon_1618.csv",
                       header = TRUE,
                       encoding = "CP949") # 기상 데이터 로드

decal_1618 <- read.csv("C:/python_DA/semi/semiprj/기상으로인한사유별지연및결항.csv",
                  fill = T,
                  header = T,
                  encoding = "CP949",
                  stringsAsFactors = F)

indc_1618 <- read.csv("C:/python_DA/semi/result/indc1618_2.csv",
                     header = TRUE,
                     encoding = "CP949") # 기상 데이터 로드


in1618 <- incheon_1618 # 원본 데이터 복사
dc1618 <- decal_1618
indc1618 <- indc_1618


head(in1618)
head(dc1618)
head(indc1618)

incheon_1618 <- subset(incheon_1618, select = -prep) # 불필요한 열 제거
dc1618 <- sapply(dc1618,str_replace_all,' - ','0')
dc1618_df = data.frame(dc1618,
                       stringsAsFactors = F)



dc1618_df$date <- as.Date(dc1618_df$date)
dc1618_df[,2:20] <- sapply(dc1618_df[,2:20], as.numeric) # 데이터 타입 가공
indc1618[,16:18] <- sapply(indc1618[,16:18], as.numeric) # 16 ~ 18



indc1618$date <- as.Date(indc1618$date)



class(dc1618_df$date)
class(indc1618$date)


dc1618 <- as.numeric(dc1618[,2:20])


ncol(dc1618)
str(incheon_1618) # 구조확인
str(dc1618_df)
str(indc1618)

# sapply(dc1618,str_replace_all,' - ','0')

in1618$firstcloudtop <- ifelse(is.na(in1618$firstcloudtop),0,in1618$firstcloudtop)
table(is.na(in1618$firstcloudtop))
table(is.na(in1618[14]))
ls(in1618)
ncol(in1618)

table(is.na(in1618[,3:18]))

in1618day <- read.csv("C:/python_DA/semi/result/daymean_nona.csv",
                      header = TRUE,
                      encoding = "CP949")


head(indc1618)


ls(indc1618)
ls(dc1618_df)
head(dc1618_df)

# dc1618_df <- rename(dc1618_df, year=date)
# indc1618 <- rename(indc1618, year=date)
new_df <- left_join(dc1618_df, in1618day, by = "year")# 데이터 셋 변경 확인요함

head(new_df)

View(new_df)
View(merge_dc1618)

  
merge_dc1618 <- new_df %>% 
                      mutate(delaycan = 지연.눈+지연.바람+지연.비+지연.시정+지연.운고+지연.태풍+지연.항로+지연.기타+결항.눈+바람+비+시정+운고+태풍+항로+기타)

# 지연 및 결항에 따른 날씨 요인 정리
out_dc1618 <- subset(merge_dc1618, select = -c(지연.눈, 지연.바람, 지연.비, 지연.시정, 지연.운고, 지연.태풍, 지연.항로,지연.기타, 결항.눈, 바람, 비 ,시정 ,운고, 태풍, 항로, 기타))

out_dc1618$year <- as.Date(out_dc1618$year, "%Y-%m-%d")

out_dc1618$year

str(out_dc1618["year"])



ggplot(data=out_dc1618,
      mapping = aes(x=reorder(화,delaycan),
           y=delaycan))+ 
  geom_col()
  
ggplot(data=out_dc1618,
       mapping = aes(x=year,
                     y=delaycan))+ 
  geom_col(width = 0.5)


View(out_dc1618)
ggplot(data=out_dc1618,
        aes(x=year,
           y=delaycan))+ 
  geom_point(aes(size=humi, color=temp))

ls(out_dc1618)
head(out_dc1618)


ggplot(data=economics,
       aes(x=date,
           y=psavert)) +
  geom_line()


indc1618_1 <- read.csv("C:/semiPj/data/indc1618_1.csv",
                         header = TRUE,
                         encoding = "CP949") # 상관관계 분석용 데이터 셋
indc1618_2 <- read.csv("C:/semiPj/data/indc1618_2.csv",
                       header = TRUE,
                       encoding = "CP949")

idnc1618_12_merge <- read.csv("C:/semiPj/data/idnc1618_12_merge.csv",
                       header = TRUE,
                       encoding = "CP949")
mg1618 <- idnc1618_12_merge


join_df <- merge(indc1618_1, indc1618_2, by="date")
merge()
head(join_df)


ls(indc1618_1)
head(indc1618_1)

cor(indc1618_1$tot,indc1618_1$visibility)
cor(indc1618_1$tot,indc1618_1$octa)
cor(indc1618_1$tot,indc1618_1$windy)
cor(indc1618_1$tot,indc1618_1$temp)
cor(indc1618_1$tot,indc1618_1$airpressure)
cor(indc1618_1$tot,indc1618_1$humi)
cor(indc1618_1$tot,indc1618_1$dewpoint_temp)
cor(indc1618_1$tot,indc1618_1$PM10)
cor(indc1618_1$tot,indc1618_1$PM25)
cor(indc1618_1$tot,indc1618_1$SO2)
cor(indc1618_1$tot,indc1618_1$CO)
cor(indc1618_1$tot,indc1618_1$NO2)

ls(indc1618)
cor(mg1618$tot,mg1618$visibility)
cor(mg1618$tot,mg1618$octa)
cor(mg1618$tot,mg1618$windy)
cor(mg1618$tot,mg1618$temp)
cor(mg1618$tot,mg1618$airpressure)
cor(mg1618$tot,mg1618$humi)
cor(mg1618$tot,mg1618$dewpoint_temp)
cor(mg1618$tot,mg1618$PM10)
cor(mg1618$tot,mg1618$PM25)
cor(mg1618$tot,mg1618$SO2)
cor(mg1618$tot,mg1618$CO)
cor(mg1618$tot,mg1618$NO2)


#                        df$score = ifelse(is.na(df$score),
#                                           "평균으로 대체",
#                                          df$score)
