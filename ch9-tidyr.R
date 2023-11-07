#tidyr,ggplot2,dplyr是tidyverse的成員之一
#含變數名稱資料欄(key)在此為type 含多個變數的值(value)在此為count
library(ggplot2)
library(tidyverse)
#分散 聚集
ggplot(table1,aes(year,cases))+geom_line(aes(group=country),color='grey50')+geom_point(aes(color=country))
table4a%>%gather('1999','2000',key='year',value='cases')
table4a%>%gather('1999','2000',key='year',value='population')
spread(table2,key=type,value=count)
#處理資料欄含有兩個變數(table3)
table3%>%separate(rate,into=c('cases','population'),convert = TRUE)#要求separate試著轉換更適當的型別
table3%>%separate(year,into=c('century','year'),sep=2)
table5%>%unite(new,century,year)
table5%>%unite(new,century,year,sep='')#去掉分隔符號
#處理缺失值(明確(NA),隱含)
stocks<-tibble(year=c(2015,2015,2015,2015,2016,2016,2016),
               qtr=c(1,2,3,4,2,3,4),
               return=c(1.88,0.59,0.35,NA,0.92,0.17,2.66))
stocks%>%spread(year,return)%>%gather(year,return,'2015':'2016',na.rm=TRUE)#明確缺失值變隱含
stocks%>%complete(year,qtr)#使缺失值變得明確
treatment<-tribble(~person,           ~treatment,~response,
                   'derrick whitmpre',1,        7,
                   NA,                2,        10,
                   NA,                3,        9,
                   'katherine burke', 1,        4)
treatment%>%fill(person)#填補缺失值