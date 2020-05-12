library(ggplot2)
samples <- c("t2codl", "t1codl", "sm1si6", "sm1cec", "sm1cod", "sm1cods", "sm2si6", "sm2cec", "sm2cods", "lf2t1", "lf2t2", "hf1")
for (sample.name in samples) {
pathway.mat <- read.table(gzfile(paste0("./picrust2-2.3.0-b/", sample.name, ".out/KO_metagenome_out/pred_metagenome_unstrat.tsv.gz")), header = TRUE)
dir.create("metagenome.plots/")
row.names(pathway.mat) <- pathway.mat$function.
pathway.mat$function. = c()
pathway.mat <- as.matrix(pathway.mat)
for (i in 1:dim(pathway.mat)[2]) {
  arr <- pathway.mat[,i]
  arr.order <- order(arr, decreasing = TRUE)
  top10<-pathway.mat[c(arr.order[1:10]),i]
  top10<-as.data.frame(top10)
  top10$family<-factor(row.names(top10),levels=rev(row.names(top10)))
  ggplot(top10,aes(x=family,y=top10))+
    geom_bar(stat="identity",color="blue", fill="white", width = 0.5)+
    coord_flip()+
    theme_classic()+
    labs(y="scores", x = "pathways")+
    theme_classic(base_size = 20) # big, big text
  dir.create(paste0("metagenome.plots/", sample.name))
  ggsave(filename = paste0("metagenome.plots/", sample.name, "/community.", as.character(i), ".top10.pathways.pdf"))
}
}