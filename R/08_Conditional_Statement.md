#### if 문

---

- 조건에 따라 실행되는 코드 블럭을 제어할 수 있음

  ```r
  if( condition ) {
      condition=T
  } else {
      condition==F
  }
  ```

  

- 축약형

  ```r
  ifelse( condition, T, F )
  ```

  

  #

#### 반복문( for, while )

---

- for문

- - 반복 횟수만큼 반복 실행

    ```r
    for (var1 in numArange) {
        ...
    }
    ```

    

- while문 

- - 조건이 참일 동안 반복 실행

    ```r
    while( condition ) {
        ...
    }
    ```

    #

#### 연습문제

---

1. 1부터 10까지 합구하기

   ```r
   idx <- 1
   mySum <- 0
   
   while( idx <= 10 ) {
       mySum += idx
       idx += 1
   }
   
   print(mySum)
   ```

   

2. 1부터 100 사이의 3의 배수 구하기

   ```r
   for( var in seq(1,100) ) {
       if( var1 %% 3 == 0 ) {
           print(var1)
       }
   }
   ```

   

3. 1부터 100까지 소수(prime number)구하기

   ```r
   n <- 100
   i <- 2
   count <- 0
   
   for( var1 in seq(i,n) ) {
       div <- var1 %/% 2
       
       count<-0
       
       if( div > 1 ) {
           for ( idx in seq(2,div) ) {
               if( var1 %% idx == 0 ) {
                   count += 1
               }
           }
       }
       
       if( count == 0 ) {
           print(var1)
       }
   }
   ```

   #

#### 사용자 정의 함수( User Define Function )

---

- 함수 직점 만듦
- 함수명 <- `function(     x ) { … }`

 

1. 입력받은 숫자 제곱해서 돌려주는 함수

   ```r
   myFunc <- function( x ) {
       x <- x ^ 2
       return ( x )
   }
   
   var1 <- myFunc(5)
   ```

   

2.  sum()과 같은 기능하는 함수 만들기

   ```r
   mySum <- function( x ) {
       result <- 0
       for( y in seq(1,x) ) {
           result += y
       }
       return( result )
   }
   
   mySum(10)
   ```

   



 

 