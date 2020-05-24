#' Gather clusters
#' 
#' Function processes flat .clstr file - an output from CD-HIT program, and 
#' creates a list where each element is a protein cluster name and sub elements
#' are descriptions of proteins and alignments
#' @param clstr_file output from CD-HIT program, as a list (each line as an element)
#' @export

gather_clusters <- function(clstr_file) {
  # paceholder for list
  cluster_list <- list()

  for (line in seq_along(clstr_file)) {

    l <- clstr_file[line]
    
    
    # check if line contains cluster name
    is_cluster_name <- startsWith(l, ">")
    if (is_cluster_name) {
      # cut the list starting from position of current element
      rebased_clstr_file <- clstr_file[line:length(clstr_file)]
      
      # get all protein names from this cluster
      cluster_list[[l]] <- append_proteins(rebased_clstr_file)
      
    } else {
      # do not perform action for lines that are not cluster names
      next()
    }
    
  }
  cluster_list
}
