#######################################################################################

# 반복해서 페이지를 browsing하는 crawling까지 포함

# myFunc <- function(idx) {
#   print(idx)
# }

# for(i in 1:10) {
#   myFunc(i)
# }

extract_commant <- function(idx) {
  url <- "http://movie.naver.com/movie/point/af/list.nhn"
  page <- "page="
  request_url <- str_c(url, "?", page, idx)
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

# 함수 호출하여 크롤링
result_df = data.frame();

for(i in 1:10) {
  tmp <- extract_commant(i)
  result_df = rbind(result_df, tmp)
}

View(result_df)