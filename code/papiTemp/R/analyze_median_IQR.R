#' Calculate median and IQR
#' @param df main dataframe for core pangenome analysis
#' @return data.frame
analyze_median_IQR <- function(df){
  df %>% 
    dplyr::group_by(CombID) %>% 
    dplyr::summarise(no = n(),
                     median = median(Count),
                     IQR = IQR(Count, na.rm = TRUE)) %>% 
    dplyr::arrange(median)
}