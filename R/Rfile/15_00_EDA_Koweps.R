# EDA(Exploratory Data Analysis)
#   => 탐색적 데이터 분석

# 사용 데이터: 한국복지패널 데이터

# 한국보건사회연구원 => 2006년부터 10년간
# 7000여 가구에 대한 경제활동 생활실태 복지욕구 등

install.packages("foreign")
library(foreign) # spss 사용할거
library(stringr)
library(xlsx)
library(ggplot2)
library(dplyr)



raw_data_file <- "C:\\R_Lecture\\data\\한국복지패널데이터\\Koweps_hpc10_2015_beta1.sav"
raw_welfare <- read.spss(raw_data_file,
                         to.data.frame = T)
# 원본 보존
welfare <- raw_welfare
str(welfare)

# 컬럼명 변경
welfare <- rename(welfare,
                  gender=h10_g3,     # 성별
                  birth=h10_g4,      # 출생년도
                  marriage=h10_g10,  # 혼인상태
                  religion=h10_g11,  # 종교
                  code_job=h10_eco9, # 직종코드 // 조인위하여 컬럼명 같게 설정
                  income=p1002_8aq1, # 평균월급 // 일 X, 자영업 제외
                  region=h10_reg7)   # 지역코드

############ 1. 성별 따른 월급 차이
# 값 알기 쉽게 바꿔
welfare$gender <- ifelse(welfare$gender==1, 'M', "F")

table(welfare$gender) # 성별 이상치 확인

class(welfare$gender) # 자료구조
                      # 벡터는 데이터타입으로 나옴 => "character"
summary(welfare$income)  # 기본통계량 확인 // 왜도: +
qplot(welfare$income) + xlim(0,1000) # 확인용도


# 이상치 -> NA
welfare$income<-ifelse(welfare$income %in% c(0, 9999),
                       NA, welfare$income)
# NA 빈도 확인
table(is.na(welfare$income))

# 결과 저장1 => 되도록 사용하지 말 것
# 성별은 남여 두개의 카테고리며 결측치가 없어 통계갑 나옴
# 하지만 나이로 묶을 경우 값이 없으면 계산이 되지 아니함 => NaN 나옴
gender_income <- welfare %>%
  group_by(gender) %>%
  summarise("avg_income"=mean(income, na.rm = T))

# 결과 저장2
gender_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(gender) %>%
  summarise("avg_income"=mean(income))

# gender_income 구조 변환: tbl_df -> df
#   평균 소수점까지 나옴
gender_income <- as.data.frame(gender_income)
gender_income

# 결과 데이터 프레임으로 그래프 그리기
ggplot(data=gender_income,
       aes(x=gender, y=avg_income)) +
  geom_col(width = .5) + 
  labs(x="성별", 
       y="평균월급",
       title="성별에 따른 월급",
       subtitle="남성이 여성보다 150만 많이 벌음",
       caption="Example 1 Fig")


############ 2. 나이와 월급의 관계파악
# 언제 월급 가장 많이 받음??    # 53   318.6777
# 나이에 따른 월급을 선그래프로 출력

class(welfare$birth) # numeric
summary(welfare$birth) # 습관들이도록
qplot(welfare$birth) # 빈도그래프

### 전처리
# 이상치와 결측치 확인
table(welfare$birth)

# 이상치
welfare$birth = ifelse(welfare$birth == 9999,
                       NA, welfare$birth)
# 결측치
table(is.na(welfare$birth))


# 나이 컬럼 만들기
# welfare$age <- 2015 - welfare$birth + 1
welfare <- welfare %>%
  mutate(age = 2015-birth + 1)

# 나이 분포 확인
summary(welfare$age)
qplot(welfare$age)

### 나이별 평균 월급
age_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age) %>%
  summarise("age_income" = mean(income))

age_income <- as.data.frame(age_income)


### 월급 최대값 추출1
tmp <- age_income %>%
  filter(age_income ==max(age_income)) %>%
  select(age)
# 데이터프레임을 벡터로 바꾸어 주어야 함
# 그 값만 추출!!!
result <- tmp$age
class(result)

### 월급 최대값 추출2
age_income %>% arrange(desc(age_income)) %>%
  select(age) %>% head(1)

### 그래프
ggplot(data=age_income,
       aes(x=age, y=age_income)) + 
  geom_line() + 
  labs(x="나이",
       y="평균월급",
       title="나이에 따른 평균 월급") + 
  geom_vline(xintercept = result)


############ 3. 연령대에 따른 월급 차이
# ~ 29: 초년(young)
# ~ 59: 중년(middel)
# 60 ~: 노년(old)

# 위의 범주로 연령대에 따른 월급 차이
# 연령대1
welfare$age_range<-ifelse(welfare$age<30, 
                          "young", 
                          ifelse(welfare$age<60,
                                 "middle", "old"))
table(is.na(welfare$marriage))
# 연령대2
welfare<- welfare %>%
  mutate(age_range = ifelse(welfare$age<30, 
                            "young", 
                            ifelse(welfare$age<60,
                                   "middle", "old")))
# 연령대 결과 확인
table(welfare$age_range)

# 연령대별 평균 월급 구하기
age_range_income <- welfare %>% 
  filter(!is.na(income)) %>%
  group_by(age_range)%>%
  summarise("avg_income"=mean(income))
  
age_range_income <- as.data.frame(age_range_income)


# 연령대별 평균 월급 그래프 그리기
ggplot(data=age_range_income,
       aes(x=age_range, y=avg_income)) + 
  geom_col(width=.65)
 
# ggplot은 막대 그래프 그릴 시
# 기본적으로 x축 데이터에 대하여
# 알파벳 오름차순으로 정렬하여 출력

# 막대그래프 크기로 순서를 바꾸려면 
ggplot(data=age_range_income,
       aes(x=reorder(age_range, -avg_income),
           y=avg_income)) + 
  geom_col(width=.65)

.# 막대그래프의 순서를 원하는 순서로 바꾸려면?
ggplot(data=age_range_income,
       aes(x=reorder(age_range, -avg_income),
           y=avg_income)) + 
  geom_col(width=.65) + 
  scale_x_discrete(limits=c("young","middle","old"))


############ 4. 연령대 및 성별의 월급 차이
arange_gender_income <- welfare %>% 
  filter(!is.na(income)) %>%
  group_by(age_range, gender) %>%
  summarise("avg_income" = mean(income))

arange_gender_income <- as.data.frame(arange_gender_income)
arange_gender_income

### 그래프1
ggplot(arange_gender_income) + 
  geom_col(mapping=aes(x=age_range, 
                       y=avg_income, 
                       fill=gender),
           position = "dodge") + 
  scale_x_discrete(limits=c("young","middle","old"))

### 그래프2
ggplot(arange_gender_income,
       aes(x=age_range,
           y=avg_income,
           fill=gender)) +
  geom_col(position = "dodge") + 
  scale_x_discrete(limits=c("young","middle","old"))



############ 5. 나이 및 성별에 따른 월급 차이 분석
arange_gender_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age, gender) %>%
  summarise("avg_income" = mean(income))

arange_gender_income <- as.data.frame(arange_gender_income)

# 그래프1
ggplot(arange_gender_income,
       aes(x=age,
           y=avg_income,
           fill=gender))+
  geom_col(position = "dodge")

# 그래프2
ggplot(arange_gender_income,
       aes(x=age,
           y=avg_income,
           col=gender))+ # col: color
  geom_line(size=1)


############ 6. 직업별 월급 차이 분석
# 가장 월급 많이 받는 직업과 작게 받는 직업
job_raw_data_file <- read.xlsx("C:\\R_Lecture\\data\\한국복지패널데이터\\Koweps_Codebook.xlsx", encoding="UTF-8", sheetIndex=2)
head(job_raw_data_file)

job<-job_raw_data_file

job_join <- left_join(welfare, job, by="code_job")

job_join_income <- job_join %>% 
  filter(!is.na(income)) %>%
  group_by(job) %>%
  summarise("avg_income"=mean(income)) %>%
  arrange(desc(avg_income))

job_join_income <- as.data.frame(job_join_income)
job_join_income

ggplot(job_head,
       aes(x=reorder(job, -avg_income),
           y=avg_income))+
  geom_col()


# 상하위 한 그래프
job_head<-head(job_join_income,5)
job_tail<-tail(job_join_income,5)
job_rbind<-rbind(job_head,job_tail)
job_rbind

ggplot(job_rbind,
       aes(x=reorder(job, avg_income),
           y=avg_income,
           fill=avg_income))+
  geom_col() + 
  coord_flip()  # 축바꾸기


############ 7. 종교 유무에 따른 이혼률
# 종교 있는 사람의 이혼율과 없는 사람의 이혼율 비교
# 결혼 marriage
# 종교유무 religion

welfare$marry <- ifelse(welfare$marriage %in% c(1,2,4),
                        0, ifelse(welfare$marriage == 3,
                                  1, NA))
divrate <- welfare %>%
  filter(!is.na(marry)) %>%
  group_by(religion, marry) %>%
  summarise("div_cnt"=n())

divrate <- as.data.frame(divrate)
divrate
divrate[2,3]/(divrate[1,3]+divrate[2,3])
divrate[4,3]/(divrate[3,3]+divrate[4,3])

##########강사님ㅇㅇ
# 이혼여부 나타내는 컬럼: group_marriage
# 1,2,4이면 group_marriage -> marriage
# 3이면 group_marrige -> divorce

# religion    group_marriage      n       total_n     pct
#   yes           marriage      5536        5864
#   yes           divorce        328        5864
#   no            marriage      5096        5480
#   no            divorce        384        5480

# 1. group_marriage 컬럼 만듦
welfare <- welfare %>% 
  mutate(group_marriage = ifelse(marriage %in% c(1,2,4), 
                                 "marriage",
                                 ifelse(marriage==3,
                                        "divorce", NA)))
table(welfare$group_marriage)

religion_divorce <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  group_by(religion, group_marriage) %>%
  summarise(n=n()) %>%
  mutate(total_n=sum(n)) %>% # religion 기준으로 sum
  mutate(pct = round((n/total_n)*100,1))

religion_divorce <- as.data.frame(religion_divorce)
religion_divorce














