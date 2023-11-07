library(ggplot2)
library(tidyverse)
ggplot(data=diamonds)+geom_bar(mapping=aes(x=cut)) #���O�ܼƤ���(������)
diamonds%>%count(cut) #dplyr::count()��ʭp��
ggplot(data=diamonds)+geom_histogram(mapping=aes(x=carat),binwidth=0.5) #�s���ܼƪ�����(�����)
diamonds%>%count(cut_width(carat,0.5)) #���Xdplyr::count()�Pggplot2::cut_width()��ʭp��
smaller<-diamonds%>%filter(carat<3)
ggplot(data=smaller,mapping=aes(x=carat))+geom_histogram(binwidth=0.1)
ggplot(data=smaller,mapping=aes(x=carat,color=cut))+geom_freqpoly(binwidth=0.1)#�u���ϧ�e���z�� freqpoly=���Ʀh���
ggplot(data=smaller,mapping=aes(x=carat))+geom_histogram(binwidth = 0.01)

#���`,���s��
ggplot(diamonds)+geom_histogram(mapping=aes(x=y),binwidth = 0.5)
ggplot(diamonds)+geom_histogram(mapping=aes(x=y),binwidth=0.5)+coord_cartesian(ylim=c(0,50))#�Ny�b�Ԫ����p��
unusual<-diamonds%>%filter(y<3|y>20)%>%arrange(y)

#�ʥ���
#��ӿ���~�򥼧������
diamonds2<-diamonds%>%filter(between(y,3,20))#�˱�a�����`�ȸ��
diamonds2<-diamoned%>%mutate(y=ifelse(y<3|y>20,NA,y))#�ʥ��Ȩ��N���M�`��
ggplot(data=diamonds2,mapping = aes(x=x,y=y))+geom_point()#geom_point(na.rm=TRUE)����ĵ�i
nycflights13::flights%>%
  mutate(cancelled=is.na(dep_time),
         sched_hour=sched_dep_time%/%100,
         sched_min=sched_dep_time%%100,
         sched_dep_time=sched_hour+sched_min/60)%>%
  ggplot(mapping=aes(sched_dep_time))+
  geom_freqpoly(mapping=aes(color=cancelled),
                binwidth=1/4)
ggplot(data = diamonds,mapping=aes(x=price))+geom_freqpoly(mapping=aes(color=cut),binwidth=500)