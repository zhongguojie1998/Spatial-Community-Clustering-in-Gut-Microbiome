library(dplyr)
library(stringr)
library(ggplot2)

mapseq.files <- list.files(path = "mapsseq-master/otu_tables/", pattern = '*_filtered.csv$')
for (file in mapseq.files) {
  mapseq <- read.table(paste0("mapsseq-master/otu_tables/", file), sep = ",", header = TRUE)
  sample.name <- strsplit(file, "_")[[1]][1]
  row.names(mapseq) <- mapseq$X
  mapseq <- mapseq[,2:dim(mapseq)[2]]
  basis.mat <- read.table(paste0("./outputs/", sample.name, ".basis.mat.txt"), sep = ",", header = FALSE)
  row.names(basis.mat) <- row.names(mapseq)
  coef.mat <- read.table(paste0("./outputs/", sample.name, ".coef.mat.txt"), sep = ",", header = FALSE)
  colnames(coef.mat) <- colnames(mapseq)
  
  bimapseq <- ifelse(mapseq > 0,1,0)
  basis.mat <- as.matrix(basis.mat)
  coef.mat <- as.matrix(coef.mat)
  
  predictseq <- as.matrix(basis.mat)%*%as.matrix(coef.mat)
  colnames(predictseq) <- colnames(mapseq)
  row.names(predictseq) <- row.names(mapseq)
  dir.create(paste0("bernoulli.mf.plots/", sample.name))
  pdf(paste0("bernoulli.mf.plots/", sample.name, "/bi.basis.mat.heatmap.pdf"), width = 16, height = 12)
  heatmap(as.matrix(basis.mat), scale = "none", Colv = NA, Rowv = NA)
  dev.off()
  pdf(paste0("bernoulli.mf.plots/", sample.name, "/bi.coef.mat.heatmap.pdf"), width = 12, height = 12)
  heatmap(as.matrix(coef.mat), scale = "none")
  dev.off()
  pdf(paste0("bernoulli.mf.plots/", sample.name, "/bi.coef.mat.no.cluster.heatmap.pdf"), width = 12, height = 12)
  coef.mat.ordered = coef.mat[,order(colnames(coef.mat))]
  heatmap(as.matrix(coef.mat), scale = "none", Colv = NA, Rowv = NA)
  dev.off()
  pdf(paste0("bernoulli.mf.plots/", sample.name, "/bi.profile.mat.heatmap.pdf"), width = 16, height = 12)
  heatmap(as.matrix(bimapseq), scale = "none", Colv = NA, Rowv = NA)
  dev.off()
  pdf(paste0("bernoulli.mf.plots/", sample.name, "/bi.predict.mat.heatmap.pdf"), width = 16, height = 12)
  heatmap(predictseq, scale = "none", Colv = NA, Rowv = NA)
  dev.off()

  for (i in 1:dim(basis.mat)[2]) {
    arr <- basis.mat[,i]
    arr.order <- order(arr, decreasing = TRUE)
    top10<-basis.mat[c(arr.order[1:10]),i]
    top10<-as.data.frame(top10)
    top10$family<-factor(row.names(top10),levels=rev(row.names(top10)))
    ggplot(top10,aes(x=family,y=top10))+
      geom_bar(stat="identity",color="blue", fill="white", width = 0.5)+
      coord_flip()+
      theme_classic()+
      labs(y="composition", x = "otus")+
      theme_classic(base_size = 20) # big, big text
    ggsave(filename = paste0("bernoulli.mf.plots/", sample.name, "/community.", as.character(i), ".top10.pdf"))
  }
}

a <- matrix(runif(100), nrow = 10, ncol = 10)
a[a<=0.5] = 0
pdf(paste0("bernoulli.mf.plots/example.heatmap.pdf"), width = 12, height = 12)
heatmap(a, scale = "none", Colv = NA, Rowv = NA)
dev.off()
a[a>0]=1
pdf(paste0("bernoulli.mf.plots/example.bi.heatmap.pdf"), width = 12, height = 12)
heatmap(a, scale = "none", Colv = NA, Rowv = NA)
dev.off()
