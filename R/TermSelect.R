#' Select Genes by Biotype from a GTF Annotation matching a Seurat object expression or Expression Matrix
#'
#' This function filters gene annotations from a GTF-like data frame to select
#' only genes of a specified biotype present in a given Seurat object or gene expression matrix.
#'
#' @param obj A gene expression matrix with gene names as rownames or Seurat object.
#' @param gtf A data frame representing gene annotations (e.g., parsed GTF),
#'            containing gene names and gene biotype columns.
#' @param type A character string specifying the gene biotype to select (e.g., "protein_coding").
#'
#' @return A data frame or Seurat object containing gene names and biotypes filtered by the specified biotype also contained in the Seurat object or matrix.
#'
#' @examples
#' \dontrun{
#'   pc_genes <- TermSelect(seurat_object@assays$RNA@counts, gtf_annotation_df, "protein_coding")
#'   lnc_genes <- TermSelect(seurat_object, gtf_annotation_df, "LNC")
#' }
#'
#' @export

TermSelect =
function(obj, gtf, type){
  name_pos = grep(colnames(gtf), pattern = "(?=.*gene)(?=.*name)", perl = T, ignore.case = T)
  bio_pos = grep(colnames(gtf), pattern = "(?=.*gene)(?=.*biotype)", perl = T, ignore.case = T)
  filtGTF = na.omit(gtf[,name_pos] %in% rownames(obj), c(name_pos, bio_pos)])
  colnames(filtGTF) = c("gene_name", "gene_biotype")
  filtGTF = filtGTF[!duplicated(filtGTF$gene_name), ]
  PC_GTF = filtGTF[which(filtGTF$gene_biotype == type), ]

  return(PC_GTF)
}



