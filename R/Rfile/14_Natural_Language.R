## 자연어 처리 기능 이용

# KoNLP => Korean Natural Language Process
# 해당 패키지 안에 3가지 사전이 포함되어 있음
# 1. 시스템 사전(280,)
# 2. 세종 사전(320,)
# 3. NIADic 사전(980,)

# 자바 기능 이용하므로 시스템에 JRE가 설치되어있어야 함
# JRE 설치하고 R package가 JRE 찾아서 사용할 수 있도로
# 환경변수(JAVA_HOME) 설정해야 함

# 영문 NLP package => openNLP, snowball
install.packages("KoNLP")
library(KoNLP)
library(stringr)
library(dplyr)

useNIADic() # 사전 불러옴, 저장

tmp="목이 길어 슬픈 기린"
tmp="이것은 소리 없는 아우성"
txt <- readLines("C:/R_Lecture/data/hiphop.txt",
                 encoding = "UTF-8")
head(txt)

# 특수문자 제거
# 정규표현식 이용해서 트수문자 모두 " "로 변환
txt <- str_replace_all(txt, 
                "\\W", # # 특수문자 // W -> 대문자여야 함!!!
                " ") # 붙이면 단어 앞뒤도 같이 붙음

nouns <- extractNoun(txt) # 형태소 출력
head(nouns)
mode(nouns) # 명사 추출해서 list 형태로 저장
length(nouns) # 4261

words<-unlist(nouns) # list -> vector
head(words)
length(words)

# 워드클라우드 만들기 위하여 많이 등장하는 명사만 추출출
wordcloud<-table(words) # table 구조
df<-as.data.frame(wordcloud, 
                  stringsAsFactors = F)
df
names(df)

# 빈도수 높은 상위 20개 단어 추출
# 한 글자는 의미 없으므로 제거
word_df <- df %>% 
  filter(nchar(words)>=2) %>%
  arrange(desc(Freq)) %>%
  head(20)
word_df


# wordcloud에 필요한 패키지
install.packages("wordcloud")
library(wordcloud)

# 워드 클라우드에서 사용할 색상에 대한 팔래트 설정
# Dark2라는 색상목록에서 8개의 색상 추출
pal <- brewer.pal(8,"RdBu")
pal

# 워드 클라우드는 만들때마다 랜덤하게 만들어짐
# 랜덤하게 생성되기에 재현성 확보 불가함
# 랜덤함수의 시드값을 고정시켜서 
# 항상 같은 워드 클라우드가 만들어지도록 설정
set.seed(1)

wordcloud(words=word_df$words,
          freq=word_df$Freq,
          
          min.freq=2, # 빈도 최소값
          max.words=20, # 최대 단어 수
          random.order=F, # 고빈도 단어를 중앙 배치
          
          rot.per=.3, # 글자 회전 비율 // 10%
          scale=c(4, .3), # 빈도 높으면 최대 4, 작으면 최소 .3
          colors=pal)




