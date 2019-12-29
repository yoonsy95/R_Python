#### Crawling & Scraping

---

- Web Crawling == Web Spidering

- - 인터넷 상에서 필요한 정보를 읽어와서 수집하는 일련의 과정(작업)
  - 자동화 봇인 crawler가 정해진 규칙에 따라 복수개의 웹 페이지를 browsing하는 행위

 

- Web Scraping
  - 하나의 웹 페이지에서 내가 원하는 부분을 추출하는 행
  - `css(jQuery) selector`를 이용하여 원하는 정보 추출
  - `selector`를 이용하여 추출하기 힘든 친구들 있음
    => `xpath` 사용

 

#### package

---

- 네트워크 통하여 `JSON` 데이터를 받아 데이터 프레임으로 만들기 위해 새로운 패키지 이용
  - **`jsonlite`**: 웹에서 `JSON` 데이터 호출시 사용
  - **`httr`**: 네트워크와 관련된 패키지



- 문자열 처리 위한 패키지: **`stringr`**

 

- 서버로부터 받은 HTML 태그로 구성된 문자열을 자료구조화 시키는 패키지: **`rvest`**

 

#### 서버 프로그램 호출

---

- 웹에서 클라이언트가 서버 쪽 프로그램을 호출할 때 호출방식이 있음

- 4가지(`GET`, `POST`, `PUT`, `DELETE`)가 있는데 `GET`, `POST` 많이 씀

  1. `GET`

  2. 전달 데이터를 url 뒤에 붙여서 전달

  3. `POST`

  4. 전달 데이터가 `request header`에 붙어서 전달


 

- 헤더에 인증코드나 다른 특별한 요소들이 있는 경우
            `html_json` 사용 안 됨
            `httr package`의 `GET()` 사용해야 함

  => 데이터 프레임의 형태가 아니라 응답 객체로 반한됨: `content()`

 

 

#### BookSearch

---

```r
# R에서 JSON 데이터 처리
# Network 통하여 JSON 데이터 받아
# Data Frame으로 만들기 위해 새로운 package를 이용

# loading lib
library(jsonlite)
library(httr)
library(stringr)  # 문자열 처리 위한 package


url <- 'http://localhost:8080/bookSearch/search?keyword='

# url에 keyword 입력 받아 주소 생성
request_url <- str_c(url,
                     # what=chatacter() => 문자 입력 받을 것
                     scan(what=character()))
request_url <- URLencode(request_url) # 한글로 입력될 경우 읽을 수 있도록 처리
request_url  # 주소 만들어짐

# 해당 경로의 JSON 데이터를 데이터 프레임로 변환 => fromJSON()
df <- fromJSON(request_url) 

# url의 port 번호가 8080이므로
# eclipse server start 상태여야 연동됨

# eclipse server가 stop 상태일 경우 에러문구
# Error in open.connection(con. 'rb') :
#	Failed to connect to localhost port 8080: Connection refused

# 찾은 도서 제목만 console창에 출력
for(idx in seq(1:nrow(df))) {
    # df$title => vector 집합으로 data frame 형태
    print(df$title[idx]) # vector로 하나씩 출력됨
}

# JSON을 이용하여 data frame을 생성할 수 있음
# data frame(keyword에 해당하는 도서 정보)을 csv 형식으로 파일에 저장
write.csv(df,
          file ='C:/R_Lecture/data/book.csv',
          row.names=F, # 행번호 제거
          quote=F)  # 따옴표 제거
					# 문자열 안에 ,가 있는 경우 다른 데이터로 인식하므로
					# 	되도록 제거하지 말 것!!

# data frame을 JSON으로 변환하려면 => toJSON()
df_json <- toJSON(df)

# json을 구조화시켜서 보기 편하게 출력
prettify(df_json)

# json을 txt file로 저장
write(df_json,   # prettify(df_json)
      file = 'C:/R_Lecture/data/book_json.txt')

# json 형태의 데이터 저장시 write(), 확장자는 .txt
# 구조화시키는 것보다 그냥 한 덩어리로 많이 저장함
# => JSON 형태의 주된 사용 목적은 XML 사이즈를 줄이기 위함
# 	 prettify()를 사용하면 공백이 많아져 사이즈가 커짐
```

