library(tidyverse)
d <- read_csv('data/minke.csv')
d.2005 <-
  filter(d,year == 2005,sex == 'Female')
d.2005


d.weight <- filter(d,!is.na(weight) | sex=='Male')

i <- d$sex == 'Male' | !is.na(d$weight)

d.base <- d[i,]


d.2004.2007 <- filter(d,year %in% c(2004,2007))


## filter ex

d.noMat <- filter(d,is.na(maturity))

d.N20062007 <-
  filter(d,area == 'North', year > 2005)

d.N20062007 <-
  filter(d,area == 'North', year %in% 2006:2007)


d.N20062007 <-
  filter(d,area == 'North', year %in% c(2006,2007))



d.stom <- select(d,starts_with('stomach'))

d.idage <- select(d,id:age)

d.nidage <- select(d,-c(id:age))

d.redux <-
  select(d,id:lat,starts_with('stomach'))


d.redux <-
  select(d,id,date.caught=date)
d.redux

# select ex
d.sel <-
  select(d,age,length, whale_id = id)

d.weigthcold <- select(d,contains('weight'))



d.arr2 <- arrange(d,year,desc(stomach.volume))

## mutate ex

d.fulton <- mutate(d,K = 100000*(weight/length^3))

ggplot(d.fulton,aes(K)) + geom_histogram()



summarise(d,
          ml = mean(length),
          ma = mean(age, na.rm = TRUE),
          sl = sd(length))


d.summ2 <-
  summarise(d,
            num_whales = n(),
            num_years = n_distinct(year),
            num_mat = n_distinct(maturity))

## summarise ex
## How many females were caught in the Northern area

d.redux <- filter(d,sex == 'Female', area == 'North')
summ <- summarise(d.redux,n = n())

## alternative
summarise(filter(d,sex == 'Female', area == 'North'),n = n())

## Calculate the mean stomach volume and standard deviation of all whales caught
summarise(d,
          mvol = mean(stomach.volume, na.rm = TRUE),
          svol = sd(stomach.volume, na.rm = TRUE))


d.group <-
  group_by(d,maturity)

summarise(d.group,
          mvol = mean(stomach.volume, na.rm = TRUE),
          svol = sd(stomach.volume, na.rm = TRUE))


d.gm <- mutate(d.group, sl = length/mean(length))



vital.stats <-
  summarise(d.group,
            num_whales = n(),
            num_years = n_distinct(year),
            ml = mean(length))

d.gr <- group_by(d,year,sex)
d.summ <- summarise(d.gr,n=n())

d.sp <- spread(d.summ,year,n)
d.sp

## spread ex

d.gr <- group_by(d,year,area)
d.summ <- summarise(d.gr,n=n())

d.sp <- spread(d.summ,area,n)

##

d.sep <-
  separate(d,date,c('y','m','d','h','m','s'),
           convert = TRUE,  ## convert to numeric (if possible)
           remove = FALSE)  ## keep the original column
d.sep

## %>%  example
tab <-
  d %>%
  group_by(maturity,sex) %>%
  summarise(n=n()) %>%
  spread(sex,n,fill = -99)

