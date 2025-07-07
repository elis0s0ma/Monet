#' Remove Mitochondrial and/or Ribosomal Genes from a Seurat object or a Gene Expression Matrix
#'
#' This function removes mitochondrial and/or ribosomal genes from a gene expression matrix or Seurat object,
#' based on standard gene name prefixes (e.g., "MT-" for mitochondrial, "RPS"/"RPL"/"RPSA" for ribosomal).
#'
#' @param obj A gene expression matrix (e.g., \code{Seurat::GetAssayData(seurat_object, slot = "counts")})
#'            or any matrix-like object with gene names as rownames or a Seurat object.
#' @param feature A character string indicating which features to remove.
#'        Must be one of: \code{"mito"}, \code{"ribo"}, or \code{"both"}.
#'
#' @return A matrix or Seurat object with the specified feature rows removed.
#'
#' @examples
#' \dontrun{
#'   mat_clean = ReMove(seurat_object@assays$RNA@counts, feature = "mito")
#'   seurat_object = ReMove(seurat_object, feature = "both")
#' }
#'
#' @export



ReMove <- function(obj, feature) {
  valid_features = c("mito", "ribo", "both")
  if (!feature %in% valid_features) {
    stop("Feature must be one of 'mito', 'ribo', or 'both'")
  }
  if (feature == "mito") {
    mito = grep("^MT-", rownames(obj))
    obj = obj[-mito, ]
  } else if (feature == "ribo") {
    ribo = grep("^RP[SL][[:digit:]]|^RP[[:digit:]]|^RPSA", rownames(obj))
    obj = obj[-ribo, ]
  } else if (feature == "both") {
    mito = grep("^MT-", rownames(obj))
    ribo = grep("^RP[SL][[:digit:]]|^RP[[:digit:]]|^RPSA", rownames(obj))
    obj = obj[-c(mito, ribo), ]
  }
  return(obj)
}


