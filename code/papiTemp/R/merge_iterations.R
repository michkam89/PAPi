#' wrapper function calculating pangenome for all iterations
#' @param m 0/1 matrix
#' @param comb combination vector
#' @return a list of iterations

merge_iterations <- function(m, comb){
  res <- list()
  for (i in seq_along(comb[1:ncol(comb)])) {
    name <- colnames(comb[i])
    print(name)
    print(paste(i, comb[i]))
    res[i] <- list(calc_set_pangenome(m, comb[[name]]))
    print(i)
  }
  res
}
