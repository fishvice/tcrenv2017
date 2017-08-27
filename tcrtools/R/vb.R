#' @title von Bertalanffy function
#'
#' @description Calculates length from age given the von Bertalanffy parameters
#'
#' @param age A numeric vector of age
#' @param loo A value for L-infinity
#' @param k A value for k
#' @param to A value for t-zero
#'
#' @return A vector of derived lengths
#' @export
#'
vb <- function(age, loo = 120, k = 0.15, to = 0) {

  length <- loo * (1 - exp(-(k * (age - to))))

  return(length)

}
