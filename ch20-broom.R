#purrr和broom的許多模型
library(modelr)
library(tidyverse)
library(gapminder)
gapminder%>%ggplot(aes(year,lifeExp,group=country))+geom_line(alpha=1/3)#每個國家的預期壽命如何隨著時間變化
nz<-filter(gapminder,country=='New Zealand')
nz%>%ggplot(aes(year,lifeExp))+geom_line()+ggtitle('Full data')
nz_mod<-lm(lifeExp~year,data=nz)
nz%>%add_predictions(nz_mod)%>%ggplot(aes(year,pred))+geom_line()+ggtitle('Linear trend+')
nz%>%add_residuals(nz_mod)%>%
  ggplot(aes(year,resid))+geom_hline(yintercept=0,color='white',size=3)+geom_line()+ggtitle('Remainging pattern')
#如何擬合到每個國家?->朝狀資料框
by_country<-gapminder%>%group_by(country,continent)%>%nest()#資料欄裡含有其他資料框
by_country$data[[1]]
#擬合模型
country_model<-function(df){
  lm(lifeExp~year,data=df)
}
models<-map(by_country$data,country_model)#套用到每個資料框
by_country<-by_country%>%mutate(model=map(data,country_model))
by_country%>%filter(continent=='Europe')
by_country%>%arrange(continent,country)
#解除巢狀
by_country<-by_country%>%mutate(resids=map2(data,model,add_residuals))
by_country
resids<-unnest(by_country,resids)
resids
resids%>%ggplot(aes(year,resid))+geom_line(aes(group=country),alpha=1/3)+
  geom_smooth(se=FALSE)#繪製殘差
resids%>%ggplot(aes(year,resid,group=country))+
  geom_line(alpha=1/3)+facet_wrap(~continent)#continent(州)做faceting(面相區分)
#africa有巨大的殘差->沒有擬合好
broom::glance(nz_mod)#取得模型品質資料
a<-by_country%>%mutate(glance=map(model,broom::glance))
a%>%unnest(glance)
glance<-by_country%>%mutate(glance=map(model,broom::glance))
glance<-glance%>%unnest(glance,.drop=TRUE)
glance%>%arrange(r.squared)#最差模型都出現在africa
glance%>%ggplot(aes(continent,r.squared))+geom_jitter(width=0.5)#數目相對少的觀察和一個離散變數，所以geom_jitter有用
bad_fit<-filter(glance,r.squared<0.5)
gapminder%>%semi_join(bad_fit,by='country')%>%ggplot(aes(year,lifeExp,color=country))+geom_line()#拉出特別差的國家