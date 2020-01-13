#############################################################
#                           if문
#############################################################

var1=100
var2=20

# 조건에 따라 실행되는 코드 블럭을 제어할 수 있음
  
if(var1>var2) { # T, F
  # 조건문 참
  cat("T")
} else {
  # 조건문 거짓
  cat("F")
}

# 축약형
var1=10
var2=20

ifelse(var1>var2,"T","F")

#############################################################
#                      반복문(for, while)
#############################################################
# for: 반복 횟수만큼 반복 실행
# while:  조건이 참을 동안 반복 실행

for(var1 in seq(2,4)) { # 자바의 for-each
  print(var1)
}

# seq(2:5) => 1 2 3 4
# seq(2,5) => 2 3 4 5

idx=1
mySum=0

while(idx<10) {
  mySum = mySum + idx
  idx=idx+1
}
mySum # 45

sum(c(1:9)) # 45

# 로직(제어문 이용) 1~100 사이의 3의 배수
for(var1 in seq(1100)) {
  if(var1%%3==0) {
   print(var1)
  } 
#  var1=var1+1 => 안써도 됨
}

# 1~100 prime number=> 소수 구하기
# 2랑 3 안나옴...ㅠㅠ
# 2는 2로 나눠서 안나옴 두번째 for문 바꿔줘야...ㅠㅠ
n <- 100
i <- 2
count <- 0

for(var1 in seq(i, n)) {
  div=var1%/%2

  count=0
  
  if(div>1) {
    for(idx in seq(2, div)) {
      if(var1%%idx == 0) {
        count = count+1
      }
    }
  }
  if(count==0) {
    print(var1)
  }
}



# 사용자 정의 함수(User Define Function)
# 제공된 함수 말고 직접 만듦

# 함수명 <- function(x) {...}
# 입력받은 숫자 제곱해서 돌려주는 함수
myFunc <- function(x) {
  x = x^2
  return(x)
}
var1=myFunc(5)
var1

var1=c(1:10)
sum(var1)

# sum()과 같은 mySum 만듦
mySum <- function(x) {
  result=0
  for(y in seq(1,x)) {
    result=result+y
  }
  return(result)
}

mySum(10)

# 파라메터 값이 c(1:10)인경우
# for(y in x)로 해도 됨
