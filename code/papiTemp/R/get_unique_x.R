#' get unique clusters for genome X
#' @param x integer vector genome 1
#' @param y integer vector genome 2
get_unique_X <- function(x,y){
  sum(x == 1 & y !=1)
}