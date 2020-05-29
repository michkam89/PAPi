#' detect_faa_files
#' Detects .faa files in the specified directory
#' @param faa_fdir directory with .faa files
#'
#' @return character vector of .faa files
#' @export

detect_faa_files <- function(faa_fdir){
  
  if (!dir.exists(faa_fdir))
    stop("Directory does not exist")
  
  files <- dir(faa_fdir)
  
  faa_file_exist <- grepl(x = files, pattern = ".faa$")
  
  if (!any(faa_file_exist))
    stop("Specified directory does not contain any .faa file")
  
  faa_files <- files[which(faa_file_exist)]
  
  faa_files
}
