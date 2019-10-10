#install.packages("xlsx",repos="http://cran.rstudio.com/")
#install.packages("igraph",repos="http://cran.rstudio.com/")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("RBGL")
BiocManager::install("nethet")


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
library(reshape2)


# PREG BMI2_3 BREAKFAST NETWORK
mydata <- read.sas7bdat("C:/Users/schwedhelmramc2/Documents/PEAS data_M1/PREG/SAS/preg_bmi2_3_occ1.sas7bdat")

nphuge<-huge.npn(mydata, npn.func = "skeptic", npn.thresh = NULL, verbose = TRUE)
res.lasso.m<-glasso(nphuge,rho=0.1607027 )
AM <- res.lasso.m$wi != 0
diag(AM) <- F
g.lasso.m.ug <- as(AM, "graphNEL")
nodes(g.lasso.m.ug)<-names(mydata)  
glmat.m<-as(g.lasso.m.ug,"matrix")
corrmat.m<-(glmat.m*nphuge)
iglmat.m<-as(glmat.m,"igraph")

# LOUVAIN
    # introducing edge weights
iglmat.m0<-as(corrmat.m,"igraph")
iglmat.m0 <- set_edge_attr(iglmat.m, "weight", value=runif(ecount(iglmat.m0)))
E(iglmat.m0)$weight <- runif(ecount(iglmat.m0))
    # get communities
louv <- cluster_louvain(iglmat.m, weights = E(iglmat.m0)$weight)
plot(louv,iglmat.m,vertex.size=2)
modularity(louv)
# Modularity = 0.47
length(louv)
# 6 communities (1 is just soups... so really 5)
print(louv[1])
print(louv[2])
print(louv[3])
print(louv[4])
print(louv[5])
print(louv[6])


# Now compare communities using Linkcomm (communities)
#install.packages("linkcomm", repos="http://cran.rstudio.com/")
library(linkcomm)
corrm <- melt(corrmat.m)
corrm1 <- corrm[!(corrm$value ==0),]
lc <- getLinkCommunities(corrm1) #you get linked communities (WEIGHED)

gnodes1<-getNodesIn(lc, clusterids = 1, type = "names") # you get comminuities
gnodes2<-getNodesIn(lc, clusterids = 2, type = "names") # you get comminuities
gnodes3<-getNodesIn(lc, clusterids = 3, type = "names") # you get comminuities
gnodes4<-getNodesIn(lc, clusterids = 4, type = "names") # you get comminuities
gnodes5<-getNodesIn(lc, clusterids = 5, type = "names") # you get comminuities
gnodes6<-getNodesIn(lc, clusterids = 6, type = "names") # you get comminuities
gnodes7<-getNodesIn(lc, clusterids = 7, type = "names") # you get comminuities
gnodes8<-getNodesIn(lc, clusterids = 8, type = "names") # you get comminuities
gnodes9<-getNodesIn(lc, clusterids = 9, type = "names") # you get comminuities
gnodes10<-getNodesIn(lc, clusterids = 10, type = "names") # you get comminuities
gnodes11<-getNodesIn(lc, clusterids = 11, type = "names") # you get comminuities
gnodes12<-getNodesIn(lc, clusterids = 12, type = "names") # you get comminuities
gnodes1
gnodes2
gnodes3
gnodes4
gnodes5
gnodes6
gnodes7
gnodes8
gnodes9
gnodes10
gnodes11
gnodes12
