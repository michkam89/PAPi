#' plotting accumulation plot for pangenome
#' @param out_df final data.frame
plot_pangenome_boxplt <- function(out_df){

  out_summary <- out_df %>%
    group_by(N_genomes) %>%
    summarise(mean = mean(pangenome_size),
              sd = sd(pangenome_size),
              median = median(pangenome_size),
              IQR = IQR(pangenome_size, na.rm = TRUE))

  boxplt <- ggplot(
    out_df,
    aes(
      x = N_genomes,
      y = pangenome_size)) +
  geom_boxplot(outlier.alpha = .005)

  boxplt_line <- boxplt +
    geom_line(
      data = out_summary,
      aes(x = N_genomes,
          y = median,
          group = 1),
      size = 1.01,
      color = "red",
      alpha = 0.5) +
    labs(
      x = "Number of genomes",
      y = " Pangenome size") +
    theme_light(base_size=19) +
    ylim(0,NA)

  boxplt_line
}
