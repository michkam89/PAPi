#' find_ref_prot
#' Finds line with the reference protein within a cluster
#' @param single_cluster a single cluster as a named list
#'
#' @return character vector with the reference protein line
#' @export
#'

find_ref_prot <- function(single_cluster = x){
  
  is_reference_prot <- map(single_cluster, function(x){
    str_detect(x, "(?<=\\.\\.\\.\\s)\\*$")
  }) %>% unlist(use.names = F)
  single_cluster <- unlist(single_cluster, use.names = F)
  reference_prot <- single_cluster[which(is_reference_prot)]
  reference_prot
}
