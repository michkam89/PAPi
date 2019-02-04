#' Modify column names
#' 
#' Modify column names to more readable format
#' @param df data.frame, output of multmerge function
#' @return data.frame
modify_colnames <- function(df){
  #placeholder for new colum names
  new_collnames <- vector()
  #logic
  for (col in colnames(df)){
    
    if (col == "CombID"){
      new_collnames <- c(new_collnames, col)
    }
    else if (nchar(col) == 2){
      
      new_collnames <- c(new_collnames, sub("^X", 0, col)) 
    }
    else if (nchar(col) > 2){
      new_collnames <- c(new_collnames, sub("^X", "", col))
    }
  }
  #overwrite colnames
  colnames(df) <- new_collnames
  df
}