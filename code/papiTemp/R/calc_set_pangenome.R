#' Calculates pangenome for one iteration. Returns integer vector with
#' accumulative pangenome sizes.
#' @param m 0/1 matrix
#' @param comb combination vector

calc_set_pangenome <- function(m, comb){
  count <- 2
  first_round <- TRUE
  stopifnot(!is.null(comb))
  while (count < length(comb)){
    accumulation_vec <- vector()
    # count pangenome for two first genomes from iteration
    if(first_round){
      first_round <- FALSE
      genome_x <- comb["set_1"]
      genome_y <- comb["set_2"]
      x <- get_unique_X(
        m[,genome_x],
        m[,genome_y]
      )

      y <- get_unique_Y(
        m[,genome_x],
        m[,genome_y]
      )

      core <- get_core(
        m[,genome_x],
        m[,genome_y]
      )
      # gather generated results
      get_res_list <- get_res(x, y, core)
      # calculate size of pangenome for first two genomes
      init_pan <- sum(
        get_res_list$genomes_core,
        get_res_list$genome_X,
        get_res_list$genome_Y)

      accumulation_vec[2] <- init_pan

      # remove positive clusters for already used genomes from 0/1 matrix
      m <- dplyr::filter(m, m[,genome_x] != 1 & m[,genome_y] != 1)
    }
    # proceed with remaining genome
    if (!first_round){
      current_pan <- init_pan
      # get names of genomes that are left
      #remaining_genomes <- names(comb[3:length(comb)])
      remaining_genomes <- comb[3:length(comb)]
      print(remaining_genomes)
      # for every genome that is left
      for (j in seq_along(remaining_genomes)){
        count <- count + 1

        # current genome to be added to pangenome
        print(comb[[remaining_genomes[j]]])
        next_genome <- comb[remaining_genomes[j]]

        # number of new clusters
        new_genes <- nrow(
          dplyr::filter(
            m,
            m[,next_genome] == 1)
        )

        # remove positive clusters for already used genomes from 0/1 matrix
        m <- dplyr::filter(
          m,
          m[,next_genome] != 1)

        # update pangenome
        current_pan <- current_pan + new_genes

        # update output vector
        accumulation_vec[j+2] <- current_pan
      }
    }
  }
  accumulation_vec
}
