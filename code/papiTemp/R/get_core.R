#' get core clusters between two genomes
#' @param x integer vector genome 1
#' @param y integer vector genome 2
get_core <- function(x,y){
  sum(x == 1 & y == 1)
}