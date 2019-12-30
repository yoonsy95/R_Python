``` r
var1 <- 100
var2 <- 3

var1 / var2   # 자바: 33 => 정수 / 정수 = 정수     
              # R은 실생활의 연산처럼 수행함 => 실수
```

 #

#### 몫, 나머지 구하기

---

```R
# 몫 구하기
var1 %/% var2

# 나머지 구하기
var1 %% var2
```



 

#### 비교 연산자

---

```r
var1 == var1     # boolean 보다 logical type이라는 말 많이 사용함
var1 != var2     # 결과값은 대문자로 표현됨(true X, TRUE O)
```





#### 논리 연산자

---

- AND 논리 연산자 => &, &&: 양 쪽 값이 TRUE이면 TRUE

  ```r
  TRUE & FALSE     # FALSE
  TRUE && FALSE    # FALSE
  ```

  

- OR 논리 연산자 => |, ||: 하나라도 TRUE이면 TRUE

  ```R
  TRUE | FALSE     # TRUE
  TRUE || FALSE    # FALSE
  ```

  

- **&와 &&의 차이점**

  ```R
  c(TRUE, FALSE) & c(TRUE, TRUE)          # 일반적으로 같은 인덱스끼리 계산함
  							    	    # 벡터 연산값 => 벡터
  
  c(TRUE, FALSE) && c(TRUE, TRUE)         # 인덱스 0(첫번째 요소)만 계산함
  
  c(TRUE, FALSE, TRUE) & c(FALSE, TRUE)   # 경고 문자 뜸
  										# recycling rule에 의하여 결과값 출력됨
  										# c(T,F,T) & c(F,T,F)
  										# 결과: c(F,F,F)
  										# 사용 자제할 것
  ```

  

- NOT 논리 연산자

  ```R
  ! c(T, F, T, F)
  ```

  

#### 기타 함수

---

- R은 다른 언어와 마찬가지로 다양한 수학함수 내장

- 매우 많으니 모두 외우기보다는 필요할 때마다 찾아서 수행

```r
abs(-3)
round(3.1415, 2)
sqrt(4)
```



