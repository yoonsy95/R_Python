# R의 주석은 # 사용 // 1 line

# 일반적으로 프래그래밍 언어에서 statement를 종료하기 위하여 사용하는 ";"
# R은 세미콜론 생략 가능함
3+5; 2*6; 6-8;
3+5

# 코드 수행 위해서는 Ctrl+Enter

# R은 대소문자 구분함
# 변수 생성시 camelcase
result=100;
myResult # camelcase notation
MyReuslt # pascal notation
my_result 
myresult=200 # 가독성 떨어짐, 알아보기 힘듦
##################################################


myResult=200      # assignment
myResult <- 300   # assignment
400 -> myResult   # assignment
myResult
print(myResult)   # 변수 출력
print("result: " + myResult) # ERROR 다른타입 안됨

# 여러개의 값 출력시 cat()
cat("result: ", myResult)

##################################################
# 멤버를 이용한 변수 선언
goods.price=3000
goods.code="001"
goods.name="냉장고"

##################################################
# 출력되는 형식
mySeq=seq(100) # 1 ~ 100, 1++ 숫자 집합
mySeq=seq(5,100) # 5 ~ 100, 1++ 숫자 집합
mySeq=seq(1,100,by=2) # by => 증감
mySeq=seq(100,1,by=-2)
mySeq
