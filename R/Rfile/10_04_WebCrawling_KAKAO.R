######################################################################
#                      191031 - KAKAO API: search img
######################################################################

# kakao api(이미지 검색)을 이용하여 이미지 찾고 파일로 저장

# 사용하는 패키지: 네트워크 연결을 통하여 
#                  서버에 접속해서 결과 받아올 때 
#                  일반적으로 많이 사용하는 패키지

# package("httr") // r에서 네트워크 연결
install.packages("httr")
library(httr)
library(stringr)

# open api address
url <- "https://dapi.kakao.com/v2/search/image"
keyword <- "query=아이유"

request_url <- str_c(url,
                     "?",
                     keyword)

# api 호출 주소
request_url <- URLencode(request_url)
request_url

apikey <- "66b73f8e998e3a167c60722e6e43c9db"

# web에서 클라이언트가 서버쪽 프로그램을 호출할 때 호출방식이라는게 있음
# 4가지 => get, post, put, delete
# 서버 프로그램 호출할 때
#    1. get
#         전달 데이터를 url 뒤에 붙여서 전달
#    2. post
#         전달 데이터가 request header에 붙어서 전달
result <- GET(request_url,
              add_headers(
                Authorization=paste("KakaoAK",
                                    apikey)))
http_status(result) # 접속결과 확인

result_data <- content(result) # 결과 추출
View(result_data)
result_data$documents[[1]]$thumbnail_url

# thumbnail <- vector(mode="character",length = length(result_data))
# 
# for(idx in 1:80) {
#   thumbnail[idx] <- result_data$documents[[idx]]$thumbnail_url
# }
# thumbnail

# request=> req, response=> res
for(idx in 1:length(result_data$documents)) {
  req <- result_data$documents[[idx]]$thumbnail_url
  #print(req)
  res=GET(req) # img 응답
  
  # 결과로 받은 이미지를 raw 형태로 추출 // 동영상, 이미지, pdf => binary // no txt
  imgData = content(res, "raw")
  writeBin(imgData,
           paste("C:/R_Lecture/img/img",
                 idx,
                 ".png"))
}

# html_json 안됨!!
# 인증코드나 헤더에 특별한 요소들이 있는 경우
# httr 패키지의 GET 메소드를 사용
# 데이터 프레임 형태가 아니라 응답 객체로 반환됨
#     -> content()