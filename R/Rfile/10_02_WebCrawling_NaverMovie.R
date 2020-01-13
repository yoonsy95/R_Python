#######################################################################################

# web crawling: 인터넷 상에서 필요한 정보를 읽어와서 수집하는 일련의 작업(과정)
#     == web spidering
#     자동화 봇인 crawler가 정해진 규칙에 따라
#         복수개의 웹 페이지를 browsing하는 행위

# web scraping
#     => 하나의 웹 페이지에서 내가 원하는 부분을 추출하는 행위
#     css(jquery) selector를 이용하여 필요한 정보 추출
#     selector를 이용하여 추출하기 힘든 친구들 있음
#         추가적으로 xpath 사용

# 특정 사이트에 접속하여 내가 원하는 데이터를 추출해보자

# 1. 서버로부터 받은 HTML 태그로 구성된 문자열을
#    자료구조화 시키는 패키지 이용
install.packages("rvest")
library(rvest)
library(stringr)

# 2. url 준비
url <- "https://movie.naver.com/movie/point/af/list.nhn"
page <- "page="

request_url <- str_c(url, "?", page, 1)
request_url

# 3. 준비된 url로 서버에 접속, html을 읽어 자료구조화시킴 not 자료구조화
html_page = read_html(request_url)
html_page

# 4. selector를 이용하여 추출하기 원하는 요소(element) 선택
nodes = html_nodes(html_page,"td.title > a.movie")
nodes

# 5. tag 사이에 들어있는 text 추출
title <- html_text(nodes)
title

# 6. selector를 이용하여 리뷰 요소 선택
# 구조적 아니면 다 불러온 후 잘라내야
nodes = html_nodes(html_page, "td.title")
review <- html_text(nodes, trim=T) # trim=T 앞 뒤 공백제거
class(txt) # character => vector

# 7. 필요없는 문자들 제거
review = str_remove_all(review, "\t")
review = str_remove_all(review, "\n")
review = str_remove_all(review, "신고") # 본문에 있으면 애매해짐
review

# 8. 영화제목과 리뷰에 대한 내용을 추출
df=cbind(title, review)
View(df)

# 9. 구축한 데이터 파일에 저장

#######################################################################################

# 같은 작업 xpath 사용하여 처리

install.packages("rvest")
library(rvest)
library(stringr)

url <- "http://movie.naver.com/movie/point/af/list.nhn"
page <- "page="

request_url <- str_c(url, "?", page, 1)

html_page = read_html(request_url)

nodes = html_nodes(html_page, "td.title > a.movie")

title <- html_text(nodes, trim = T)
title

###################################################
#                 xpath - Review 1
###################################################

review = vector(mode = "character", length = 10)
for(idx in 1:10) {
  myPath = str_c('//*[@id="old_content"]/table/tbody/tr[', 
                 idx,
                 ']/td[2]/text()')
  nodes = html_nodes(html_page,
                     xpath = myPath)
  txt<-html_text(nodes,trim=T)
  review[idx]=txt[3]
}
review

###################################################
#                 x-path - Review 2
###################################################

# review 부분 xpath로 가져옴
nodes = html_nodes(html_page,
                   xpath='//*[@id="old_content"]/table/tbody/tr[1]/td[2]/text()')
# xpath => //*[@id="old_content"]/table/tbody/tr[1]/td[2]/text()

reveiw<-html_text(nodes,trim=T)
review[3]