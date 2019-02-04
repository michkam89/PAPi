#' function plotting publication core pangenome plot
#' @param df_clean clean data.frame
#' @import ggplot2
plot_core_boxplot <- function(df_clean){
  boxplt_core <- ggplot(
    data = df_clean,
    mapping = aes(
      x= as.factor(CombID),
      y = Count,
      group=CombID)) +
  geom_boxplot(outlier.alpha = .005)

boxplt_core_line <- boxplt_core + 
  geom_line(
    data = df_clean_sum_median,
    aes(x = CombID,
        y=median,
        group = 1),
    size = 1.01,
    color = "red",
    alpha = 0.5) +
  labs(
    y = "Core pangenome size",
    x = "Number of genomes") +
  theme_light(base_size = 19) +
  ylim(0,NA)

boxplt_core_line
}