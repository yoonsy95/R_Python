# R은 데이터 타입이 트게 두 가지가 존재
# - 기본 데이터 타입
# - 특수 테이터 타입

# 기본 데이터 타입
# 1. 숫자형(numeric): 숫자로 되어있으며 정수형과 실수형을 의미함
100   # 그냥 숫자만 있으면 실수
100L  # 뒤에 "L"이 붙어 있으면 정수형

# 2. 문자열(character): 하나 혹은 둘 이상의 문자의 집합
'홍길동'  # 문자열
"홍길동"  # 문자열
'홍'      # 문자열

# 3. 논리형(logical): TRUE(T), FALSE(F)

# 4. 복소수형(complex): 4-3i // 허수


# 특수 데이터 타입
# 1. NULL: 객체가 존재하지 아니함을 지칭하는 객체
var1=NULL # EMPTY, 아무것도 존재하지 아니함

# 2. NA: Not Available, 결측값, 실제 사용 불가

# 3. NaN: Not Availabel Number,
#         Not A Number           연산 불가한 숫자
sqrt(-3)

# 4. Inf: Infinity, 양의 무한대

# 5. -Inf: 음의 무한대

##################################################
var1 = 100
var2 = 100L
var3 = "Hello"
var4 = TRUE
var5 = 4-3i
var6 = NULL
var7 = sqrt(-3)

# dtype 조사하기 위하여 제공된 함수 mode()
mode(var1) # numeric 
mode(var2) # numeric
mode(var3) # character
mode(var4) # logical
mode(var5) # complex
mode(var6) # NULL
mode(var7) # numeric, 계산할 순 없지만 숫자이기에 숫자

# is 계열의 함수
is.numeric(var1) # TRUE
is.numeric(var2) # TRUE
is.numeric(var3) # FALSE

is.integer(var1) # FALSE
is.integer(var2) # TRUE

is.character(var3)
is.logical(var4)
is.complex(var5)
is.null(var6)

# is.blahblah... etc

# dtype 우선순위
# 기본 데이터 타입 4개 중 우선순위 높은 순
# character -> complex -> numeric -> logical

# vector: 1차원, 선형, 같은 자료구조
myVector = c(T, 10, 30) # numeric으로 통일
myVector

# character가 가장 우선순위가 높으므로 모두 char로 바뀜
myVector = c(T, 10, 30, "Hello")
myVector

# 하나의 데이터 타입을 다른 데이터 타입으로 변환 // type casting
var1 <- 3.14159265358979
var2 <- 0
var3 <- "3.1415"
var4 <- "Hello"

# 데이터 타입을 변경할 때는 as 계열의 함수 이용
as.character(var1) # "3.14159265358979"
as.integer(var1)   # 3
as.logical(var1)   # TRUE // 0을 제외한 모든 것
as.logical(var2)   # FALSE
as.numeric(var3)   # 3.1415
as.double(var3)    # 3.1415
