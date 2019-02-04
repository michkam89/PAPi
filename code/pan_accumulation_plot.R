#options(stringsAsFactors = FALSE)
devtools::load_all("./code/papiTemp")
library(readr)
library(dplyr)
library(ggplot2)
library(gtools)
# input directory
mypath <- "tmp"
# output
output <- "plots"
# read data
df <- readr::read_delim(
  file = paste0(mypath, "/input_for_accumulation.tsv"),
  delim = "\t",
  col_names = FALSE)

# ACTUAL FORMATING
my_bool_matrix <- format_data(df)
iterations <- 10L

my_df <- matrix_to_df(my_bool_matrix, times = iterations)

out <- merge_iterations(m = my_bool_matrix,
                        comb = my_df[1:iterations])

out_df <- tidy_merged_iterations(out)

# Publication accumulation pangenome boxplot
pan_boxplt <- plot_pangenome_boxplt(out_df)

png(paste0(
  output,
  "/pan_accumulation_boxplot.png"),
  width = 1500,
  height = 1000)
plot(pan_boxplt)
dev.off()
