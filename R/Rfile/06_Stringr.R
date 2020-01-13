#############################################################
#                        문자열 처리
#############################################################

# 빅데이터 : 많은 양의 데이터
#          : 3V
#          : 1. Volume : 정해진 시간내에 처리할 수 없는
#                           많은 양의 데이터
#            2. velocity : 데이터 생성속도
#            3. variety : 다양성
# 일반적으로 빅데이터 처리는 문자열 처리를 동반하는 경우가 많음
# 문자열 처리는 stringr package를 이용하면 쉽고 편하게 할 수 있다.
install.packages("stringr")
library(stringr)

var1 = "Honggd1234Leess9032YOU25최길동2009"

# 1. 문자열의 길이를 구해보자
str_length(var1)    # 31 (한글1글자도 1개)
# 직접세어봐야해 한글을 어떻게 처리하는지 모름

# 2. 찾는 문자열이 시작과 끝을 알려주는것
str_locate(var1,"9032")
# 내가 찾고 싶은 것의 위치를 알아 내는것
class(str_locate(var1,"9032"))
# class : 자료구조를 알려주는 method
# mode : data type 알려주는 method
# 결과로 return되는 형태 matrix

#3. 부분문자열을 구해보기
str_sub(var1, 3, 8) # 처음과 끝 포함됨

#4. 대소문자 변경
str_to_lower(var1)
str_to_upper(var1)

#5. 문자열 교체
var1="Honggd1234Hong99032YOU25최길동2009"
str_replace(var1,"Hong","KIM")
str_replace_all(var1,"Hong","KIM")

#6. 문자열 결합
var2="홍"
var3="길동"
str_c(var2, var3)

#7. 문자열 분할
var1="Honggd1234,Leess99032,YOU25,최길동2009"
str_split(var1,",")
#   => 데이터 구조: list // class()

#8. 문자열 결합
var1=c("홍길동","김길동","최길동")
paste(var1,collapse="-")


#############################################################
#                정규표현식(regular expression)
#############################################################

# 문자열 처리 쉽고 편하게 하기 위함
var1="Honggd1234,Leess99032,YOU25,최길동2009"

# 조건에 부합되는 문자열 추출
str_extract(var1,"[a-z]{4}")
str_extract_all(var1,"[a-z]{4}")
str_extract_all(var1,"[A-Z]{2}")
str_extract_all(var1,"[a-z]{2,}")  # 2개 이상
str_extract_all(var1,"[a-z]{2,3}") # 2~3개

# 한글만 추출
str_extract_all(var1,"[가-힣]{2,}")

# 숫자만 추출
str_extract_all(var1,"[0-9]{2,}")

# 한글 제외한 나머지 문자 추출
str_extract_all(var1,"[A-Za-z0-9]{2,}")
str_extract_all(var1,"[^가-힣]{5}")

# 주민등록변호 검사
myId="801112-1210419"

str_extract_all(myId,"[0-9]{6}-[1234][0-9]{6}")


a=str_extract_all(var1,"[^가-힣]")
a # list 형태..???, [[1]] 안에 주르륵
a[[1]] # list 형태
paste(a[[1]], collapse="")
