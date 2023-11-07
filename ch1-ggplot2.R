ggplot2::ggplot() #雙冒號表明某函示或資料及來自何處
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy,color=class))
#shape=class alpha=class
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy),color="blue")
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy))+facet_wrap(~class,nrow=2)#顯示子集
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy))+facet_grid(drv~cyl)
ggplot(data=mpg)+geom_smooth(mapping=aes(x=displ,y=hwy,color=drv),show.legend = FALSE)
ggplot(data = diamonds)+geom_bar(mapping = aes(x=cut,fill=clarity),position="fill")
#position="dodge" position="jitter"
#+coord_flip() x,y軸對調
nz<-map_data("nz")
ggplot(nz,aes(long,lat,group=group))+geom_polygon(fill="blue",color="blue")+
  coord_quickmap()
#coord_quickmap() 改成正確長寬比
bar<-ggplot(data = diamonds)+geom_bar(mapping=aes(x=cut,fill=cut),
                                      show.legend = FALSE,width = 1)+
  theme(aspect.ratio=1)+labs(x=NULL,y=NULL)
bar+coord_flip()
bar+coord_polar()
#aes為aesthetic mapping縮寫,負責將素材綁定至x,y軸