#' Barplot of Mitochondrial and/or Ribosomal Genes in a Seurat Gene Set
#'
#' This function identifies mitochondrial and/or ribosomal genes within a gene expression matrix
#' or Seurat assay matrix and visualizes their counts using a barplot.
#' It can be used to assess the presence of these gene categories before filtering.
#' Must be used before ReMove, or number of features found will be 0.
#'
#' @param obj A gene expression matrix or Seurat assay matrix with gene names as rownames.
#' @param feature A character string specifying which genes to plot.
#'        Must be one of \code{"mito"}, \code{"ribo"}, or \code{"both"}.
#'
#' @return A \code{ggplot2} barplot showing the number of mitochondrial and/or ribosomal genes.
#'
#' @examples
#' \dontrun{
#'   PlotMR(seurat_object@assays$RNA@counts, feature = "mito")
#'   PlotMR(seurat_object, feature = "both")
#' }
#'
#' @export


 PlotMR =
  function(obj, feature){
    valid_features <- c("mito", "ribo", "both")
    if (!feature %in% valid_features) {
      stop("Feature must be one of 'mito', 'ribo', or 'both'")
    }

    if (feature == "mito") {
      mito = grep("^MT-", rownames(obj))

      tab = data.frame(
        Category = "Mitochondrial genes",
        Number = length(mito)
      )
      p = ggplot(tab, aes(x = Category, y = Number, fill = Category)) +
        geom_bar(stat = "identity", fill = "#31688e") +
        theme_bw() +
        labs(y = "Number of genes") +
        ggtitle("Mitochondrial Genes\nin gene set")
    } else if(feature == "ribo"){
      ribo = grep(x = rownames(obj), pattern = "^RP[SL][[:digit:]]|^RP[[:digit:]]|^RPSA")

      tab = data.frame(
        Category = "Ribosomal genes",
        Number = length(ribo)
      )

      p = ggplot(tab, aes(x = Category, y = Number, fill = Category)) +
        geom_bar(stat = "identity", fill = c("#31688e")) +
        theme_bw() +
        labs(y = "Number of genes") +
        ggtitle("Ribosomal Genes\n in gene set")
    } else if(feature == "both"){
      mito = grep(x = rownames(obj), pattern = "^MT-")
      ribo = grep(x = rownames(obj), pattern = "^RP[SL][[:digit:]]|^RP[[:digit:]]|^RPSA")

      tab <- data.frame(
        Category = c("Mitochondrial genes", "Ribosomal genes"),
        Number = c(length(mito), length(ribo))
      )
      p = ggplot(tab, aes(x = Category, y = Number, fill = Category)) +
        geom_bar(stat = "identity", fill = c("#31688e", "#a5db36")) +
        theme_bw() +
        labs(y = "Number of genes") +
        ggtitle("Mitochondrial and Ribosomal Genes\n in gene set")
    }

    return(p)
  }


