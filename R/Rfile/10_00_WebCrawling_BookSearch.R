# R에서 JSON 데이터 처리

# Network 통하여 JSON 데이터 받아
# Data Frame으로 만들기 위해 새로운 package를 이용

# 1. install package
install.packages("jsonlite")
install.packages("httr")

# 2. loading package
library(jsonlite)
library(httr)

# 3. 문자열 처리 위한 package
library(stringr)

url <- "http://localhost:8080/bookSearch/search?keyword="


request_url <- str_c(url, 
                     # what=character() => 문자 입력 받을 것
                     scan(what=character()))
request_url <- URLencode(request_url) # 한글처리
request_url  # 주소 만들어짐

df <- fromJSON(request_url) # eclipse server start 상태여야!!!!!
# 에러문구
# Error in open.connection(con, "rb") : 
#     Failed to connect to localhost port 8080: Connection refused


df
View(df)  # data frame 형태로 새로운 탭에서
str(df)   # structure // data frame 구조 파악
names(df) # col name

# 찾은 도서 제목만 console에 출력력
for(idx in seq(1:nrow(df))) { # nrow() => num row
  # df$title # vector 집합 => data frame
  print(df$title[idx]) # vector로 하나씩 출력됨
}

# JSON을 이용하여 Data Frame을 생성할 수 있어요
# data frame을 csv 형식으로 file에 저장

write.csv(df,
          file = "C:/R_Lecture/data/book1.csv",
          row.names = F, # nrow 제거
          # quote = F)   # 따옴표 제거 
                         #    => 문자열 안에 , 있을 경우 인식됨 => 되도록 넣어
          quote = T)

# Data Frame을 JSON으로 변경하려면?
df_json <- toJSON(df)
df_json            # 하나의 덩어리로 출력력
prettify(df_json)  # 구조화 시켜서 보기 편하게 출력
write(df_json,
      file = "C:/R_Lecture/data/book_json.txt")

write(prettify(df_json),
      file = "C:/R_Lecture/data/book_json.txt")

# .csv => json으로 작성
# json형태의 데이터를 저장하려면 그냥 write로, 파일 확장자는 txt!
#     사용 큰 목적: XML 사이즈 줄이기 위하여
#     prettify(df_json) => 공백이 많아 사이즈 별로 줄지 아니함
