#' Barplot of Gene Biotype Annotations from a GTF File Matched to a Seurat Object
#'
#' This function filters gene biotype annotations from a GTF-like data frame
#' to include only genes present in the provided gene expression object,
#' then plots the distribution of gene biotypes as a barplot.
#'
#' This function assumes that `obj` contains gene names as rownames.
#'
#' @param obj A gene expression matrix with gene names as rownames or Seurat object.
#' @param gtf A data frame representing gene annotations (e.g., parsed GTF),
#'            which must contain columns with gene names and gene biotypes.
#'
#' @return A \code{ggplot2} barplot showing counts of gene biotypes for genes in \code{obj}.
#'
#' @examples
#' \dontrun{
#'   p = PlotGTF(seurat_object@assays$RNA@counts, gtf_annotation_df)
#'   print(p)
#'
#'   p = PlotGTF(seurat_object, gtf_annotation_df)
#'   print(p)
#' }
#'
#' @export


PlotGTF = function(obj, gtf) {
  name_pos = grep("(?=.*gene)(?=.*name)", colnames(gtf), perl = TRUE, ignore.case = TRUE)
  bio_pos = grep("(?=.*gene)(?=.*biotype)", colnames(gtf), perl = TRUE, ignore.case = TRUE)

  if(length(name_pos) == 0 || length(bio_pos) == 0) {
    stop("Could not find appropriate gene name or gene biotype columns in the gtf data frame.")
  }

  filtGTF = na.omit(gtf[gtf[[name_pos[1]]] %in% rownames(obj), c(name_pos[1], bio_pos[1])])
  colnames(filtGTF) = c("gene_name", "gene_biotype")

  filtGTF = filtGTF[!duplicated(filtGTF$gene_name), ]
  filtGTF$gene_biotype = as.factor(filtGTF$gene_biotype)

  tab = as.data.frame(summary(filtGTF$gene_biotype))
  colnames(tab) = "gene_biotype"

  p = ggplot(data = tab, aes(x = rownames(tab), y = gene_biotype, fill = rownames(tab))) +
    geom_bar(stat = "identity") +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    labs(x = "Biotype", y = "Number of genes", fill = "Annotation") +
    scale_fill_viridis_d(option = "D") +
    ggtitle("Gene Type Annotation")

  return(p)
}



