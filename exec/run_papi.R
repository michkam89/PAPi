# R script wrapper of PAPi analysis

clstr_fdir <- "./data/sph_pan_cdhit_output.clstr"

# read file into R as a list of lines
clstr_file <- readLines(clstr_fdir)

# cluster_prot_list saved into data folder as takes some time to compute
cluster_prot_list <- gather_clusters(clstr_file)
