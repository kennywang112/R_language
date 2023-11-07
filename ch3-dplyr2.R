by_dest<-group_by(flights,dest)
delay<-summarize(by_dest,count=n(),
                 dist=mean(distance,na.rm=TRUE), #mean=平均值
                 delay=mean(arr_delay,na.rm=TRUE))
delay<-filter(delay,count>20,dest!="HNL")

delays<-flights%>%
  group_by(dest)%>%
  summarize(count=n(),
            dist=mean(distance,na.rm=TRUE),
            delay=mean(arr_delay,na.rm=TRUE))%>% #進階,%>%等於then
  filter(count>20,dest!="HNL")
ggplot(data=delay,mapping=aes(x=dist,y=delay))+
  geom_point(aes(size=count),alpha=1/3)+
  geom_smooth(se=FALSE)
#哪個目的地有最多家航空公司
not_cancelled<-flights%>%filter(!is.na(dep_delay),!is.na(arr_delay))
not_cancelled%>%
  group_by(dest)%>%
  summarize(carriers=n_distinct(carrier))%>% #n_distinct計算唯一值的總數
  arrange(desc(carriers))
#n()不接受引數並回傳目前群組大小 sum(!is.na(x))計算非缺失值的總數
not_cancelled%>%count(tailnum,wt=distance)
#有多少航班在5am以前離境?這些通常事前一天延誤的航班
not_cancelled%>% 
  group_by(year,month,day)%>%
  summarize(n_early=sum(dep_time<500))
#有多少比例的航班誤點超過一個小時
not_cancelled%>%
  group_by(year,month,day)%>%
  summarize(hour_perc=mean(arr_delay>60))
daily<-group_by(flights,year,month,day)
daily%>%ungroup()%>%summarize(flights=n())