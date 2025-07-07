#' Plot Explained Variance of Principal Components from a Seurat object
#'
#' This function plots the proportion of variance explained by the top `dim` principal components
#' from a Seurat object's PCA reduction.
#'
#' @param obj A Seurat object that contains a PCA reduction (created with \code{RunPCA}).
#' @param dim An integer indicating how many top principal components to plot.
#'
#' @return A \code{ggplot2} object showing a barplot of explained variance per component.
#'
#' @details The function computes the variance explained by each principal component using the standard deviation
#' values stored in \code{obj@reductions$pca@stdev}, then plots the first \code{dim} components.
#' Default `dim` is 10.
#'
#' @examples
#' \dontrun{
#'   PlotPCA(seurat_object, dim = 10)
#' }
#'
#' @export


PlotPCA =
  function(obj, dim = 10){
    pca_VE = obj@reductions$pca@stdev^2/sum(CGsc@reductions$pca@stdev^2)
    PCAdf = data.frame( PC = paste0("PC", 1:dim),
                        Variance = pca_VE[1:dim])
    PCAdf$PC = factor(PCAdf$PC, levels = paste0("PC", 1:dim))

    ggplot(PCAdf, aes(x = PC, y = Variance, fill = PC)) +
      geom_bar(stat = "identity") +
      theme_bw() +
      labs(y = "Explained Variance", x = "Principal Component") +
      ggtitle(paste0("Top ",dim," PCA Components")) +
      scale_fill_viridis_d(option = "D") +
      guides(fill = "none")
  }


