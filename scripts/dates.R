#install.packages("icesDatras")

today()    # date
now  ()    # datetime
# generating dates from strings - different format, same date
ymd("2017-08-23")
ymd("20170823")
ymd("20132308")   # returns NA, why?
ydm("20132308")
ymd("20170229")   # returns NA, why?
dmy("23-8-2017")
mdy("8/23/2017")
make_date(2017, 8, 23)
# date-time
ymd_hm("2017/08/23 08:01")
ymd_hms("2017-08-23 08:01:59")
ymd_hms("20170823 080159")
make_datetime(2017, 8, 23, 8, 1, 59)

# sequence of dates
seq(ymd("2017-08-23"), ymd("2017-12-23"), by = "day")
seq(ymd("2017-08-23"), ymd("2017-12-23"), by = "week")
seq(ymd("2017-08-23"), ymd("2044-12-23"), by = "year")


df <-
  getDATRAS("HH", survey = "NS-IBTS", years = 2014, quarters = 1) %>%
  as_tibble() %>%
  unite(id, country = Country, Year, Quarter, Ship, Gear, HaulNo, remove = FALSE) %>%
  select(id, Year:TimeShot, Quarter, HaulDur, DayNight, Country)
colnames(df) <- tolower(colnames(df))
df %>% glimpse()

library(stringr)
?str_pad


df <-
  df %>%
  # add a leading zero if needed
  mutate(timeshot = stringr::str_pad(timeshot, width = 4, side = "left", pad = "0")) %>%
  separate(timeshot, c("hh","mm"), sep = 2, convert = TRUE, remove = FALSE) %>%
  mutate(datetime2 = make_datetime(year, month, day, hh, mm))
df %>%  glimpse()



dt <- now()
dt
as_date(dt)  # this function was used above
year(dt)
quarter(dt)
month(dt)
week(dt)
day(dt)
pm(dt)
am(dt)
hour(dt)
minute(dt)
second(dt)


df <-
  getDATRAS("HH", survey = "NS-IBTS", years = 2014, quarters = 1) %>%
  as_tibble() %>%
  unite(id, country = Country, Year, Quarter, Ship, Gear, HaulNo, remove = FALSE) %>%
  select(id, Year:TimeShot, Quarter, HaulDur, DayNight, Country)
colnames(df) <- tolower(colnames(df))
df <-
  df %>%
  # add a leading zero if needed
  mutate(timeshot = stringr::str_pad(timeshot, width = 4, side = "left", pad = "0"),
         # add ":" as separator between hour:minute
         timeshot = paste0(stringr::str_sub(timeshot, 1, 2),
                           ":",
                           stringr::str_sub(timeshot, 3, 4))) %>%
  # split hh:mm into hour and minute, convert the value to integer but keep the old variable
  separate(timeshot, c("hour", "minute"), convert = TRUE, remove = FALSE) %>%
  mutate(timeshot = ymd_hm(paste(year, month, day, timeshot)))
df %>%  glimpse()


# 1. Create a code that tally's up the number by weekday and country. Create a visualization of the data using a line and point layer.

x <-
  df %>%
  mutate(wday = wday(timeshot)) %>%
  group_by(country, wday) %>%
  summarise(n = n())
spread(x, wday, n)
x %>%
  ggplot(aes(wday, n, colour = country)) +
  geom_point(size = 3) +
  geom_line(lwd = 1) +
  scale_color_brewer(palette = "Set1")


# 2. Create a code that tally's up the number of hauls by hour of the day

df %>%
  mutate(hour = hour(timeshot)) %>%
  group_by(hour) %>%
  summarise(n = n())

# 3. Create a code that tally's the number of hauls by wday and hour. Try to create the following visualization:

df %>%
  mutate(wday = wday(timeshot, label = TRUE),
         hour = hour(timeshot)) %>%
  group_by(wday, hour) %>%
  summarise(n = n()) %>%
  ggplot(aes(wday, hour, size = n)) +
  geom_point(colour = "red", alpha = 0.5) +
  scale_size_area(max_size = 30) +
  geom_text(aes(label = n), colour = "blue", angle = 45, size = 5) +
  scale_y_continuous(breaks = seq(6, 18, by = 2)) +
  labs(x = NULL) +
  theme(legend.position = "none")

# Bonus

df %>%
  mutate(wday = wday(timeshot, label = TRUE),
         hour = hour(timeshot)) %>%
  group_by(country, wday, hour) %>%
  summarise(n = n()) %>%
  ggplot(aes(wday, hour, size = n)) +
  geom_point(colour = "red", alpha = 0.5) +
  scale_size_area(max_size = 20) +
  geom_text(aes(label = n), colour = "blue", angle = 45, size = 5) +
  scale_y_continuous(breaks = seq(6, 18, by = 2)) +
  labs(x = NULL) +
  theme(legend.position = "none") +
  facet_wrap(~ country)
