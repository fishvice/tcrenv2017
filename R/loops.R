library(tidyverse)
library(stringr)

x <- -10
## check if x is greater than 0
if(x > 0){
  print('x is positive')
}

if(FALSE){
  plot(1:9)
  print("")
}


x <- -NA
## check if x > 10
if(is.na(x)){
  print("x is NA")
} else if(x > 10) {
  print('x is greater than 10')
} else if(x >= 0){
  print('x is less than 10 but greater than or equal to 0')
} else {
  print('x is negative')
}


for(i in 1:10) {
  ## do some stuff
  print(i)
}

minke <- read_csv('data/minke.csv')

## find the number of entries in the data
n <- nrow(minke)
## calculate the mean length old fashion way
ML <- 0
for(i in 1:n) {
  ML <- ML + minke$length[i]
}
ML <- ML/n
ML

ML <- 0
for(i in seq_along(minke$length)) {
  ML <- ML + minke$length[i]
}
ML <- ML/n
ML

ML <- 0
for(L in minke$length) {
  ML <- ML + L
}
ML <- ML/n
ML

## example with purrr
list.files('data') %>%
   map(str_length)

for(ff in list.files('data')){
  print(str_length(ff))
}

?stop
?warning
