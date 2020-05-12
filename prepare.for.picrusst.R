samples <- c("t2codl", "t1codl", "sm1si6", "sm1cec", "sm1cod", "sm1cods", "sm2si6", "sm2cec", "sm2cods", "lf2t1", "lf2t2", "hf1")
OTU.table <- list("ctrlec"="table1_otus.fa",
                  "ctrl"="table2_otus.fa",
                  "t2codl"="table1_otus.fa",
                  "t1codl"="table1_otus.fa",
                  "sm1si6"="table2_otus.fa",
                  "sm1cec"="table2_otus.fa",
                  "sm1cod"="table2_otus.fa",
                  "sm1cods"="table2_otus.fa",
                  "sm2si6"="table2_otus.fa",
                  "sm2cec"="table2_otus.fa",
                  "sm2cods"="table2_otus.fa",
                  "lf2t1"="table3_otus.fa",
                  "lf2t2"="table3_otus.fa",
                  "hf1"="table3_otus.fa")
for (sample.name in samples) {
mapseq <- read.table(paste0("mapsseq-master/otu_tables/", sample.name, "_filtered.csv"), sep = ",", header = TRUE)
row.names(mapseq) <- mapseq$X
basis.mat <- read.table(paste0("./outputs/", sample.name, ".basis.mat.txt"), sep = ",", header = FALSE)
colnames(basis.mat) <- paste0(rep("community_", 10), as.character(1:10))
for (i in 1:dim(basis.mat)[2]) {
  arr <- basis.mat[,i]
  arr.order <- order(arr, decreasing = TRUE)
  top10_threshold<-basis.mat[arr.order[10],i]
  arr[arr < top10_threshold] = 0
  arr = arr / top10_threshold
  basis.mat[, i] = arr
}
basis.mat <- cbind(data.frame(seq=as.array(apply(mapseq, 1, function (x) strsplit(as.character(x[1]), "_")[[1]][1]))), basis.mat)
write.table(basis.mat, paste0("./picrust2-2.3.0-b/mapseq.input/", sample.name, ".basis.mat.tsv"), sep = "\t", row.names = FALSE, quote = FALSE)
}