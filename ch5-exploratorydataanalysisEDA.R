library(ggplot2)
library(tidyverse)
ggplot(data=diamonds)+geom_bar(mapping=aes(x=cut)) #類別變數分布(長條圖)
diamonds%>%count(cut) #dplyr::count()手動計算
ggplot(data=diamonds)+geom_histogram(mapping=aes(x=carat),binwidth=0.5) #連續變數的分布(直方圖)
diamonds%>%count(cut_width(carat,0.5)) #結合dplyr::count()與ggplot2::cut_width()手動計算
smaller<-diamonds%>%filter(carat<3)
ggplot(data=smaller,mapping=aes(x=carat))+geom_histogram(binwidth=0.1)
ggplot(data=smaller,mapping=aes(x=carat,color=cut))+geom_freqpoly(binwidth=0.1)#線條圖更容易理解 freqpoly=次數多邊圖
ggplot(data=smaller,mapping=aes(x=carat))+geom_histogram(binwidth = 0.01)

#異常,離群值
ggplot(diamonds)+geom_histogram(mapping=aes(x=y),binwidth = 0.5)
ggplot(diamonds)+geom_histogram(mapping=aes(x=y),binwidth=0.5)+coord_cartesian(ylim=c(0,50))#將y軸拉近到較小值
unusual<-diamonds%>%filter(y<3|y>20)%>%arrange(y)

#缺失值
#兩個選擇繼續未完成資料
diamonds2<-diamonds%>%filter(between(y,3,20))#捨棄帶有異常值資料
diamonds2<-diamoned%>%mutate(y=ifelse(y<3|y>20,NA,y))#缺失值取代不尋常值
ggplot(data=diamonds2,mapping = aes(x=x,y=y))+geom_point()#geom_point(na.rm=TRUE)抑制警告
nycflights13::flights%>%
  mutate(cancelled=is.na(dep_time),
         sched_hour=sched_dep_time%/%100,
         sched_min=sched_dep_time%%100,
         sched_dep_time=sched_hour+sched_min/60)%>%
  ggplot(mapping=aes(sched_dep_time))+
  geom_freqpoly(mapping=aes(color=cancelled),
                binwidth=1/4)
ggplot(data = diamonds,mapping=aes(x=price))+geom_freqpoly(mapping=aes(color=cut),binwidth=500)