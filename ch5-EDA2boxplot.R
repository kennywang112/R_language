ggplot(data=diamonds,mapping = aes(x=cut,y=price))+geom_boxplot()
ggplot(data=mpg,mapping = aes(x=class,y=hwy))+geom_boxplot()#里程數&車子種類
ggplot(data=mpg)+geom_boxplot(mapping=aes(x=reorder(class,hwy,FUN=median),y=hwy))#hwy中位數重新排列車子的種類
#較長變數名稱可用+coord_flip()
#兩個'類別'變數間的共變異關係,為每個組合計算觀察數(兩種方法)
ggplot(data=diamonds)+geom_count(mapping=aes(x=cut,y=color))
diamonds%>%count(color,cut)%>%
  ggplot(mapping=aes(x=color,y=cut))+geom_tile(mapping=aes(fill=n))#先計算總數再美學映射
#兩個'連續'變數
ggplot(data=diamonds)+geom_point(mapping = aes(x=carat,y=price),alpha=1/100)#資料太多會重疊,使用alpha,或建立組別
#組別建立geom_bin2d(),geom_hex()將座標平面分割為2d
ggplot(data=smaller)+geom_bin2d(mapping=aes(x=carat,y=price))#矩形組別
#install.packages('hexbin')
ggplot(data=smaller)+geom_hex(mapping=aes(x=carat,y=price))#六邊形
#連續變數建立組別->類別變數 視覺化一個類別變數&連續變數
ggplot(data=smaller,mapping=aes(x=carat,y=price))+geom_boxplot(mapping=aes(group=cut_width(carat,0.1)))
#cut_width(x,width)將x分為寬度為width的組別
#varwidth=TRUE使盒圖寬度與資料點數成正比
ggplot(data=smaller,mapping=aes(x=carat,y=price))+geom_boxplot(mapping=aes(group=cut_number(carat,20)))
#cut_number顯示大約相同數目的資料點

#模式與模型
ggplot(data=faithful)+geom_point(mapping=aes(x=eruptions,y=waiting))
library(modelr)
mod<-lm(log(price)~log(carat),data=diamonds)
diamonds2<-diamonds%>%add_residuals(mod)%>%mutate(resid=exp(resid))
ggplot(data = diamonds2)+geom_point(mapping=aes(x=carat,y=resid))#residuals殘差(預測值與實際值差)
ggplot(data=diamonds2)+geom_boxplot(mapping = aes(x=cut,y=resid))
#擬合從carat預測price的模型計算resuduals,讓我們以新的觀點檢視carat數影響被移除後的鑽石價格