#' Calculate mean and sd
#' @param df main dataframe for core pangenome analysis
#' @return data.frame
analyze_mean_sd <- function(df){
  df %>% 
    dplyr::group_by(CombID) %>% 
    dplyr::summarise(no = dplyr::n(),
              mean = mean(Count,na.rm = TRUE),
              sd = sd(Count)) %>% 
    dplyr::arrange(mean)
}