#' Extracts organism/genome name as well as protein identifier from reference protein line
#' 
#' @param ref_prot_line character vector; must contain genome name (equal to the
#'   .faa file name), protein identifier must start with ">" and be separated
#'   from genome name with underscore "_"
#' @param genomes character vector with genome names taken from .faa files
#'
#' @return list with genome name and protein identifier of the reference protein
#' @export
#'
#' @examples
#' get_ref_prot_details(">PROTEIN_ID1_GENOME_A", c("GENOME_A", "GENOME_B"))
#' 
get_ref_prot_details <- function(ref_prot_line, 
                                 genomes){
  
  n_proteins <- length(ref_prot_line)
  if (n_proteins > 1) {
    message("detected two reference proteins. Only the first one will be selected")
    ref_prot_line <- ref_prot_line[1]
  }
  
  # which microorganism is this protein from
  matched <- str_match(ref_prot_line, genomes)
  # str_match returns a matrix
  matched <- matched[,1]
  
  if (all(is.na(matched))) {
    message(paste(ref_prot_line, "does not have matching genome"))
    genome <- NA_character_
  } else {
    genome <- genomes[which(!is.na(matched))]
  }
  
  ref_prot_name <- str_extract(ref_prot_line, paste0("(?<=>).+(?=_", genome, ")"))
  
  list(
    ref_prot = list(
      host = genome,
      name = ref_prot_name
      )
    )
  
}
