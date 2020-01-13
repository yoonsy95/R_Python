# Web
# 데이터 구축
# DB로부터 데이터를 얻어올 수 있음
# open api를 이용해서도 가능
# 파일로부터도 가능함
# 프로그램적으로 web scraping, crawling을 통해서도 데이터 구축
#           web scraping: 페이지 하나 기준으로 원하는 정보 추출
#           crawling: 규칙성을 가지고 여러 웹 사이트를 방문하여
#                     스크립트 이용하여 반복하여 추출

# HTML, CSS, JavaScript
# HTML: 웹 페이지의 내용, 구조 담당
# CSS: 웹페이지의 styling 담당
# JavaScript: 웹페이지의 동적처리를 담당

# 기본적으로 웹은 cs 구조로 되어 있음
# cs 구조: client-server 구조
# server 쪽 프로그램: seb server
#                     HTML, CSS, JavaScript 제공
# client 쪽 프로그램: chrome(browser)
#                     서버로부터 HTML, CSS, JavaScript를 받아서 화면에 rendering

# HTML, CSS, JavaScript를 이용하여 
# 클라이언트에게 제공해주는 웹페이지를 만들어봑
# 개발 툴 필요함

# 클라이언트에게 제공할 HTML 작성함

# 서버프로그램(web server)에게 프로젝트 알려줘야 함
# 만든 프로젝트를 web server에게 인지시켜야 함 => configure
# 웹 서버 프로그램을 기동시켜서 우리 프로젝트를 웹에 deploy // 띄움, 올림, 전개시킴

# web client(browser)로 url을 사용하여 
# 서버 쪽 프로그램에 접속하여 HTML을 받아 화면에 그림

# HTML, CS, JavaScript => 웹 언어

# W3C
# HTML이 발번해서 1999년 4.01 버전
# S3C가 1999년 12월에 HTML 4.01버전을 마지막으로 버전 업 없음
# HTML 문제점:
# 1. 정형성 없음 => 규격에 맞게 작성하지 아니해도 알아서 출력해줌
#                   유지보수시 문제점 발생하게 됨
# 2. 확장성 없음 => 정해진 태그만 이용하다보니 
#                   배우고 쓰기는 쉬우나 확장하기에는 적합하지 아니함

# 2000년부터 W3C는 HTML 표준을 다른것을 가미하여 위의 두 가지 문제를 해결하려 함
# 표준 재지정 => XML 도입 ex) <name></name> => 확장성 있음
# XML을 HTML에 도입하여 표준으로 끌고가려함
# XHTML 1.0 시작
# XML 사용에 회의적인 시각을 가지고 있는 몇몇 회사들이 컨소시엄 구성
# XML 대신 HTML 발전시킴 => HTML5
# HTML5 의의: 웹페이지 대신 웹 어플리케이션이 대세가 될 것
# 웹페이지 대신 Front-End Web Application을 사용하게 될 것
# Angular, react.js, View.js => JavaScript

# <html>
#   <body>
#       <h1></h1>
#   </body>
#</html>

# 부모-자식-후손 관계
# html: body => 자식
#       h1 => 후손
# body: html => 부모
#       h1 => 자식









