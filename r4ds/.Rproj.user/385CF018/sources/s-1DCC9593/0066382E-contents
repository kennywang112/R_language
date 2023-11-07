guess_parser('2022-01-12')#試探法找出資料欄型別
cha<-read_csv(readr_example('challenge.csv'),col_types =cols(x=col_double(),y=col_character()))
problems(cha)
cha2<-read_csv(readr_example('challenge.csv'),
               col_types = cols(.default = col_character()))#單純將所有資料欄讀入為字元向量
df<-tribble(
  ~x,~y,
  '1','1.21',
  '2','2.32',
  '3','4.56'
)
type_convert(df)#將剖析試探法套用到一個資料框中的字元資料欄
write_csv(cha,'challenge.csv')
read_csv('cha.csv')#在快取中結果上稍微不可靠,每次讀數都要重新建立資料欄,以下代替
write_rds(cha,'cha.rds')
read_rds('cha.rds')
library(feather)#此套件可跨程式語言分享的快速二進位檔案格式
write_feather(cha,'challenge.feather')
read_feather('challenge.feather')
#feather通常比rds快,r以外可用,rds支援list-columns,feather目前沒有