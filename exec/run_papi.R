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

# read file into R as a character vector
clstr_file <- readLines(clstr_file)

# cluster_prot_list saved into data folder as takes some time to compute
cluster_prot_list <- gather_clusters(clstr_file)

# clean cluster names
clstr_names <- names(PAPi::clstr_prot_list)
clstr_names <- stringr::str_extract(clstr_names, "(?<=>).+")
clstr_prot_list <- purrr::set_names(PAPi::clstr_prot_list, clstr_names)

#clean cluster details

reference_proteins <- map(clstr_prot_list, find_ref_prot)
ref_prot_details <- map(reference_proteins,
                        get_ref_prot_details,
                        genomes = faa_file_trimmed_names)

x <- clstr_prot_list[c("Cluster 999", "Cluster 800", "Cluster 10000")]
y <- reference_proteins[c("Cluster 999", "Cluster 800", "Cluster 10000")]

x <- clstr_prot_list["Cluster 999"]
y <- reference_proteins["Cluster 999"]

# compact removes empty elements
not_ref_prots <- remove_ref_prot(clstr_prot_list, reference_proteins) %>% compact()
not_ref_prots[11]
get_prot_details(not_ref_prots[11], faa_file_trimmed_names)
