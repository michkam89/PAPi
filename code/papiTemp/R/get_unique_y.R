#' get unique clusters for genome Y
#' @param x integer vector genome 1
#' @param y integer vector genome 2
get_unique_Y <- function(x,y){
  sum(x != 1 & y ==1)
}