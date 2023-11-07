by_dest<-group_by(flights,dest)
delay<-summarize(by_dest,count=n(),
                 dist=mean(distance,na.rm=TRUE), #mean=������
                 delay=mean(arr_delay,na.rm=TRUE))
delay<-filter(delay,count>20,dest!="HNL")

delays<-flights%>%
  group_by(dest)%>%
  summarize(count=n(),
            dist=mean(distance,na.rm=TRUE),
            delay=mean(arr_delay,na.rm=TRUE))%>% #�i��,%>%����then
  filter(count>20,dest!="HNL")
ggplot(data=delay,mapping=aes(x=dist,y=delay))+
  geom_point(aes(size=count),alpha=1/3)+
  geom_smooth(se=FALSE)
#���ӥت��a���̦h�a��Ť��q
not_cancelled<-flights%>%filter(!is.na(dep_delay),!is.na(arr_delay))
not_cancelled%>%
  group_by(dest)%>%
  summarize(carriers=n_distinct(carrier))%>% #n_distinct�p��ߤ@�Ȫ��`��
  arrange(desc(carriers))
#n()�������޼ƨæ^�ǥثe�s�դj�p sum(!is.na(x))�p��D�ʥ��Ȫ��`��
not_cancelled%>%count(tailnum,wt=distance)
#���h�֯�Z�b5am�H�e����?�o�ǳq�`�ƫe�@�ѩ��~����Z
not_cancelled%>% 
  group_by(year,month,day)%>%
  summarize(n_early=sum(dep_time<500))
#���h�֤�Ҫ���Z�~�I�W�L�@�Ӥp��
not_cancelled%>%
  group_by(year,month,day)%>%
  summarize(hour_perc=mean(arr_delay>60))
daily<-group_by(flights,year,month,day)
daily%>%ungroup()%>%summarize(flights=n())