#' Plot accumulation plot
#' Prot accumulation plot for core pangenome based on median and IQR
#' @param sum_df_median summarized table
#' @import ggplot2
#' @export 
plot_median_IQR <- function(sum_df_median){
  plt <- ggplot(
    data = sum_df_median,
    mapping = aes(
      x= CombID, 
      y = median,
      fill = as.factor(no)
    )) +
    geom_point(
      alpha = 0.5,
      size = 7, 
      shape = 23) +
    geom_errorbar(
      aes(
        ymax = median + IQR,
        ymin = median - IQR),
      position = "dodge", 
      na.rm = TRUE) +
    theme_light(base_size=19) +
    theme(
      axis.text.x = element_text(
        size = 20, 
        color = "black",
        face = "bold"),
      legend.title = element_text(
        size = 20,
        color = "black",
        face = "bold"),
      legend.text = element_text(
        size = 20,
        color = "black",
        face = "bold"),
      legend.text.align = 1,
      legend.position = c(0.8, 0.8)) +
    labs(
      x="Number of genomes",
      y="Median size of core pangenome",
      #legend title
      fill = "Median based on\nnumber of permutations:") +
    geom_line(
      aes(group=1),
      size = 1.05) +
    ylim(500, 3000)
  
  plt
}