### 파일 형식

---

- 파일로 데이터를 읽어올 때 일반 txt 파일 많이 사용하지 않음
- 컴퓨터(프로세스) 간 데이터를 주고 받으려 함
- 이를 위해서는 특정 형식이 필요

 

1. CSV 형식( Comma Seperated Value )

2. - 콤마 기호 이용하여 데이터 구분
   - 해당 문자열 전달하여 데이터 통신
   - ​	ex) "홍길동, 20, 서울, 김길동, 30, 부산, ..."

3. - 장점: 간단함

     ​		부가적인 데이터 적음

     ​		상대적으로 크기 작음

     ​			=> 많은 양의 데이터 처리 가능

4. - 단점: 구조적 데이터 표현 적합하지 않음

     ​		ex) 전화번호 두 개 이상인 경우 처리하지 못함

     ​		parsing 작업 복잡

     ​			=> 유지보수 문제 발생

#

2. Xml 형식

1. - tag(element) 이용하여 데이터 표현하는 방식

     ```xml
     <name></name><age></age><address></address>
     ```

   - 장점: 사용 편리함

     ​		 데이터 의미 표현 가능 

     ​		 구조적 데이터 표현하기에 적합

     ​		 중첩해서 사용 가능

     ```xml
     <phone>
         <mobile></mobile>
         <home></home>
     </phone>
     ```

   - 단점: 부가적인 데이터 매우 큼

     ​		  용량 많이 차지함

#

3. JSON 형식( JavaScript Object Notation )

1. - 구조적으로 표현 가능하면서 XML보다 크기 작음

     ```json
     { name: xxx, age: 20, address: xxxxxx }
     ```

      

#### 데이터 입력

---

1. 숫자 입력

   ```r
   myNum <- scan()
   ```



2. 문자열 입력

   ```r
   var1 <- scan(what = character())
   ```

   

3. 편집창 입력

   ```r
   var1 <- data.frame() 
   df <- edit(var1)
   ```

   - `data.frame` 안하면 `class(df)`시 function나옴

     사용하기 전에 데이터 구조 정의해주자 

 

\##########################################################

데이터 불러오기

\##########################################################

1. text 파일

2. - " ,      " 로 구분된 데이터 읽음
   - read.table()

 

1. CSV 파일

2. - CSV 파일 읽어서 데이터 프레임으로 만듦
   - read.csv()
   - 구분자는 기본이 콤마인지라 sep="," 안넣어도 됨
   - 한글 사용시 fileEncoding="UTF-8"
   - header 있으면 header=T
   - 직접 파일 선택하려면 경로 대신 file.choose()

 

1. XLSX 파일

2. - read.xlsx()
   - 패키지 설치해야함 **xlsx**
   - Sys.setenv(JAVA_HOME="C:\\Program      Files\\Java\\jre1.8.0_231")
   - 첫 번째 시트 불러오려면: sheetIndex      = 1
   - encoding="UTF-8"

 

 

\##########################################################

데이터 저장하기

\##########################################################

- cat(): 일반적인 문자열 텍스트를 파일에 저장

본래 용도는 데이터 타입이 다른 여러 값을 콘솔에 나타나게 하는 것

분석 결과(vector)를 파일에 저장

- write.table():     데이터 프레임을 파일에 저장
- capture.output():     분석결과(list,     table)를 파일에 저장

 

cat( "처리 결과: ", "\n", "\n",

file="fileAddress",

**append=T**) => **이어쓰기**

 

write.table( varName,

file = "fileAddress",

**row.names = F**,  => 행번호 삭제

**quote = F**, => 따옴표 삭제

append = T)

 

capture.output( list | table,  ex) summary(varName)

file = "fileAddress",

append = T)

 

write.xlsx( varName, "fileAddress" )

 

**※** **따옴표는** **되도록** **삭제하지** **말** **것****!**

  따옴표 안의 값에 콤마나 기호 있는 경우

  다시 불러올 때 값을 나눠서 불러들어옴