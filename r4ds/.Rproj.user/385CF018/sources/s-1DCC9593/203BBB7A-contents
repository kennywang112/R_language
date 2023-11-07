#readr將一般檔案轉為資料框
library(tidyverse)
read_csv('a,b,c
         1,2,3
         4,5,6')
read_csv('fffff
         ffff
         x,y,z
         1,2,3',skip=2)
read_csv('# ddddd
         x,y,z
         1,2,3',comment='#')
read_csv('1,2,3\n4,5,6',col_names=c('x','y','z'))#col_names=FALSE以X1~Xn標示
read_csv('a,b,c\n1,2,.',na='.')
parse_integer(c('1','231','.'),na='.')#parse剖析器
x<-parse_integer(c('1','2','abc','123.45'))
problems(x)#失敗處很多時使用取得完整集合,回傳tibble接著能以dplyr操作
parse_double('1,23',local=locale(decimal_mark = ','))#處理小數點逗點
parse_number('$100')#忽略非數值字元
parse_number('123.456.789',locale=locale(grouping_mark = '.'))#忽略分組標記
charToRaw('kenny')#取得字喘最底層表示值
x1<-'123'
parse_character(x1,locale=locale(encoding='Latin1'))#字串
guess_encoding(charToRaw(x1))
fruit<-c('a','b')
parse_factor(c('a','b','c'),levels=fruit)#因子
parse_datetime('2022-04-28T2022')#ISO8608格式 時間
parse_date('2022-04-28')
parse_time('01:10pm')