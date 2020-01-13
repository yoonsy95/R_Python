#############################################################
#                    Data Input/Output
#############################################################

myNum<-scan()
myNum  # vector

# 문자열 입력
var1=scan(what=character())

# 키보드로부터 데이터 받기 위하여 edit() 이용
# 입력 창 나옴
var1=data.frame()

df=edit(var1)
df

#############################################################

# Read File

# txt file에 ","로 구분도니 데이터 읽음
# read.table() 사용

getwd()
setwd("C:/R_Lecture/data")
#setwd(str_c(getwd(),"/data"))

# 한글 사용시 fileEncoding = "UTF-8" 속성 추가
# header 있으면 header=T 속성 추가
student_midterm=read.table(file="student_midterm.txt", 
                           sep=",", 
                           fileEncoding = "UTF-8", 
                           header=T)

student_midterm=read.table(file.choose(),
                           sep=",", fileEncoding = "UTF-8")
student_midterm

class(student_midterm)

#############################################################

var1=c("홍길동")
var2=c(10,20,30)

rm(list=ls()) # ls() => 환경창에 있는 객체

cat("\014") # console창 clear

# file로 데이터를 읽어올 때 일반 txt 파일 많이 사용하지 않음
# 컴퓨터(프로세스) 간 데이터 주고 받으려 함
# 프로세스 간 데이터 통신하기 위하여 특정 형식 이용하여 데이터 주고 받음

# 1. CSV 형식(Comma Seperated Value)
# 콤마 기호 이용하여 데이터 구분함
# 해당 문자열 전달하여 데이터 통신
#   ex) 홍길동, 20, 서울, 김, 30,...
# csv 방식 장점: 간단함. 부가적인 데이터 적음. 상대적으로 크기 작음
#                 => 많은 양의 데이터 처리 가능
# csv 방식 단점: 구조적 데이터 표현 적합하지 않음
#                 => 인당 번호 2개 이상일 경우 처리 못함
#                 => parsing 작업 복잡
#                유지보수 문제 발생


# 2. xml 형식
# tag(element) 이용하여 데이터 표현하는 방식
#   ex) <name></name><age></age><address></address>

# 장점: 중첩하여 사용 가능
#               ex)<phone>
#                       <mobile></mobile>
#                       <home></home>
#                  </phone>
#       구조적 데이터 표현하기에 적합함
#       사용 편리함
#       데이터 의미 표현 가능

# 단점: 부가적인 데이터 매우 큼


# 3. JSON(JavaScript Object Notation) 형식
#   ex) {name: , age: , address, ...}
# 구조적 표현가능하면서 XML 보다 사이즈 작음

# read.csv()=> csv 파일 읽어서 데이터 프레임으로 만듦
#              default: sep=","
df=read.csv(file.choose(),
            fileEncoding = "UTF-8")
df

install.packages("xlsx")
library(xlsx)

Sys.setenv(JAVA_HOME="C:\\Program Files\\Java\\jre1.8.0_231")

student_midterm<-read.xlsx(file.choose(),
                           sheetIndex = 1,
                           encoding = "UTF-8")
student_midterm

#############################################################

# 처리된 결과를 파일에 적음
# write.table(): 파일에 데이터 프레임임으로 저장
# cat(): 일반적인 문자열 텍스트를 파일에 저장
#         여러 값을 콘솔에 나타나게 하던 것이지만 파일에 적용
#         분석결과(vector)를 파일에 저장
# capture.output(): 분석겨과(list, tableb) 파일에 저장
cat("처리 결과:","/n","/n",
    file="C:/R_Lecture/data/report.txt",
    append=T)

write.table(student_midterm,
        file="C:/R_Lecture/data/report.txt",
        row.names = F, # 행번호 삭제
        quote=F, # "" 삭제
        append=T)

capture.output(summary(student_midterm),
        file="C:/R_Lecture/data/report.txt",
        append=T) # 이어쓰기


# write.xlsx()
df=data.frame(x=c(1:5),
              y=seq(1,10,2),
              z=c("a","b","c","d","e"),
              stringsAsFactors = F)
df

write.xlsx(df,"C:/R_Lecture/data/report.xlsx")
