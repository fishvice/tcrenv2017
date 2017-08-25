library(broom)
library(tidyverse)

mtcars %>%
  modelr::bootstrap(n=100) %>%
  purrr::map(.$strap, dim) %>%
  bind_rows()
  do(data_frame(m=mean(.$mpg),
                y=)) %>%
  ungroup() %>%
  group_by(year,litter_class)
  summarise(mm=mean(m),sm=sd(m))

  library(purrr)
  boot <-
    modelr::bootstrap(mtcars, 100) %>%
    mutate(model = purrr::map(strap,~select(mpg))) %>% str()
  unnest()

  purrr::map(boot$strap,~mean(.$mpg,na.rm=TRUE)) %>%
    purrr::map_df(broom::tidy, .id = "id")