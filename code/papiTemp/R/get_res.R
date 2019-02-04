#' gathers output for two genomes
#' @param x output of get_unique_X
#' @param y output of get_unique_Y
#' @param core output of get_core

get_res <- function(x, y, core){
  list(genome_X = x, genome_Y = y, genomes_core = core)
}