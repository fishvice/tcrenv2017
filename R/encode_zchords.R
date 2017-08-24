# code from ziggy stardust
#   note that here there is not validation/testing done
#   read: use stuff at own risk

#' encode_zchords
#'
#' The function takes x and y values and converts them to a grid whose value
#' represent the midpoints given dx and dy. Returns a character vector where
#' the grid "coding" are the midpoints separated by a colon. Can be split up
#' by e.g. the tidyr:separate function.
#'
#' @param x A numerical vector, normally a longitude
#' @param y A numerical vector, normally a latitude
#' @param dx Resolution on the x-axis, normally in decimal degrees (default 1 degree)
#' @param dy Resolution on the y-axis, normally in decimal degrees (default half of the longitude)
#' @param invalids A logical (default TRUE), convert values outside mercator ranges to NA.
#'
#' @return
#' @export
#'
encode_zchords <- function(x, y, dx = 1, dy = 0.5 * dx, invalids = TRUE) {

  x.brks <- seq(floor(min(x)),ceiling(max(x)),dx)
  x.ints <- findInterval(x, x.brks, all.inside = TRUE)
  x <- (x.brks[x.ints] + x.brks[x.ints + 1]) / 2

  y.brks <- seq(floor(min(y)),ceiling(max(y)),dy)
  y.ints <- findInterval(y, y.brks, all.inside = TRUE)
  y <- (y.brks[y.ints] + y.brks[y.ints + 1]) / 2

  if(invalids) {
    x <- ifelse(x >= -180 & x <= 180, x, NA)
    y <- ifelse(y >= -90  & y <= 90 , y, NA)
  }

  return(paste(round(x,6), round(y,6), sep = ":"))

}