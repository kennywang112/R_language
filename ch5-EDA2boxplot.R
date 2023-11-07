ggplot(data=diamonds,mapping = aes(x=cut,y=price))+geom_boxplot()
ggplot(data=mpg,mapping = aes(x=class,y=hwy))+geom_boxplot()#���{��&���l����
ggplot(data=mpg)+geom_boxplot(mapping=aes(x=reorder(class,hwy,FUN=median),y=hwy))#hwy����ƭ��s�ƦC���l������
#�����ܼƦW�٥i��+coord_flip()
#���'���O'�ܼƶ����@�ܲ����Y,���C�ӲզX�p���[���(��ؤ�k)
ggplot(data=diamonds)+geom_count(mapping=aes(x=cut,y=color))
diamonds%>%count(color,cut)%>%
  ggplot(mapping=aes(x=color,y=cut))+geom_tile(mapping=aes(fill=n))#���p���`�ƦA���ǬM�g
#���'�s��'�ܼ�
ggplot(data=diamonds)+geom_point(mapping = aes(x=carat,y=price),alpha=1/100)#��ƤӦh�|���|,�ϥ�alpha,�Ϋإ߲էO
#�էO�إ�geom_bin2d(),geom_hex()�N�y�Х������ά�2d
ggplot(data=smaller)+geom_bin2d(mapping=aes(x=carat,y=price))#�x�βէO
#install.packages('hexbin')
ggplot(data=smaller)+geom_hex(mapping=aes(x=carat,y=price))#�����
#�s���ܼƫإ߲էO->���O�ܼ� ��ı�Ƥ@�����O�ܼ�&�s���ܼ�
ggplot(data=smaller,mapping=aes(x=carat,y=price))+geom_boxplot(mapping=aes(group=cut_width(carat,0.1)))
#cut_width(x,width)�Nx�����e�׬�width���էO
#varwidth=TRUE�ϲ��ϼe�׻P����I�Ʀ�����
ggplot(data=smaller,mapping=aes(x=carat,y=price))+geom_boxplot(mapping=aes(group=cut_number(carat,20)))
#cut_number��ܤj���ۦP�ƥت�����I

#�Ҧ��P�ҫ�
ggplot(data=faithful)+geom_point(mapping=aes(x=eruptions,y=waiting))
library(modelr)
mod<-lm(log(price)~log(carat),data=diamonds)
diamonds2<-diamonds%>%add_residuals(mod)%>%mutate(resid=exp(resid))
ggplot(data = diamonds2)+geom_point(mapping=aes(x=carat,y=resid))#residuals�ݮt(�w���ȻP��ڭȮt)
ggplot(data=diamonds2)+geom_boxplot(mapping = aes(x=cut,y=resid))
#���X�qcarat�w��price���ҫ��p��resuduals,���ڭ̥H�s���[�I�˵�carat�Ƽv�T�Q�����᪺�p�ۻ���