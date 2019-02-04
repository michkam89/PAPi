#' Transform to boolean number of proteins per cluster to 1 if duplicates occur.
#' @param x integer vector

bool_multiplicates <- function(x){
  ifelse(x > 1, 1, x)
}