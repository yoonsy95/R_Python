# 데이터 정제

# 우리가 얻은 raw data는 항상 오류를 포함하고 있음
# 분석하기 전에 데이터 오류 수정하여야

#############################################################
#                       결측치(NA) 처리
#############################################################
# 1st 수행하여야
# 결측치는 누락된 값을 지칭, 비어있는 값을 지칭
# 결측치가 있으면 함수적용이 잘못된 구 싰으며
# 분석 자체가 잘못될 수 있음

# 결측치 찾아야 => is.na()

df <- data.frame(id = c(1,2,NA,4,5,NA,7),
                 score = c(20,30,90,NA,60,NA,99))
df
is.na(df)
sum(is.na(df))   # NA tot
table(is.na(df)) # 빈도를 이용하여 결측치 확인

# 결측치 제거 ##################
# => data frame이기에 결측치 들어가있는 행 삭제
df %>% filter(!is.na(id),
              !is.na(score))

na.omit(df)

# 행 지우면 신뢰성이 떨어질 수 있음
# 결측치만 문제지 결측치 포함한 행은 문제 없음
# 행을 지우면 결측치 뿐 아니라 정상 데이터도 같이 삭제되기에
# 분석시 문제 생길 수 있음

mean(df$score) # NA 연산 결과는 NA
mean(df$score, na.rm = T)

# 결측치가 포함된 행을 삭제하기에는 부담됨

# 평균으로 대치 #################
# score안에 있는 결측치 값을 다른 값으로 대치하여 평균 구하기
# score 열에 대해 NA를 제외한 펴육ㄴ을 구하여 그 값으로 score의 NA를 대체

df
df$score=ifelse(is.na(df$score),
                mean(df$score,na.rm = T),
                df$score)


# 결측치(NA) ##################################

# 이상치: 존재할 수 없는 값이 포함
#         성별: F, M 이외의 값

df <- data.frame(id = c(1,2,NA,4,5,NA,7),
                 score = c(20,30,90,NA,60,NA,99),
                 gender = c("M","F","M","F","M","F","00"),
                 stringsAsFactors = F)
df

# 이상치 -> 결측치로 변경
df$gender <- ifelse(!df$gender %in% c('M','F'),
                    NA,
                    df$gender)
df$gender



# 극단치: 정상적인 범주에서 너무 벗어난 값이 들어온 경우
#         weight: 35 || 5
#         머신러닝 경우 극단값 들어오면 결과가 달라짐

# 기준 정해야 함 // 기준 있음 ################

# 극단치 분류하는 기준은 IQR(Interqualtile Range)
data = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,25)

# 기본통계값으로 사분위 값 찾기
summary(data)

# IQR -> (3QR -1QR) * 1.5
lower_data <- c(1,2,3,4,5,6,7,8)
upper_data <- c(8,9,10,11,12,13,14,25)

median(upper_data)-median(lower_data)

# 상위 극단치: 3사분위 + 기준값
#                11.5  +   10.5
# 하위 극단치: 1사분위 - 기준값

######기준2###########
# 그래프를 이용하면 극단치 눈으로 확인
boxplot(data)
boxplot(data)$stats # 극단치 제외한 최대값 나옴












