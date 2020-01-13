# 네이버 영화 댓글 사이트
# 특정 영화에 대한 리뷰 크롤링해서
# 워드클라우드 작성

library(jsonlite)
library(httr)
library(rvest)
library(wordcloud)
library(stringr)
library(wordcloud)

# 함수 호출하여 크롤링
result_df = data.frame();

extract_commant <- function(idx) {
  url <- "http://movie.naver.com/movie/point/af/list.nhn"
  
  st <- "st="
  sword <- "sword="
  target <- "target="
  page <- "page="
  
  request_url <- str_c(url, "?", st, "mcode","&",
                       sword, "167613","&", target, "after", "&", page, idx)

  html_page = read_html(request_url,
                        encoding = "CP949") # cp949: 옛날 사용한 한글 인코딩
  nodes = html_nodes(html_page, "td.title > a.movie")
  title <- html_text(nodes, trim = T)
  
  review = vector(mode = "character", length = 10)
  for(idx in 1:10) {
    myPath = str_c('//*[@id="old_content"]/table/tbody/tr[', 
                   idx,
                   ']/td[2]/text()')
    nodes = html_nodes(html_page,
                       xpath = myPath)
    txt<-html_text(nodes,trim=T)
    review[idx]=txt[3]
  }
  df=cbind(title, review)
  return(df)
}

for(i in 1:100) {
  tmp <- extract_commant(i)
  result_df = rbind(result_df, tmp)
}

View(result_df)

review<-result_df$review
review <- str_replace_all(review, 
                       "\\W", # # 특수문자 // W -> 대문자여야 함!!!
                       " ")
head(review)

# list
noun_review<-extractNoun(review)
head(noun_review)

# list -> vector
words_review<-unlist(noun_review)
head(words_review)
mode(words_review)

# 빈도수 만들어서 조작 쉽게 데이터프레임으로 변형
wordcloud<-table(words_review)
df<-as.data.frame(wordcloud, 
                  stringsAsFactors = F)
head(df)

# 두 글자 이상, 빈도수 내림차순
word_df <- df %>% 
  filter(nchar(words_review)>=2) %>%
  arrange(desc(Freq)) %>%
  head(40)
word_df

# 색상 저장
pal <- brewer.pal(8,"Dark2")

# 시드 고정
set.seed(1)

wordcloud(words=word_df$words_review,
          freq=word_df$Freq,
          
          min.freq=2, # 빈도 최소값
          max.words=40, # 최대 단어 수
          random.order=F, # 고빈도 단어를 중앙 배치
          
          rot.per=.3, # 글자 회전 비율 // 10%
          scale=c(8, .3), # 빈도 높으면 최대 4, 작으면 최소 .3
          colors=pal)

