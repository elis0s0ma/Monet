
# Monet

Monet contains a few handy functions to perform specific
tasks on a Seurat Object. It was specifically created for the UniTO
Programming exam. :)

## Installation

You can install the development version of SeuratFuncional like so:

``` r
if (!require("remotes")) install.packages("remotes") 
remotes::install_github("elis0s0ma/SeuratFuncional")
```

## Examples and Use

Here’s how you’d usually use these functions:

first of all, load the package!

``` r
library(SeuratFuncional)
```

Up with the first function.

### PlotGTF()

*PlotGTF()* can be used to associate gene-type annotations from a .gtf
file to the genes of your Seurat object o Gene Expression Matrix. The
output is a *ggplot2* plot which can be functionalized as usual.

You’d want to use it like this:

``` r
PlotGTF(obj = SeuratObj , gtf = YourGTF.gtf)
```

### TermSelect()

*TermSelect()* can be used to select only genes belonging to a certain
biotype among a Seurat Object or a Gene Expression Matrix. It uses a
.gtf file to look for gene biotypes and returns a matrix or Seurat
object which contains only those genes. *type* must be a charachter.

The use is pretty intuitive - again - but it’s the following:

``` r
TermSelect(obj = SeuratObj, gtf = YourGTF.gtf, type = "protein_coding")
```

### PlotMR()

*PlotMR()* identifies mitochondrial and/or ribosomal genes within a gene
expression matrix or Seurat assay matrix and visualizes their counts
using a *ggplot2* barplot. It can be used to assess the presence of
these gene categories before filtering with *ReMove()*. *feature* must
be one of ‘mito’, ‘ribo’ or ‘both’. hence, the function must be used
before *ReMove()*, or number of features found will be 0.

``` r
PlotMR(obj = SeuratObj, feature = "mito")

PlotMR(SeuratObject@assays$RNA@counts, feature = "both")
```

### ReMove()

*ReMove()* removes mitochondrial and/or ribosomal genes from a Gene
Expression Matrix or Seurat Object. *feature* must be one of: ‘mito’,
‘ribo’ or ‘both’.

Again, pretty straigthforward but:

``` r
mat_clean = ReMove(seurat_object@assays$RNA@counts, feature = "mito")
SeuratObject = ReMove(seurat_object, feature = "both")
```

### CountsDist()

*CountsDist()* is used to calculate, for each cell in a Seurat object,
the number of genes with UMIs (unique molecular identifiers) above a
specified threshold, and plot the distribution of these counts as a
violin plot grouped by the `orig.ident` metadata column.

``` r
p = CountsDist(SeuratObject, counts = 5)
print(p)
```

### PlotPCA()

*PlotPCA()* plots the proportion of variance explained by the top `dim`
principal components from a Seurat object’s PCA reduction. Because of
this, PCA must be performed before running *PlotPCA()*.

You can easily do it in Seurat as follows:

``` r
SeuratObject = RunPCA(SeuratObject, features = VariableFeatures(SeuratObject))

# and then 

PlotPCA(SeuratObject, dim = 10) # 10 is default parameter
```
