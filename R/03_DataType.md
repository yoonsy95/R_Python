#### 기본 데이터 타입

---

1. 숫자형(numeric): 숫자로 되어 있으며 정수형과 실수형을 의미함

   ```r
   100   # 실수형
   100L  # 정수형
   ```

   

2. 문자열(character): 하나 혹은 둘 이상의 문자의 집합

   ```r
   '홍길동'
   "홍길동"
   ```

   

3. 논리형(logical)

    ```r
    TRUE   # T
    FALSE  # F
    ```

    

4. 복소수형(comoplex)

    ```r
    4-3i  #허수
    ```

    

#### 특수 데이터 타입

---

1. NULL: 객체가 존재하지 않음을 지칭하는 객체

   `var1 = NULL `=> 데이터가 존재하지 않음

2. NA: Not Available: 결측값, 실제로 사용 불가함

3. NaN: Not Available Number
          Not A Number      : 연산 불가한 숫자
    
4. Inf: infinity, 양의 무한대

5. -Inf: 음의 무한대

 

#### 데이터 타입 알아보기

---

```r
var1=100
var2=100L
var3="Hello"
var4=T
var5=4-3i
var6=NULL
var7=sqrt(-3)
```



1. mode()

   ```r
   mode(var1)    # numeric
   mode(var2)    # numeric
   mode(var3)    # character
   mode(var4)    # logical
   mode(var5)    # complex
   mode(var6)    # NULL
   mode(var7)    # numeric // 계산할 수는 없지만 숫자
   ```

   

2. is 계열의 함수

   ```r
   is.numeric(var1)     # TRUE
   is.numeric(var2)     # TRUE
   is.numeric(var3)     # FALSE
   is.integer(var1)     # FALSE
   is.integer(var2)     # TRUE
   is.character(var3)   
   is.logical(var4)
   is.complex(var5)
   is.null(var6)
   ...
   ```

   



**※** **mode()와 str() 차이점**

   ```r
mode(var1)  # numeric   타입
str(var1)   # num 100   타입 값
   ```



 

#### 데이터 우선순위

---

`character` -> `complex` -> `numeric` -> `logical`

```r
myVector <- c(T, 10, 30, "Hello")
# 데이터 타입이 다를 경우 우선 순위가 높은 데이터 타입으로 변경됨
# "T", "10", "30", "Hello"
```



#### 데이터 타입변경(type casting)

---

```r
var1 <- 3.14159265358979
var2 <- 0
var3 <- "3.1415"
var4 <- "Hello"
```

 ```r
as.character(var1)  # "3.14159265358979"
as.integer(var1)    # 3
as.logiaal(var1)    # T => 0을 제외한 모든 것
as.logical(var1)    # F
as.numeric(var3)    # 3.1415
 ```





 