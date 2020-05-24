#' Appends proteins to a cluster they derrive from
#' 
#'
#' @param rebased_clusters input cluster file as a list but trimmed to the current
#'   iteration.
#' @return a character vector of protein descriptions
#' @export

append_proteins <- function(rebased_clusters){
  # assertions
  test <- class(rebased_clusters) == "character"
  if (!test) {
    stop("input is not a character vector")
  }
  
  test <- startsWith(rebased_clusters[1], ">")
  if (!test) {
    stop(
      paste("first element is not a cluster name as does not contain '>' as first character",
            "lines with clusters should contain '>' as a first character in each row"))
  }
  
  # vector placeholder
  vec <- vector()
  
  # first element is a current cluster name - 
  rebased_clusters <- rebased_clusters[-1]
  
  for (line in seq_along(rebased_clusters)) {
    
    # extract value of current line
    curr_ln <- rebased_clusters[line]
    
    test <- !startsWith(curr_ln, ">")
    if (test) {
      vec <- append(vec, curr_ln)
    } else {
      
      # loop will break on first row starting 
      # with ">" which is the next cluster
      break()
      
    }
    
  }
  vec
}
