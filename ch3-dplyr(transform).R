library(ggplot2)
library(nycflights13)
library(dplyr)
library(tidyverse)
nycflights13::flights
#dbl����ׯB�I�� lgl�޿�V�q(�u�ttrue,false) fctr�]�l�T�w�X�ӥi��Ȫ������O�ܼ�
x<-filter(flights,month==1,day==1)
#filter�z���[��� mutate�H�J���ܼƨ禡�B��ȫإ߷s���ܼ� select�W�٬D���ܼ�
df<-tibble(x=c(1,NA,3))
filter(df,x>1)
arrange(flights,year,month,day)
select(flights,year:day) #year��day������� -(year:day)�H�~
#starts_with("") ends_with("") contains("") match("(.)\\1") num_range("x",1:3)=>x1,x2,x3
rename(flights,tail_num=tailnum)
select(flights,time_hour,air_time,everything())#�D������ everything����̫e��
flights_sml<-select(flights,year:day,ends_with("delay"),distance,air_time)
mutate(flights_sml,gain=arr_delay-dep_delay,speed=distance/air_time*60)#�s�W�ܼ�
transmute(flights,gain=arr_delay,hours=air_time/60,gain_per_hour=gain/hours)#�u�O�d�s�ܼ�
(x<-1:10)
lag(x)#�����
lead(x) #�����
cumsum(x)#�ֿn
cummean(x)#�ֿn������
y<-c(1,2,2,NA,3,4)
min_rank(y)
min_rank(desc(y)) #row_number(y) dense_rank(y) percent_rank(y) cume_disk(y)
summarize(by_day,delay=mean(dep_delay,na.rm=TRUE))#�N��ƦJ�@�Y�K�n����@��ƦC �q�`�Pgroup_by()�f�t
by_day<-group_by(flights,year,month,day)
fl<-flights