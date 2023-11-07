library(ggplot2)
library(nycflights13)
library(tidyverse)
library(dplyr)
nycflights13::flights
#dbl雙精度浮點數 lgl邏輯向量(只含true,false) fctr因子固定幾個可能值表示類別變數
x<-filter(flights,month==1,day==1)
#filter篩選
df<-tibble(x=c(1,NA,3))
filter(df,x>1)
arrange(flights,year,month,day)
select(flights,year:day) #year到day的資料欄 -(year:day)以外
#starts_with("") ends_with("") contains("") match("(.)\\1") num_range("x",1:3)=>x1,x2,x3
rename(flights,tail_num=tailnum)
select(flights,time_hour,air_time,everything())#挑選資料欄
flights_sml<-select(flights,year:day,ends_with("delay"),distance,air_time)
mutate(flights_sml,gain=arr_delay-dep_delay,speed=distance/air_time*60)#新增變數
transmute(flights,gain=arr_delay,hours=air_time/60,gain_per_hour=gain/hours)#只保留新變數
(x<-1:10)
lag(x)#滯後值
lead(x) #領先值
cumsum(x)#累積
cummean(x)#累積平均值
y<-c(1,2,2,NA,3,4)
min_rank(y)
min_rank(desc(y)) #row_number(y) dense_rank(y) percent_rank(y) cume_disk(y)
summarize(by_day,delay=mean(dep_delay,na.rm=TRUE))#將資料匡濃縮摘要為單一資料列 通常與group_by()搭配
by_day<-group_by(flights,year,month,day)