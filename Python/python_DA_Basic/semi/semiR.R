library(dplyr)
library(stringr)

indc1618_1 <- read.csv('C:\\python_DA\\semi\\result\\indc1618_1.csv')
indc1618_2 <- read.csv('C:\\python_DA\\semi\\result\\indc1618_2.csv')
summary(indc1618_1)
summary(indc1618_2)


in1618<-read.csv('C:\\Users\\student\\Desktop\\aaaa.csv')
dc1618<-read.csv('C:/python_DA/semi/semiprj/기상으로인한사유별지연및결항.csv')

head(in1618)
head(dc1618)

dc1618 <- sapply(dc1618, str_replace_all,' - ','0')
# dc1618 <- as.numeric(dc1618[,2:20])
head(dc1618,1)

sapply(dc1618, as.numeric(dc1618[,2:20]))

as.data.frame(as.numeric(dc1618[, c(2:20)]))
as.numeric(dc1618[,2:20])



str(dc1618)
