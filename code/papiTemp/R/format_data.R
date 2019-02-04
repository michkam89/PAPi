#' function formatting data for plotting
#' @param df data.frame output Get_Core_Pangenome_List.py
#' @import dplyr
format_data <- function(df){
  colnames(df) <- c("genome", "cluster")
  df$cluster <- as.integer(substring(df$cluster, 8))
  
  df_summarized <- df %>% 
    dplyr::group_by(cluster) %>% 
    dplyr::summarize(N=n())
  
  df <- dplyr::left_join(df, df_summarized, by = "cluster")
  
  # create initial count matrix
  initial_matrix <- data.frame(unclass(table(df$cluster, df$genome)))
  
  #transform multiplicates to boolean
  data.frame(
    lapply(
      initial_matrix, 
      function(initial_matrix) 
      {bool_multiplicates(initial_matrix)}
    )
  )
}