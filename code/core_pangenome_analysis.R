# Script gathering functions and data formatting and manipulations necessary to 
# plot core pangenome accumulation boxplot based on core_clusters_permutations.py 
# output .csv files

options(stringsAsFactors = FALSE)
devtools::load_all("./code/papiTemp")
library(ggplot2)

# DATA MANIPULATIONS

mypath <- "tmp" #path to core_clusters_permutations.py output
output <- "plots"
df <- multmerge(mypath)
df_clean <- modify_colnames(df)
df_clean <- format_df(df_clean)

df_clean_sum_median <- analyze_median_IQR(df_clean)
df_clean_sum_mean <- analyze_mean_sd(df_clean)

df_clean_sum_median$CombID <- as.numeric(df_clean_sum_median$CombID)
df_clean_sum_mean$CombID <- as.numeric(df_clean_sum_mean$CombID)

#df_clean$Count <- as.character(df_clean$Count)
df_clean$CombID <- as.numeric(df_clean$CombID)

# PUBLICATION CORE ACCUMULATION PANGENOME BOXPLOT
boxplt_core_line <- plot_core_boxplot(df_clean)

png(paste0(
  output,
  "/core_accumulation_boxplot.png"),
  width = 1500,
  height = 1000)
plot(boxplt_core_line)
dev.off()

#DOTPLOTs
medianplt <- plot_median_IQR(df_clean_sum_median)

png(paste0(
  output, 
  "/density_median.png"),
  width = 1500,
  height = 1000)
print(medianplt)
dev.off()

meanplt <- plot_mean_sd(df_clean_sum_mean)
  
png(paste0(
  output, 
  "/density_mean.png"),
  width = 1500,
  height = 1000)
print(meanplt)
dev.off()