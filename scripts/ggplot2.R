map_data("world") %>%
  ggplot(aes(x = long, y = lat, group = group)) +
  theme_bw() +
  geom_polygon(fill = "grey") +
  scale_y_continuous(NULL) +
  scale_x_continuous(NULL) +
  coord_map("ortho", xlim = c(-45, 30), ylim = c(35, 90))
iceland <- map_data("world", region = "Iceland")
m <-
  ggplot() +
  theme_bw() +
  geom_polygon(data = iceland, aes(long, lat, group = group), fill = "grey90") +
  coord_map() +
  labs(x = NULL, y = NULL)
m



xlim <- c(-28, -10)
ylim <- c(62.5, 67.5)
library(marmap)
depth <-
  getNOAA.bathy(lon1 = xlim[1], lon2 = xlim[2],
                lat1 = ylim[1], lat2 = ylim[2],
                resolution = 1) %>%
  fortify()  # turn the object into a data.frame



m2 <- get_map(location = c(-19,65), zoom= 6)
m2 <- ggmap(m2) +
  labs(x = NULL, y = NULL)
m2 +
  geom_point(data = minke, aes(lon, lat)) +
  geom_contour(data = depth, aes(x,y, z = z), breaks = c(-250, -500), colour = "white")

m2 <- get_map(location = c(-19,65), zoom= 6, maptype = "satellite")
m2 <- ggmap(m2) +
  labs(x = NULL, y = NULL)
m2


geo::ir2d("50C2")


get_map(location = c(-21.8666667,64.25) , zoom= 15) %>%
  ggmap()
