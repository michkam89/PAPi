#' Removes reference proteins from cluster
#'
#' @param clstr_prot_list list of protein clusters
#' @param reference_proteins list with reference proteins in cluster
#'
#' @return list of proteins that are not reference proteins
#' @export

remove_ref_prot <- function(clstr_prot_list, reference_proteins){
  
  map2(clstr_prot_list, 
       reference_proteins, 
       function(x,y) {keep(x, x != y)})
  
}
