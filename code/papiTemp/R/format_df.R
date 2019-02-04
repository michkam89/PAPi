#' Change structure of main table
#' @param df dataframe output of modify_colnames
#' @import dplyr
#' @import tidyr
#' @return dataframe used in subsequent core pangenome analysis
format_df <- function(df){
  df <- df[,order(names(df))]
  df <- tidyr::gather(
    df_clean,
    key = "CombID",
    value = "Count") %>%
    dplyr::filter(!is.na(Count))
  
  df$CombID <- as.integer(df$CombID)
  dplyr::mutate(df, Count = ifelse(CombID == 1, NA, Count))
}