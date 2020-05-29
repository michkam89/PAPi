#' this is supposed to return genome, prot id and similaity to reference for each 
#' cluster
get_prot_details <- function(prot_clusters, 
                             genomes){
  


  for (g in seq_along(genomes)) {
    matched <- map(prot_clusters, str_detect, pattern = genomes[g]) 
    print(matched)
  }
  
  # str_match returns a matrix
  #matched <- matched[1,1]
  matched
  # if (all(is.na(matched))) {
  #   message(paste(ref_prot_line, "does not have matching genome"))
  #   genome <- NA_character_
  # } else {
  #   genome <- genomes[which(!is.na(matched))]
  # }
  # 
  # ref_prot_name <- str_extract(ref_prot_line, paste0("(?<=>).+(?=_", genome, ")"))
  # 
  # list(
  #   ref_prot = list(
  #     host = genome,
  #     name = ref_prot_name
  #     )
  #   )
  
}
