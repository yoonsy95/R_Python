# R Graph
# 숫자나 문자로 표현하는 것보다는
# 그림(그래프)으로 표현하면 
# 변수의 관계나 데이터 경향을 좀 더 쉽게 파악할 수 있음

# 해들리 위컴이 만듦
# reshape2 package // melt, dcast
# dplyr package    // filter, groupby, join
# ggplot2 package  // R에서 가장 많이 사용됨

library(reshape2)
library(dplyr)
library(ggplot2)

# ggplot2는 3단계로 그래프를 그림
# 1. 축을 정함(x축, y축) => 배경 설정
# 2. 그래프 추가
# 3. 축 범위, 배경 설정: 설정추가

df <- as.data.frame(mpg) # table data -> dataFrame
df

# data설정: 그래프 그리는데 필요한 데이터
# aes(x= , y=) # python => axes()

# 데이터 체이닝은 %>%
# 그래프는 +



################################################
# 1. 산점도: geom_point()
################################################
# 변수간 관계 파악, 전체 데이터의 경향 파악

# 배기량(displ)에 따른 고속도로 연비

# 1. 원하는 그래프 그리기 위하여 배경설정함
ggplot(data=df,
       aes(x=displ,
           y=hwy))

# 2. 데이터 추가
ggplot(data=df,
       aes(x=displ,
           y=hwy))
+ geom_point()

# 3. 설정 추가
ggplot(data=df,
       aes(x=displ,
           y=hwy))+
  geom_point(size=3, color="red")+
  xlim(3,5) +     # x축 범위 설정
  ylim(20,30)     # y축 범위 설정

plot.new() # 그래프창 clear

################################################
# 2. 막대그래프: geom_bar() / geom_histogram / geom_col()
################################################
# 1. geom_bar: 집단간 빈도 비교 그래프
# 구동방식별 빈도수
# 얘는 순서 어떻게 바꿈??!!!
ggplot(data=df,
       aes(x=drv))+
  geom_bar()

# 구동방식별 기통수???? cyl
# 누적 밀도(빈도) 그래프
ggplot(data=df,
       aes(x=drv))+
  geom_bar(aes(fill=factor(class))) 
# cyl, trans, class

# 한 빈도 세분화하려면
# geom_bar(aes=(fill=factor(cyl)),position="dodge")

#################
# 2. geom_histogram: 히스토그램
# 구간별이므로 범주형 데이터가 아닌 연속형 데이터여야
# default 구간: 30개
ggplot(data=df,
       aes(x=hwy)) + 
  geom_histogram()

################

# 3. geom_col: 데이터 값 출력하는 막대 그래프
#           raw data frame을 직접 이용해서 처리

# 구동방식(drv): f(전륜), r(후륜), 4(4륜)
# 구동방식별 고속도로 연비비교
# 막대 그래프를 그리기 위해 데이터 준비 // 카테고리별로
#   구동방식별 고속도로 연비 차이(평균) 구해야
result <- 
  df %>%
  group_by(drv) %>%
  summarise(avg_hwy=mean(hwy))

ggplot(data=result,
       aes(x=drv,
           y=avg_hwy))+
  geom_col()


# 막대그래프에 대해서 순서 다시 배치할 경우
# default: 컬럼 순서 따라서 오름차순 정렬
# 데이터 값 따라서 순서 재배치
ggplot(data=result,
       aes(x=reorder(drv, -avg_hwy), # desc()보다 - 많이 사용함
           y=avg_hwy))+
  geom_col()

################################################
# 3. 선그래프: geom_line()
################################################
# 시계열 데이터 표현
# 일반적으로 환율, 주식, 경제동향

# economics DataSet 이용
# pce: 개인소비지출, 십억단위
# pop: 전체 인구수, 천단위
# psavert: 월별 개인 저축비율
# uempmed: 주별 실업률
# unemploy: 실업자수, 천단위


# 시간에 따른 실업자수
ggplot(data=economics,
       aes(x=date,
           y=unemploy)) + 
  geom_line()

# 한 그래프에 여러 그래프 표현
ggplot(data=economics,
       aes(x=date,
           y=unemploy)) +
  geom_point(color="red")+ 
  geom_line()



################################################
# 4. 박스그래프: geom_boxplot()
################################################
# 데이터 분포 파악
# 구동방식별 고속도로연비
ggplot(data=df,
       aes(x=drv,
           y=hwy)) + 
  geom_boxplot()


##################################################################
# 4 종류의 그래프 그려봤음
# 추가적인 객체 포함해서 그래프를 좀 더 이해하기 쉬운 형태로 만들기

# mpg: 자동차 연비에 대한 data set
# economics: 월별 경제 지표에 대한 data set

# 날짜별 개인저축률에 대한 선그래프
# 일반적인 직선 그림 -> 후에 회귀추정식 그려야

########저축률 가장 작은 날짜에 수직선 그리기 위한 날짜 추출
tmp <- economics %>%
  filter(psavert ==min(psavert)) %>%
  select(date)
tmp <- as.data.frame(tmp)
result <- tmp$date
result

######

ggplot(data=economics,
       aes(x=date,
           y=psavert)) + 
  geom_line() + 
  geom_abline(intercept = 12.1, 
              slope = -.0003444,
              color="blue") +# intercept=>절편, slope=>기울기
  geom_vline(xintercept = result, color="green") + # 수직선
  geom_hline(yintercept = mean(economics$psavert), color="red") # 수평선

# 수직선에 날짜 직접 입력할 때
# geom_vline(xintercept = economics$date=='2005-07-01', color="green") + # 수직선
# 날짜가 아닌 문자열이기에 인식하지 못함
# data type 변환하여야 => as.Date('2005-05-01')


################################################
## 그래프 안에 텍스트 표현?: geom_text()
################################################
ggplot(data = economics,
       aes(x=date,
           y=psavert)) + 
  geom_point() + 
  xlim(as.Date("1990-01-01"),
       as.Date("1992-12-01")) + 
  ylim(7,10) + 
  geom_text(aes(label=psavert,
                vjust=-.3, # 수직 글자위치  - => 위
                hjust=-.3)) # 수평 글자위치 - => 우측


################################################
# 특정 영역 highlighting(강조) 하기 위하여 사용
################################################

ggplot(data = economics,
       aes(x=date,
           y=psavert)) + 
  geom_point() + 
  annotate("rect", # rectangle
           xmin = as.Date("1991-01-01"),
           xmax = as.Date("2005-01-01"),
           ymin=5,
           ymax=10,
           alpha=.3, # 투명도
           fill="red")


################################################
# 화살표 추가
################################################
ggplot(data = economics,
       aes(x=date,
           y=psavert)) + 
  geom_point() + 
  annotate("rect",
           xmin = as.Date("1991-01-01"),
           xmax = as.Date("2005-01-01"),
           ymin=5,
           ymax=10,
           alpha=.3,
           fill="red") + 
  annotate("segment",
           x=as.Date("1985-01-01"),
           xend = as.Date("1995-01-01"),
           y=5.5,
           yend = 6,
           arrow=arrow(),
           color="blue")


################################################
# add text
################################################
ggplot(data = economics,
       aes(x=date,
           y=psavert)) + 
  geom_point() + 
  annotate("rect",
           xmin = as.Date("1991-01-01"),
           xmax = as.Date("2005-01-01"),
           ymin=5,
           ymax=10,
           alpha=.3,
           fill="red") + 
  annotate("segment",
           x=as.Date("1985-01-01"),
           xend = as.Date("1995-01-01"),
           y=5.5,
           yend = 6,
           arrow=arrow(),
           color="blue") + 
  annotate("text",
           x=as.Date("1985-01-01"),
           y=15,
           label="집집집집집",
           color="violet")

################################################
# 축 이름 변경
################################################

ggplot(data = economics,
       aes(x=date,
           y=psavert)) + 
  geom_point() + 
  annotate("rect",
           xmin = as.Date("1991-01-01"),
           xmax = as.Date("2005-01-01"),
           ymin=5,
           ymax=10,
           alpha=.3,
           fill="red") + 
  annotate("segment",
           x=as.Date("1985-01-01"),
           xend = as.Date("1995-01-01"),
           y=5.5,
           yend = 6,
           arrow=arrow(),
           color="blue") + 
  annotate("text",
           x=as.Date("1985-01-01"),
           y=15,
           label="집집집집집",
           color="violet") + 
  labs(x="연도",
       y="개인별 저축률",
       title="연도별 개인저축률 추이")

################################################
# 테마
################################################

ggplot(data = economics,
       aes(x=date,
           y=psavert)) + 
  geom_point() + 
  annotate("rect",
           xmin = as.Date("1991-01-01"),
           xmax = as.Date("2005-01-01"),
           ymin=5,
           ymax=10,
           alpha=.3,
           fill="red") + 
  annotate("segment",
           x=as.Date("1985-01-01"),
           xend = as.Date("1995-01-01"),
           y=5.5,
           yend = 6,
           arrow=arrow(),
           color="blue") + 
  annotate("text",
           x=as.Date("1985-01-01"),
           y=15,
           label="집집집집집",
           color="violet") + 
  labs(x="연도",
       y="개인별 저축률",
       title="연도별 개인저축률 추이") + 
  theme_classic()






