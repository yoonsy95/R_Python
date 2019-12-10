같은 데이터 타입을 저장하는 자료구조

Vector(1차원), Matrix(2차원), Array(3차원 이상)

다른 언어에서는 array 1차 2차 3차 상관 없이 array라고 함

 #

- 다른 데이터 타입을 저장하는 자료구조

List(1차원), Data Frame(2차원)

 #

- 범주형자료구조: Factor



### 1. Factor

---

- 범주형 데이터 저장하기 위한 자료구조

- "대",     "중", "소" => Level

- 일반적으로 벡터를 이용하여 만듦

- factor 함수를 활용하면 factor형 자료구조로 받아 볼 수 있음

  ``` R
var1 = c("A", "AB", "O", "A", "B", "B")
  factor_var1 <- factor(var1)
  ```

 #

- factor를 인자로 주고 **level****의** **개수**가 몇 개 있는지 알려줌

  ```r
  nlevels(factor_var1)
  ```

- 정해져있는 level이 있는지 알려줌 => **factor Data**

  ```r
  levels(factor_var1)
  ```

- **자료구조**가 factor인지 아닌지

  ```r
  is.factor(factor_var1)
  ```

 #

- factor는 **빈도**를 구하는데 많이 쓰인다

  ```r
var1 = c("M", "F", "M", "M", "M", "F")
  
factor_gender = factor(var1)
  table(factor_gender)
plot(factor_gender)
  ```

 #

#### 2. List

---

- 1차원 선형구조, 다른 데이터 타입이 들어올 수 있음

- 중첩 자료구조로 이용

- List 안의 각각의 요소 안에 다른 데이터 타입 넣을 수 있음

- **중첩자료구조** => 여러 자료구조들을 List 안에 저장 할 수 있음

- 1. Scalar

  2. Vector

  3. Matrix

  4. Array

     - 3차원 이상의 배열

     - dim() 알려주어야 몇 차원인지 앎

- 5. Dataframe

     ```r
     var_df = data.frame(id = 1:4,
                         name = ("홍", "김", "이", "최"),
                         age = c(30, 40, 20, 10)
                         
     myList = list(var_scalar,
                   var_vector,
                   var_matrix,
                   var_array,
                   var_df)
                         
     myList
     myList[1]
     ```



- key와 value로 저장되는 자료구조

- 데이터를 출력할 때 key 값도 같이 출력됨

- 일반적으로 map, dictionary라고 표현

- 키 값이 없는 경우 바로 첫 번째 방을 보여주기에 키 값이 보이지 않음

- 공간으로 접근하면 key, value가 나옴

  ```r
  var1[[1]]
  
  [1] 100
  ```

- key를 access 하면 바로 value에 접근가능 

  ```r
  myList[[1]]
  
  [1] 100
  ```

- List는 키 값을 정해서 데이터 입력 가능함

- key와 value를 짝지어서 데이터 입력

  ```r
  myList = list(name = c("홍길동", "김길동"),
                age = c(20, 30),
                address = c("서울", "부산")
  ```

  #

| `myList`      | [ ] 대신 키 값( $ )이 나옴                                   |
| ------------- | ------------------------------------------------------------ |
| `myList[1]`   | 첫 번째 방에 있는 key와 value가 같이 나옴                    |
| `myList$name` | 해당 키 값으로 해당되는 데이터에 접근함 List에서 key를 사용할 경우 $ 기호 이용함    `myList$name[2]` |
| `myList[[1]]` | 사용 가능한 형태이지만      일반적으로 key 값이 있으면 key 값을 이용함 |

 #

| `myList[]`     | 공간을 지칭함            |
| -------------- | ------------------------ |
| `myList[[  ]]` | key 값을 지칭함          |
| `myList$name`  | 일반적으로 사용하는 형태 |

 #

#### 3. Data Frame

---

- marrix와 같은 2차원 형태의 자료구조

- matrix와 차이점: 다른 타입의 데이터 들어갈 수 있음

   matrix가 좀 더 빠름

- column 명을 이용할 수 있다

- column명은 해당 column명의 벡터를 지징함

- 변수명은 예약된 키워드(int, double, for, if)로 작성하는 것은 좋지 않음

- DataBase의 Table과 유사하다

```r
no = c(1, 2, 3)
name = c("홍", "김", "최")
age = c(10, 20, 30)

df = data.frame(s_no = no,
                s_name = name,
                s_age = age)

myMatrix = matrix(c(1 : 12),
                  ncol = 3,
                  nrow = 4,
                  byrow = T)
```

 #

- matrix를 dataframe으로 전환 가능

  ```r
  df_mat = data.frame(myMatrix)
  ```

- 컬럼명을 줄 수는 없으나 변형시킬 수는 있음

 #

| df[1]     | 첫 번째 열을 지칭함                                  |
| --------- | ---------------------------------------------------- |
| df$s_name | data frame안에 있는 s_name이라는 컬럼을 알고 싶을 때 |

 #

- [1] 홍 김 최

- Levels: 김 최 홍

  => 범주형으로 잡힘

  범주형으로 잡히지 않도록 하려면 

  **`stringAsFactors = F`** 속성 추가

 #

- $  

| List       | key    |
| ---------- | ------ |
| Data Frame | column |

 #

- 전반적인 내용을 보여줌: **str()**

| 3 obs       | 3개의 관측치, 3개의 행  |
| ----------- | ----------------------- |
| 3 variables | 3개의 변수, 3개의 열    |
| s_no num …  | 각각의 컬럼 데이터 타입 |

 #

- 요약 통계 보여줌: **`summary()`**

 #

- **`apply()`**

- - 2차원으로 많이 씀
  
  - 연습문제

    ```r
  df = data.frame( x = c( 1 : 5 ),
                    y = c( 2, 10, 2 ),
                  z = c( "A", "B", "C", "D", "E" ),
                   	 	# datatype default => factor
                    stringAsFactor = F)        # df -> not factor
    ```

 #

1. 1, 2 번째 열에 대해 각각 합계를 구해

   ```r
sum( df[1] )
   sum( df[2] )
apply( x = df[1], MARGIN = 2, FUN = sum ) 
   apply( x = df[2], MARGIN = 2, FUN = sum )
apply( x = df[1:2], MARGIN = 2, FUN = sum )
   
apply( x = df[ , c(1:2) ], MARGIN = 2, FUN = sum )
   ```

 #

- 하나의 데이터프레임에서 조건에 맞는 행을 추출해서 

독립적인 데이터프레임 형성: **`subset()`**

| `subset(df,x>3)`                   | x  변수 값이 3이 넘어가는 것을 추출                          |
| ---------------------------------- | ------------------------------------------------------------ |
| `df_sub  <- subset(df, x<3, y>=4)` | x  변수 값이 3보다 작고    y 변수 값이 5보다 큰 데이터를 추출   일반적으로 변수에 저장을 해두도록 |

 