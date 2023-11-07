#變換(變換模型公式使它近似非線性函式)
df<-tribble(
  ~y,~x,
  1,1,
  2,2,
  3,3)
model_matrix(df,y~x^2+x)
model_matrix(df,y~I(x^2)+x)#永遠都可以使用model_matrix()來查看lm()擬合了甚麼方程式
#poly()擬合像是泰勒定理(可以使用多像式的無限和來近似任何平滑函式)
model_matrix(df,y~poly(x,2))
#poly在資料的範圍外很快就會讓多項式跑到正或負無限
library(splines)#自然樣條(natural splines)
model_matrix(df,y~ns(x,2))
sim5<-tibble(
  x=seq(0,3.5*pi,length=50),
  y=4*sin(x)+rnorm(length(x))
)
ggplot(sim5,aes(x,y))+geom_point()#近似一個非線性函式
mod1<-lm(y~ns(x,1),data=sim5)
mod2<-lm(y~ns(x,2),data=sim5)
mod3<-lm(y~ns(x,3),data=sim5)
mod4<-lm(y~ns(x,4),data=sim5)
mod5<-lm(y~ns(x,5),data=sim5)
grid<-sim5%>%data_grid(x=seq_range(x,n=50,expand=0.1))%>%gather_predictions(mod1,mod2,mod3,mod4,mod5,.pred = 'y')
ggplot(sim5,aes(x,y))+geom_point()+geom_line(data=grid,color='red')+facet_wrap(~model)
#缺失值
df<-tribble(
  ~x,~y,
  1,2.2,
  2,NA,
  3,3.5,
  4,8.3,
  NA,10
)
mod<-lm(y~x,data=df)
mod<-lm(y~x,data=df,na.action = na.exclude)
nobs(mod)#查看使用了多少觀察
