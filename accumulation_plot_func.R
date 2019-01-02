#' Transform to boolean number of proteins per cluster to 1 if duplicates occur.
#' @param x integer vector

bool_multiplicates <- function(x){
  ifelse(x > 1, 1, x)
}
#' get core clusters between two genomes
#' @param x integer vector genome 1
#' @param y integer vector genome 2
get_core <- function(x,y){
  sum(x == 1 & y == 1)
}
#' get unique clusters for genome X
#' @param x integer vector genome 1
#' @param y integer vector genome 2
get_unique_X <- function(x,y){
  sum(x == 1 & y !=1)
}
#' get unique clusters for genome Y
#' @param x integer vector genome 1
#' @param y integer vector genome 2
get_unique_Y <- function(x,y){
  sum(x != 1 & y ==1)
}

#' gathers output for two genomes
#' @param x output of get_unique_X
#' @param y output of get_unique_Y
#' @param core output of get_core

get_res <- function(x, y, core){
  list(genome_X = x, genome_Y = y, genomes_core = core)
}

#' Calculates pangenome for one iteration. Returns integer vector with 
#' accumulative pangenome sizes.
#' @param m 0/1 matrix
#' @param comb combination vector
#' 

calc_set_pangenome <- function(m, comb){
    count <- 2
    first_round <- TRUE
    stopifnot(!is.null(comb))
    while (count < length(comb)){
      accumulation_vec <- vector()
      #' oblicz pangenom dla dwóch pierwszsych genomów z iteracji
      if(first_round){
        #print("first round")
        first_round <- FALSE
        genome_x <- comb["set_1"]
        genome_y <- comb["set_2"]
        x <- get_unique_X(m[,genome_x],
                          m[,genome_y])
      
        y <- get_unique_Y(m[,genome_x],
                          m[,genome_y])
      
        core <- get_core(m[,genome_x],
                         m[,genome_y])
      
        get_res_list <- get_res(x,y,core)
        #' size of pangenome for first two genomes
        init_pan <- sum(get_res_list$genomes_core, 
                        get_res_list$genome_X, 
                        get_res_list$genome_Y)
      
        accumulation_vec[2] <- init_pan
      
        #' remove positive clusters for already used genomes from 0/1 matrix
        m <- dplyr::filter(m, m[,genome_x] != 1 & m[,genome_y] != 1)
      }
      #' proceed with remaining genome
      if (!first_round){
      current_pan <- init_pan
      #' get names of genomes that are left
      remaining_genomes <- names(comb[3:length(comb)])
        #' for every genome that is left
        for (j in seq_along(remaining_genomes)){
          count <- count + 1
          #' current genome to be added to pangenome
          next_genome <- comb[remaining_genomes[j]]
          #' number of new clusters
          new_genes <- nrow(dplyr::filter(m, m[,next_genome] == 1))
          #' remove positive clusters for already used genomes from 0/1 matrix
          m <- dplyr::filter(m, m[,next_genome] != 1)
          #' update pangenome
          current_pan <- current_pan + new_genes
          #' update output vector
          accumulation_vec[j+2] <- current_pan
        }
      }
    }
  accumulation_vec
}

#' @param m 0/1 matrix
#' @param comb combination vector
#' @return a list of iterations
merge_iterations <- function(m, comb){
  res <- list()
  for (i in seq_along(comb[1:ncol(comb)])) {
    name <- colnames(comb[i])
    res[i] <- list(calc_set_pangenome(m, comb[[name]]))
    print(i)
  }
  res
}
