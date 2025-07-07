






    vec = apply(as.data.frame(obj@assays$RNA@counts), 2, FUN = function(x) sum(x >= counts))
    obj@meta.data$CountsOverThree = vec
