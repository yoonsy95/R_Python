# data : excel 파일(exec1105.xlsx)

# 만약 결측값이 존재하면 결측값은 결측값을 제외한 
# 해당 과목의 평균을 이용합니다.

# 만약 극단치가 존재하면 하위 극단치는 극단치값을 제외한
# 해당 과목의 1사분위 값을 이용하고 상위 극단치는
# 해당 과목의 3사분위 값을 이용합니다.

library(reshape2)
library(xlsx)
library(dplyr)

# read file
score<-read.xlsx(file="C:\\R_Lecture\\data\\연습문제(1105)\\exec1105.xlsx",
                 1, 
                 header=F)
name<-read.xlsx(file="C:\\R_Lecture\\data\\연습문제(1105)\\exec1105.xlsx",
                2,
                encoding="UTF-8",
                header=F)

# 컬럼명 정리
score <- rename(score, "id" = "X1")
names(name) <- c("id","name","gender")

# score dcast
score <- dcast(score,
               id ~ X2,
               value.var = "X3")

score
name

boxplot(score$kor,score$eng,score$math)
boxplot(score$kor,score$eng,score$math)$stats


########################################
# na 평균 대치
score$math<- ifelse(is.na(score$math),
                    mean(score$math, na.rm = T),      
                    score$math)

# 극단치
score$kor<-ifelse(score$kor<3, 7, score$kor)
score$eng<-ifelse(score$eng>95, 75, score$eng)
score$math<-ifelse(score$math>78.66667, 78.33333, score$math)

# join -> student
student <- left_join(name, score, by="id")
student


# 1. 전체 평균이 가장 높은 사람은 누구이며 평균값은 얼마인가요?
# 김연아 81.111111
stu1<-student %>% mutate(avg_score=(eng+kor+math)/3) %>%
            arrange(desc(avg_score)) %>% 
            select(name, avg_score)
head(stu1, 1)


# 2. 남자와 여자의 전체 평균은 각각 얼마인가요?
# 남자: 40.7 // 여자: 54.6
student %>% group_by(gender) %>%
            summarise(mean(c(eng,kor,math)))


# 3. 수학성적이 전체 수학 성적 평균보다 높은 남성은 누구이며
#    수학성적은 얼마인가요?
# 이순신: 68 // 강감찬: 78.66667
student %>% filter(gender=='남자',
                   math>=mean(math)) %>%
            select(name, math)





