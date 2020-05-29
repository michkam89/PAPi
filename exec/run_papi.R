library(purrr)
library(stringr)
# R script wrapper of PAPi analysis
faa_fdir <- "./data/sph_faa/"
clstr_file <- "./data/sph_pan_cdhit_output.clstr"

faa_file_names <- detect_faa_files(faa_fdir)

faa_files <- paste0(faa_fdir, faa_file_names)

faa_files <- purrr::map(faa_files, seqinr::read.fasta, seqtype = "AA", as.string = T)
faa_file_trimmed_names <- stringr::str_extract(faa_file_names, ".{1,}(?=\\.faa$)")
faa_files <- purrr::set_names(faa_files, faa_file_trimmed_names)
PAPi::clstr_prot_list
# read file into R as a character vector
clstr_file <- readLines(clstr_file)

# cluster_prot_list saved into data folder as takes some time to compute
cluster_prot_list <- gather_clusters(clstr_file)
# clean cluster names
clstr_names <- names(PAPi::clstr_prot_list)
clstr_names <- stringr::str_extract(clstr_names, "(?<=>).+")
clstr_prot_list <- purrr::set_names(PAPi::clstr_prot_list, clstr_names)
x <- clstr_prot_list["Cluster 999"]
#clean cluster details

reference_proteins <- map(clstr_prot_list, find_ref_prot)
ref_prot_details <- map(reference_proteins,
                        get_ref_prot_details,
                        genomes = faa_file_trimmed_names)


attr(x, "ref_prot_name") <- find_ref_prot()

x <- paste0(faa_fdir, faa_files)
y <- read.fasta(x, seqtype = "AA", as.string = T)
z <- y[1]
attributes(z)
