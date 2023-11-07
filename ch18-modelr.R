library(tidyverse)
library(modelr)
options(na.action=na.warn)
ggplot(sim1,aes(x,y))+geom_point()
models<-tibble(
  a1=runif(250,-20,40),#產生250個介於-20到40的均勻分布隨機變數
  a2=runif(250,-5,5)
)
ggplot(sim1,aes(x,y))+
  geom_abline(aes(intercept=a1,slope=a2),
              data=models,alpha=1/4)+geom_point()#geom_abline接受一個斜率(slope)和截距(intercept)
model1<-function(a,data){
  a[1]+data$x*a[2]
}#計算每個點與模型之間的垂直距離
model1(c(7,1.5),sim1)
#有30個距離，要把它濃縮->方均根偏移[計算實際與預測值的差(平方再平均再平方根)]
measure_distance<-function(mod,data){
  diff<-data$y-model1(mod,data)
  sqrt(mean(diff^2))}
measure_distance(c(7,1.5),sim1)

sim1_dist<-function(a1,a2){
  measure_distance(c(a1,a2),sim1)}#改成變數c(7,1.5) to c(a1,a2)
models<-models%>%
  mutate(dist=purrr::map2_dbl(a1,a2,sim1_dist))#製作一個double向量
models
#把最佳的模型作圖
ggplot(sim1,aes(x,y))+
  geom_point(size=2,color='grey30')+
  geom_abline(
    aes(intercept=a1,slope=a2,color=-dist),
    data=filter(models,rank(dist)<=10)
  )
ggplot(models,aes(a1,a2))+geom_point(
  data = filter(models,rank(dist)<=10),
  size=4,color='red'
)+geom_point(aes(colour=-dist))#凸顯十個最佳的模型

grid<-expand.grid(
  a1=seq(-5,20,length=25),
  a2=seq(1,3,length=25))%>%mutate(dist=purrr::map2_dbl(a1,a2,sim1_dist))
ggplot(grid,aes(a1,a2))+geom_point(
  data = filter(grid,rank(dist)<=10),
  size=4,color='red'
)+geom_point(aes(colour=-dist))#改成兼具相等的最佳模型

ggplot(sim1,aes(x,y))+
  geom_point(size=2,color='grey30')+
  geom_abline(
    aes(intercept=a1,slope=a2,color=-dist),
    data=filter(grid,rank(dist) <= 10))#十個最佳模型疊到資料上(和28行差filter(grid))
#第一種做法
#newton-raphson search更好的方法找到最佳模型
best<-optim(c(0,0),measure_distance,data=sim1)
best$par
ggplot(sim1,aes(x,y))+geom_point(size=2,color='grey30')+
  geom_abline(intercept=best$par[1],slope=best$par[2])
#第二種做法
#線性模型(linear models)
sim1_mod<-lm(y~x,data=sim1)
coef(sim1_mod)
ggplot(sim1,aes(x,y))+geom_point(size=2,color='grey30')+
  geom_abline(intercept = coef(sim1_mod)[1],slope=coef(sim1_mod)[2])
#視覺化模型的預測
grid<-sim1%>%data_grid(x)
#data_grid第一個引數是一個資料框，後面的每個引述它會找出唯一變數
grid<-grid%>%add_predictions(sim1_mod)#將該模型的預測新增到資料框的新資料欄
grid
ggplot(sim1,aes(x))+geom_point(aes(y=y))+geom_line(
  aes(y=pred),data=grid,colour='red',size=1
)#做上面額外的事情是因為R適用於任何模型
sim1<-sim1%>%add_residuals(sim1_mod)#新增殘差(計算預測和實際)
ggplot(sim1,aes(resid))+geom_freqpoly(binwidth=0.5)
ggplot(sim1,aes(x,resid))+geom_ref_line(h=0)+geom_point()#隨機雜訊->模型在捕捉資料方面做得好
