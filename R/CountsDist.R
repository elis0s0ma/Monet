#' Violin Plot of Gene Counts Above a Threshold in a Seurat Object
#'
#' This function calculates, for each cell in a Seurat object, the number of genes with
#' UMIs (unique molecular identifiers) above a specified threshold, and plots the distribution
#' of these counts as a violin plot grouped by the `orig.ident` metadata column.
#' The resulting plot is a \code{ggplot2} object that can be further customized.
#'
#' @param obj A Seurat object containing RNA assay counts.
#' @param counts Numeric threshold for the minimum UMI counts per gene. Default is 3.
#'
#' @return A \code{ggplot2} violin plot showing the distribution of gene counts per cell above the threshold.
#'
#' @examples
#' \dontrun{
#'   p = CountsDist(seurat_object, counts = 5)
#'   print(p)
#' }
#'
#' @export


CountsDist = function(obj, counts = 3){
  vec = apply(as.data.frame(obj@assays$RNA@counts), 2, FUN = function(x) sum(x >= counts))
  plot_data = obj@meta.data
  plot_data$CountsOverThree = vec
  
  p = ggplot(plot_data, aes(x = orig.ident, y = CountsOverThree)) +
    geom_violin(fill = "#21918c") +
    theme_bw() +
    stat_summary(fun.data = "mean_sdl", geom = "pointrange", color = "#440154") +
    labs(y = paste0("N. of genes with UMIs ≥ ", counts))
  return(p)
}

