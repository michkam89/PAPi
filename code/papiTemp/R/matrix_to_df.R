#' converts 0/1 matrix to data.frame
#' @param my_bool_matrix m0/1 matrix table
#' @import dplyr
matrix_to_df <- function(my_bool_matrix, times = 10000){
  # create id column
  large_df <- data.frame(id = 1:times)
  
  for (i in 1:length(colnames(my_bool_matrix))){
    
    colname <- paste0("set_", i)
    
    # generate random combinations of genomes by sampling 10000 times
    rep <- data.frame(
      rep.int(
        sample(x = colnames(my_bool_matrix)),
        times = times)
    )
    
    colnames(rep) <- colname
    
    large_df <- cbind(large_df, rep)
  }
  
  large_df <- dplyr::distinct(large_df)
  # transpose df
  #tlarge_df <- data.frame(large_df)
  tlarge_df <- data.frame(t(large_df))
  # remove 1st row
  tlarge_df[-1,]
}