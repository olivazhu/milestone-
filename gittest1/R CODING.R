

Sys.setenv(JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.8.0_201.jdk/Contents/Home	')
install.packages("sentimentr")
install.packages("xlsx")

library(sentimentr)
#intall(sentimentr)
library(dplyr)
library('lubridate')
library('stringr')
library(ggplot2)
library('xlsx')
library(tidytext)

oritext <- read.csv("22_4_news.csv")
title <- oritext %>% select(stock.code, date, title)
title[title==""] <- NA
title <- na.omit(title)
title <- get_sentences(title)
sen_title <- sentiment(title)


sen_title %>% filter(stock.code==2488) %>% select(date,sentiment) %>% group_by(date) %>% summarise(mean(sentiment))

ar_sen_title <- sen_title %>% select(stock.code, date, title, sentiment) %>% filter(stock.code == 2488)
ar_sen_title$date <- dmy_hm(ar_sen_title$date)
ar_sen_title$date <- as_date(ar_sen_title$date)
ar_sen_title <- ar_sen_title %>% select(stock.code, date, title, sentiment) %>% filter(stock.code == 2488) %>% arrange((date))
ggplot(data=ar_sen_title, aes(x=date, y=sentiment)) +
  geom_point()




arx <- read.csv("ZHU TING.csv")
arx$Date <- ymd(arx$Date)
#arx$Close.Price <- as.numeric(levels(arx$Close.Price))


ggplot() + 
  geom_line(data=ar_sen_title, aes(x=date, y=sentiment), color ="red") + 
  geom_line(data=arx, aes(x=Date, y=Price), color = "blue")

