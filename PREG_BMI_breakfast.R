#install.packages("xlsx",repos="http://cran.rstudio.com/")
#install.packages("igraph",repos="http://cran.rstudio.com/")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("RBGL")
BiocManager::install("nethet")

#install.packages("NetworkToolbox", repos="http://cran.rstudio.com/")
#install.packages("huge", repos="http://cran.rstudio.com/")
#install.packages("glasso", repos="http://cran.rstudio.com/")
#install.packages("sas7bdat", repos="http://cran.rstudio.com/")


library(xlsx)
library(igraph)
library(gRbase)
library(NetworkToolbox)
library(Matrix)
library(MASS)
library(huge)
library(RBGL)	
library(glasso)
library(sas7bdat)
library(nethet)

# code to export igraph to sif file, run once
igraphToSif <- function(inGraph, outfile="output.sif", edgeLabel="label") {
  
  sink(outfile)
  
  singletons <- as.list(get.vertex.attribute(inGraph, "name"))
  edgeList <- get.edgelist(inGraph, names=FALSE)
  nodeNames <- get.vertex.attribute(inGraph, "name")
  numE <- ecount(inGraph)
  
  for (i in 1:numE) {
    node1 <- edgeList[i,1]
    node2 <- edgeList[i,2]
    singletons <- singletons[which(singletons != nodeNames[node1])]
    singletons <- singletons[which(singletons != nodeNames[node2])]
    cat(nodeNames[node1], "\t", edgeLabel, "\t", nodeNames[node2], "\n")
  }
  
  for (single in singletons) {
    cat(single, "\n")
  }
  
  sink()
}


################################################################

# PREG BMI1 BREAKFAST NETWORK
mydata <- read.sas7bdat("C:/Users/schwedhelmramc2/Documents/PEAS data_M1/PREG/SAS/preg_bmi1_occ1.sas7bdat")

#skeptic transformation - correlation matrix
nphuge<-huge.npn(mydata, npn.func = "skeptic", npn.thresh = NULL, verbose = TRUE)

nphugeL = huge(nphuge,lambda=,method = "glasso")
nphugeL
plot(nphugeL)

# 10-fold cross validation glasso
res<-screen_cv.glasso(nphuge, include.mean = FALSE, folds = 10,length.lambda = 20,
                      lambdamin.ratio = ifelse(ncol(nphuge) > nrow(nphuge), 0.01, 0.001),
                      trunc.method = "linear.growth", trunc.k = 5,
                      plot.it = TRUE, se = TRUE, use.package = "glasso",
                      verbose = TRUE)

# network creation with optimal lambda 
nphugeL = huge(nphuge,lambda=0.1761061,method = "glasso")
nphugeL
plot (nphugeL)

res.lasso.m<-glasso(nphuge,rho=0.1761061)
AM <- res.lasso.m$wi != 0
diag(AM) <- F
g.lasso.m.ug <- as(AM, "graphNEL")
nodes(g.lasso.m.ug)<-names(mydata)  
glmat.m<-as(g.lasso.m.ug,"matrix")
corrmat.m<-(glmat.m*nphuge)
iglmat.m<-as(glmat.m,"igraph")

# export igraph to sif 
igraphToSif(iglmat.m, "PREG_BMI1_occ1_optlamb.sif", "and")

# edge weights
corrm <- melt(corrmat.m)
corrm1 <- corrm[!(corrm$value ==0),]write.csv(corrm1,file="edgeW_PREG_BMI1_OCC1.csv")
write.csv(corrm1,file="edgeW_PREG_BMI1_OCC1.csv")
# cv regularized correlation matrix
write.csv(corrmat.m,file="corrm_PREG_BMI1_OCC1.csv")

# node weights
freq_nodes <- read.sas7bdat("C:/Users/schwedhelmramc2/Documents/PEAS data_M1/PREG/preg_bmi1_occ1_freq.sas7bdat")
write.csv(freq_nodes,file="freq_PREG_BMI1_OCC1.csv")


##########################################################


# PREG BMI2_3 BREAKFAST NETWORK
mydata <- read.sas7bdat("C:/Users/schwedhelmramc2/Documents/PEAS data_M1/PREG/SAS/preg_bmi2_3_occ1.sas7bdat")
#skeptic transformation - correlation matrix
nphuge<-huge.npn(mydata, npn.func = "skeptic", npn.thresh = NULL, verbose = TRUE)

nphugeL = huge(nphuge,lambda=,method = "glasso")
nphugeL
plot(nphugeL)

# 10-fold cross validation glasso
res<-screen_cv.glasso(nphuge, include.mean = FALSE, folds = 10,length.lambda = 20,
                      lambdamin.ratio = ifelse(ncol(nphuge) > nrow(nphuge), 0.01, 0.001),
                      trunc.method = "linear.growth", trunc.k = 5,
                      plot.it = TRUE, se = TRUE, use.package = "glasso",
                      verbose = TRUE)

# network creation with optimal lambda 
nphugeL = huge(nphuge,lambda=0.1607027 ,method = "glasso")
nphugeL
plot (nphugeL)

res.lasso.m<-glasso(nphuge,rho=0.1607027 )
AM <- res.lasso.m$wi != 0
diag(AM) <- F
g.lasso.m.ug <- as(AM, "graphNEL")
nodes(g.lasso.m.ug)<-names(mydata)  
glmat.m<-as(g.lasso.m.ug,"matrix")
corrmat.m<-(glmat.m*nphuge)
iglmat.m<-as(glmat.m,"igraph")

# export igraph to sif 
igraphToSif(iglmat.m, "PREG_BMI2_3_occ1_optlamb_edge.sif", "and")

# edge weights
corrm <- melt(corrmat.m)
corrm1 <- corrm[!(corrm$value ==0),]
write.csv(corrm1,file="edgeW_PREG_BMI2_3_OCC1.csv")
# cv regularized correlation matrix
write.csv(corrmat.m,file="corrm_PREG_BMI2_3_OCC1.csv")

# node weights
freq_nodes <- read.sas7bdat("C:/Users/schwedhelmramc2/Documents/PEAS data_M1/PREG/preg_bmi2_3_occ1_freq.sas7bdat")
write.csv(freq_nodes,file="freq_PREG_BMI2_3_OCC1.csv")
