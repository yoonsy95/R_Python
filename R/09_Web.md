#### 데이터 구축

---

- DB, Open API, 파일을 이용해서 데이터를 얻어올 수 있음

- 프로그램적으로 Web Scraping, Crawilng을 통해서도 데이터 구축

  - Web Scraping: **페이지 하나 ** 기준으로 원하는 정보 추출
  - Crawling: 규칙성 가지고 **여러 웹 사이트** 방문하여 스크립트 이용하여 반복 추출

  

- HTML, CSS, JavaScript

  - HTML: 웹 페이지 내용, 구조 담당
  - CSS: 웹 페이지의 Styling(디자인) 담당
  - JavaScript: 웹 페이지의 동적처리 담당

  

- 기본적으로 웹은 Client - Server 구조로 되어 있음

- - Server 쪽 프로그램: web Server

    - HTML, CSS, JavaScript

  - Client 쪽 프로그램: chrome(browser)

  - - 서버로부터 HTML, CSS, JavaScript를 받아서 화면에 rendering(표현)

 

- HTML, CSS, JavaScript를 이용하여 클라이언트에게 제공해주는 웹페이지를 만들려면 개발툴 필요

- 클라이언트에게 제공할 HTML 작성함
- 만든 프로젝트를 서버프로그램(web server)에게 인지시켜야 함 => `configure`
- 웹 서버 프로그램을 기동시켜서 프로젝트를 웹에 deploy // 띄움, 올림, 전개시킴
- web client(browser)로 url을 사용하여 
  서버 쪽 프로그램에 접속하여 HTML을 받아 화면에 올림

 

- HTML, CSS, JavaScript => 웹 언어

  

---

- W3C

- - HTML이 발전해서 1999년 4.01버전

  - W3C가 1999년 12월에 HTML 4.01버전을 마지막로 버전 업그레이드 없음

  - HTML 문제점:

  - 1. 정형성 없음

    2. - 규격에 맞게 작성하지 않아도 알아서 출력
       - 유지보수시 문제점 발생하게 됨

    3. 확장성 없음

    4. - 정해진 태그만 이용하다보니
         배우고 쓰기에는 쉬우나 확장하기에는 적합하지 않음

 

- XML

- - 위의 두 가지 문제점을 해결하고자
                2000년부터 W3C는 HTML 표준을 다른 것을 가미하여 재지정함
  - XML 도입: 확장성있음
                       `<name></name>`
  - XML을 HTML에 도입하여 표준으로 가려 함
  - XHTML 1.0의 시작

 

- HTML5

- - XML 사용에 회의적인 시각을 지닌 몇 회사들이 컨소시엄 구성

  - XML 대신 HTML 발전시킴 => HTML5

  - HTML5 의의

  - - 웹페이지 대신 웹 어플리케이션이 대세가 되고
      Front-End Web Application을 사용하게 될 것

  - 

- Angular, react.js, View.js => JavaScript

 