library(readxl)
library("gplots")
NPL <- read_excel("your xlsx file directory")
NpLmat<-data.matrix(NPL[,])
NPL.group <- factor(paste(NPL$"group"))
rownames(NPLmat)<-paste(NPL$"label")
colfunc<-colorRampPalette(c("blue","white","red"))
hv<-heatmap.2(GDmat, Colv = FALSE, Rowv = TRUE, dendrogram = c("row"), labCol = FALSE, 
              cexRow = .5, key = TRUE, hclustfun = function(x) hclust(x,method = "ward.D2"), 
              trace = "none",scale = c("none"), breaks = seq(0,0.1,0.001), 
              col = colfunc(100)[c(seq(1,5,length.out=5),seq(5,100,length.out=95))])
#,RowSideColors = as.character(as.numeric(NPL.group))) for color coded groups