#######################################################################################

# 2018 10 30 박스오피스 순위를 알아내어
# 제목과 누적 관람객수를 csv 파일에 저장
# http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=90fb7e5ff0d186d0729dd3b97686200a&targetDt=20181030

box_url <- "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=90fb7e5ff0d186d0729dd3b97686200a&targetDt=20181030"

box_df <- fromJSON(box_url)

box_df <- box_df$boxOfficeResult$dailyBoxOfficeList
box_df

box_df_sub=subset(box_df, select=c("movieNm", "audiAcc"))
box_df_sub[1,2]

write.csv(box_df_sub,
          file = "C:/R_Lecture/data/boxOffice_json.csv",
          row.names = F,
          quote = T)

#######################################################################################

box_df[,c("movieNm","audiAcc")]

box_cind <- cbind(box_df$movieNm, box_df$audiAcc)
box_cind[1,2]

box_rbind<-vector()
for(idx in seq(1:nrow(box_cind))) { # nrow() => num row
  # df$title # vector 집합 => data frame
  # print(box_cind[idx, c(1:2)])
  box_rbind <- rbind(box_rbind, box_cind[idx, c(1:2)])
}
box_rbind

 write.csv(box_rbind,
          file = "C:/R_Lecture/data/boxOffice_json_for.csv",
          row.names = F,
          quote = T)
read.csv("C:/R_Lecture/data/boxOffice_json_for.csv")
#######################################################################################

# 1. 얻어온 데이터에서 필요한 내용만 추출하여
#         Data Frame을 새로 생성한 후 파일 출력

# 2. Data Frame에서 로직처리(for문)하여 데이터 추출해
#         text 파일에 append하여 파일 출력

for(idx in seq(1:nrow(box_df_sub))) {
  str_c(box_df_sub[idx, c(1:ncol(box_df_sub))],
        file="C:/R_Lecture/data/boxOffice_json_append.csv",
        "/n", append=T)
}

str_c(box_df_sub[idx, c(1:ncol(box_df_sub))])
