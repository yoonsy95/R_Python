# Selenium을 이용한 동적 페이지 스크래핑
# Selenium을 r에서 사용할 수 있도로 도와주는 패키지 설치해야
install.packages("RSelenium")
library(RSelenium)

# r 프로그램이 Selenium 서버에 접속한 후 remote driver 객체를 return 받음
remDr <- remoteDriver(remoteServerAddr="localhost",
                      port=4445,
                      browserName="chrome")
remDr

# 접속 성공하면 remote driver를 이용하여 크롬 브라우저를 R code로 제어 가능
# browser open
remDr$open()

# open 된 브라우저의 주소 변경
remDr$navigate("http://localhost:8080/bookSearch/index.html")

# 입력상차 찾기
inputBox <- remDr$findElement(using="css", 
                              "[type=text]")

# 찾은 입력상자에 검색어 넣음
inputBox$sendKeysToElement(list('여행'))

# btn click
btn <- remDr$findElement(using="css",
                         "[type=button]")

# 찾은 버튼에 클릭 이벤트 발생
btn$clickElement()

# ajax 호출이 발샏ㅇ해서 출력된 화면에서 필요한 내용 추출
li_element <- remDr$findElements(using="css",
                                "li")
li_element

# 이렇게 얻어온 요소 각각에 대하여 함수 호출
myList <- sapply(li_element, function(x) {
  x$getElementText()
})

for(i in 1:length(myList)) {
  print(myList[[i]])
}














