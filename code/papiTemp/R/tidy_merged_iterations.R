#' clean up data.frame
#' @param out data.frame
tidy_merged_iterations <- function(out){
  out_df <- data.frame(out)
  
  colnames(out_df) <- as.integer(c(1:iterations))
  
  out_df$N_genomes <- as.factor(c(1:44))
  
  out_df <- tidyr::gather(
    out_df,
    key = iteration, 
    value = pangenome_size,
    -N_genomes)
  
  out_df
}