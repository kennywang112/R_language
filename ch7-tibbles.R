library(tidyverse)
as_tibble(iris)
tibble(x=1:5,y=1,z=x^2+y)
tb<-tibble(':)'='smile',' '='space','2000'='number')
tribble(
  ~x,~y,~z,
  #--/--/--
  'a',2,3.6,
  'b',1,8.5
  )
nycflights13::flights%>%print(n=10,width=Inf)#列數n與寬度width width=Inf輸出所有資料

#取子集
df<-tibble(x=runif(5),y=rnorm(5))
df$x
df[['x']]
df[[1]]
df%>%.$x
class(as.data.frame(tb))#較舊函式轉為data.frame