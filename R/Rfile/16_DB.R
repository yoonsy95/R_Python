# R에서 DB 연결

# MySQL에 연결해서 데이터 가져오기

# 1. MySQL DBMS rlehd: mysqld

# 2. R에서 DBMS에 접근하려면 몇 개의 패지기가 필요
# Java 언어 이용 => Java 설치되어 있어야 함
# JAVA_HOME 환경변수도 잡아줘야 함

# - R언어에서 Java 언어를 사용하기 위한 패키지
install.packages("rJava")
# - R언어에서 JDBC 기능을 이용하기 위한 패키지
#   자바로 DB를 사용하기 위한 lib
install.packages("RJDBC")
# - DB 사용하기 위한 패키지 // 조작
install.packages("DBI")

library(rJava)
library(RJDBC)
library(DBI)

# 필요한 패키지와 로딩이 끝나고 드라이버 필요함
# 자바 언어가 DB에 접속하고 사용위한 기능이 들어있는 lib
# 사용하는 DB 마다 설정방법이 다름

# MySQL Driver 설정
# 자바가 DB를 접속, 이용하기 위한 설정
drv=JDBC(driverClass = "com.mysql.jdbc.Driver",
         classPath = "C:\\R_Lecture\\mysql-connector-java-5.1.48-bin.jar")

# R 언어에서 DB 연결
conn <- dbConnect(drv, 
                  "jdbc:mysql://localhost:3306/library",
                  "data", # Mysql id
                  "data") # Mysql pwd

# Query 실행
# SQL:  데이터베이스를 제어하기 위한 언어
sql = "select * from book"

sql = "select btitle from book where bprice>55000"

# 한 줄을 가져와도 무조건 df 구조로!
df <- dbGetQuery(conn, sql);
head(df)
View(df)

library(dplyr)

df %>% filter(bprice > 55000) %>%
  select(btitle)

##############################
# R 기본 & EDA (끝남)
# ==> R 샤이니(췝 프레임워크)
#       대신에 파이썬 flask로 대체


# Python
# => data type & data structure & 로직
# => numpy & pandas를 이용한 EDA
# => 통계 개념, 파이썬에서 처리, 알에서 처리
# => Tensorflow를 이용한 머신러닝 // AI
# => deep learning(CNN)
# => R에서 어떻게 하나?






