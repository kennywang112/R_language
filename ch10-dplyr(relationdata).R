library(tidyverse)
library(nycflights13)
#尋找建值
planes%>%count(tailnum)%>%filter(n>1)
weather%>%count(year,month,day,hour,origin)%>%filter(n>1)
flights%>%count(year,month,day,flight)%>%filter(n>1)#不是唯一
#變動結合(mutating joins) 結合來自兩個資料表的變數
flights2<-flights%>%select(year:day,hour,origin,dest,tailnum,carrier)
flights2%>%select(-origin,-dest)%>%left_join(airlines,by='carrier')#結合airlines與flights2
flights2%>%select(-origin,-dest)%>%
  mutate(name=airlines$name[match(carrier,airlines$carrier)])#取子集得到相同結果
#內部結合(inner join) 一對觀察的鍵值相等時匹配
x<-tribble(~key,~val_x,
           1,'x1',
           2,'x2',
           3,'x3')
y<-tribble(~key,~val_y,
           1,'y1',
           2,'y2',
           3,'y3')
x%>%inner_join(y)#容易失去觀察,不適用分析工作
#外部結合(outer join) 1.left join(保留x觀察) 2.right join(保留y觀察) 3.full join(全保留)
#保留至少出現在其中一個資料表中的觀察
x<-tribble(~key,~val_x,
           1,'x1',
           2,'x2',
           2,'x3',
           1,'x4')
y<-tribble(~key,~val_y,
           1,'y1',
           2,'y2')
left_join(x,y,by='key')
#定義鍵值資料欄
flights2%>%left_join(weather)
flights2%>%left_join(planes,by='tailnum')#自然結合
flights2%>%left_join(airports,c('dest'='faa'))#by=c('a'='b')匹配x變數a與y變數b
#過濾集合(filter join) 和變動集合相同方式,但影響的是觀察而非變數
top_dest<-flights%>%count(dest,sort=TRUE)%>%head(10)
flights%>%filter(dest%in%top_dest$dest)
flights%>%semi_join(top_dest)#semi_join保留x在y中有匹配的觀察
flights%>%anti_join(planes,by='tailnum')%>%count(tailnum,sort = TRUE)