library(tidyverse)
library(readxl)
library(openxlsx)

dat <- data.frame(id=numeric(0), species=character(0),
                  length=numeric(0),age=numeric(0),
                  lat = numeric(0),lon=numeric(0))
dat <- edit(dat)

save(dat,file='d.Rdata')
load("C:/Users/atlantic/Desktop/exercise/d.Rdata")

minke <- read_csv('data/minke.csv')

minke <- read_csv('../tcrenv2017/data/minke.csv')

minke <- read_csv('http://www.hafro.is/~einarhj/data/minke.csv')

minke <-
  read_delim(file = 'data/minke.csv', ## path to the file
             col_names = TRUE,        ## are column names
             ## at the top
             delim = '**',             ## column separator symbol
             skip = 0,                ## num lines at top to skip
             comment = '#')           ## indicating comments

dat <-
  read_delim('data/ex_data.txt', delim = ' ',skip = 1)

dat <- read_csv('data/ex_data2.txt')



write('# comment describing the data', file = 'dataFile.csv')
write_csv(minke,path = 'dataFile.csv', append = TRUE, col_names = TRUE)
write('# other comment at the bottom', file = 'dataFile.csv',append = TRUE)


icod_summary <- read_excel("data/example_excel.xlsx")
download.file("http://www.hafro.is/~einarhj/data/example_excel.xlsx",
              destfile = 'data/example_excel.xlsx',
              mode = "wb")


d <- read_excel('data/example_excel.xlsx',sheet = 'Nobob',
                range = 'A5:D13')

d <- read_excel('data/example_excel.xlsx',sheet = 'Nobob',
                range = 'A5:D13',
                col_types = c('text','numeric','numeric','numeric'))


d2 <- read_excel('data/example_excel.xlsx',sheet = 'Nobob',
                range = 'A16:D24',
                col_types = c('text','numeric','numeric','numeric'))

dtotal <- bind_rows(d,d2,.id='dataset')


write.xlsx(list(minke=minke,iCod=icod_summary),file='RtoExcel.xlsx')

