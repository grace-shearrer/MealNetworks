#install.packages("xlsx",repos="http://cran.rstudio.com/")
#install.packages("igraph",repos="http://cran.rstudio.com/")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("RBGL")
BiocManager::install("nethet")


#install.packages("corpcor", repos="http://cran.rstudio.com/")
#install.packages("longitudinal", repos="http://cran.rstudio.com/")
#install.packages("fdrtool", repos="http://cran.rstudio.com/")
#install.packages("GeneNet", repos="http://cran.rstudio.com/")
#install.packages("huge", repos="http://cran.rstudio.com/")
#install.packages("reshape", repos="http://cran.rstudio.com/")
#install.packages("glasso", repos="http://cran.rstudio.com/")
#install.packages("sas7bdat", repos="http://cran.rstudio.com/")


library(xlsx)
library(igraph)
library(gRbase)
#library(corpcor)
#library(longitudinal)
#library(fdrtool)
#library(GeneNet)
library(Matrix)
#library(lattice)
library(MASS)
library(huge)
library(RBGL)	
#library(reshape)
library(glasso)
#library(graph)
library(sas7bdat)
library(nethet)


# PREG BMI1 BREAKFAST NETWORK
mydata <- read.sas7bdat("C:/Users/schwedhelmramc2/Documents/PEAS data_M1/PREG/preg_bmi1_occ1.sas7bdat")

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
nphugeL = huge(nphuge,lambda=0.1782347,method = "glasso")
nphugeL
plot (nphugeL)

res.lasso.m<-glasso(nphuge,rho=0.1782347)
AM <- res.lasso.m$wi != 0
diag(AM) <- F
g.lasso.m.ug <- as(AM, "graphNEL")
nodes(g.lasso.m.ug)<-names(mydata)  
glmat.m<-as(g.lasso.m.ug,"matrix")
corrmat.m<-(glmat.m*nphuge)
iglmat.m<-as(glmat.m,"igraph")

mypath <- file.path("P:","Carolina","NIH","Network test","R output","PREG","PREG_BMI1_occ1_optlamb.sif")
postscript(file=mypath, fonts=c("serif", "Palatino")) 

V(iglmat.m)$label.cex <- 0.6
oldMargins<-par("mar")
par(mar=c(20,9,9,9))
par(mar=oldMargins)
plot(iglmat.m,vertex.label.family="serif",edge.label.family="Palatino", edge.width=E(iglmat.m)$weight, vertex.size=4, 
          vertex.label.dist=0.3,vertex.color="green",edge.lty=2,edge.color="black",edge.label.cex=0.5, 
          layout=layout.fruchterman.reingold(iglmat.m, niter=10000))
mtext("PREG_BMI1_occ1_optlamb, area = vcount^2", side=1)
#layout=layout.fruchterman.reingold(iglmat.m, niter=10000, area=30*vcount(iglmat.m)^2))
#mtext("layout.fruchterman.reingold, area = 30 * vcount^2", side=1)

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

write.xlsx(corrmat.m,file="corrm_PREG_BMI1_OCC1.xlsx")
igraphToSif(iglmat.m, "PREG_BMI1_occ1_optlamb.sif", "myLabel")


# PREG BMI2 BREAKFAST NETWORK
mydata <- read.sas7bdat("C:/Users/schwedhelmramc2/Documents/PEAS data_M1/PREG/preg_bmi2_occ1.sas7bdat")
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
nphugeL = huge(nphuge,lambda=0.1606132 ,method = "glasso")
nphugeL
plot (nphugeL)

res.lasso.m<-glasso(nphuge,rho=0.1606132 )
AM <- res.lasso.m$wi != 0
diag(AM) <- F
g.lasso.m.ug <- as(AM, "graphNEL")
nodes(g.lasso.m.ug)<-names(mydata)  
glmat.m<-as(g.lasso.m.ug,"matrix")
corrmat.m<-(glmat.m*nphuge)
iglmat.m<-as(glmat.m,"igraph")

mypath <- file.path("P:","Carolina","NIH","Network test","R output","PREG","PREG_BMI2_occ1_optlamb.sif")
postscript(file=mypath, fonts=c("serif", "Palatino")) 

V(iglmat.m)$label.cex <- 0.6
oldMargins<-par("mar")
par(mar=c(20,9,9,9))
par(mar=oldMargins)
plot(iglmat.m,vertex.label.family="serif",edge.label.family="Palatino", edge.width=E(iglmat.m)$weight, vertex.size=4, 
     vertex.label.dist=0.3,vertex.color="green",edge.lty=2,edge.color="black",edge.label.cex=0.5, 
     layout=layout.fruchterman.reingold(iglmat.m, niter=10000))
mtext("PREG_BMI2_occ1_optlamb, area = vcount^2", side=1)
#layout=layout.fruchterman.reingold(iglmat.m, niter=10000, area=30*vcount(iglmat.m)^2))
#mtext("layout.fruchterman.reingold, area = 30 * vcount^2", side=1)

write.xlsx(corrmat.m,file="corrm_PREG_BMI2_OCC1.xlsx")
igraphToSif(iglmat.m, "PREG_BMI2_occ1_optlamb.sif", "myLabel")


# PREG BMI3 BREAKFAST NETWORK
mydata <- read.sas7bdat("C:/Users/schwedhelmramc2/Documents/PEAS data_M1/PREG/preg_bmi3_occ1.sas7bdat")
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
nphugeL = huge(nphuge,lambda=0.1698572,method = "glasso")
nphugeL
plot (nphugeL)

res.lasso.m<-glasso(nphuge,rho=0.1698572)
AM <- res.lasso.m$wi != 0
diag(AM) <- F
g.lasso.m.ug <- as(AM, "graphNEL")
nodes(g.lasso.m.ug)<-names(mydata)  
glmat.m<-as(g.lasso.m.ug,"matrix")
corrmat.m<-(glmat.m*nphuge)
iglmat.m<-as(glmat.m,"igraph")

class(corrmat.m)
class(iglmat.m)
# yes <- melt(corrmat.m)
# as.matrix(yes)
# write.table(yes,file="yes.txt")
# write.xlsx(corrmat.m,file="corrm.xlsx")

mypath <- file.path("P:","Carolina","NIH","Network test","R output","PREG","PREG_BMI3_occ1_optlamb.eps", sep = "")
postscript(file=mypath, fonts=c("serif", "Palatino")) 

oldMargins<-par("mar")
par(mar=c(20,9,9,9))
par(mar=oldMargins)
plot(iglmat.m,vertex.label.family="serif",edge.label.family="Palatino", edge.width=E(iglmat.m)$weight, vertex.size=4, 
     vertex.label.dist=0.3,vertex.color="green",edge.lty=2,edge.color="black",edge.label.cex=0.5, 
     layout=layout.fruchterman.reingold(iglmat.m, niter=10000))
mtext("PREG_BMI3_occ1_optlamb, area = vcount^2", side=1)

dev.off()

write.xlsx(corrmat.m,file="corrm_PREG_BMI3_OCC1.xlsx")
igraphToSif(iglmat.m, "PREG_BMI3_occ1_optlamb.sif", "myLabel")


# PREG BMI1 LUNCH NETWORK
mydata <- read.sas7bdat("C:/Users/schwedhelmramc2/Documents/PEAS data_M1/PREG/preg_bmi1_occ3.sas7bdat")
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
nphugeL = huge(nphuge,lambda=0.1912979,method = "glasso")
nphugeL
plot (nphugeL)

res.lasso.m<-glasso(nphuge,rho=0.1912979)
AM <- res.lasso.m$wi != 0
diag(AM) <- F
g.lasso.m.ug <- as(AM, "graphNEL")
nodes(g.lasso.m.ug)<-names(mydata)  
glmat.m<-as(g.lasso.m.ug,"matrix")
corrmat.m<-(glmat.m*nphuge)
iglmat.m<-as(glmat.m,"igraph")

write.xlsx(corrmat.m,file="corrm_PREG_BMI1_OCC3.xlsx")
igraphToSif(iglmat.m, "PREG_BMI1_occ3_optlamb.sif", "myLabel")


# PREG BMI2 LUNCH NETWORK
mydata <- read.sas7bdat("C:/Users/schwedhelmramc2/Documents/PEAS data_M1/PREG/preg_bmi2_occ3.sas7bdat")
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
nphugeL = huge(nphuge,lambda=0.1394935,method = "glasso")
nphugeL
plot (nphugeL)

res.lasso.m<-glasso(nphuge,rho=0.1394935)
AM <- res.lasso.m$wi != 0
diag(AM) <- F
g.lasso.m.ug <- as(AM, "graphNEL")
nodes(g.lasso.m.ug)<-names(mydata)  
glmat.m<-as(g.lasso.m.ug,"matrix")
corrmat.m<-(glmat.m*nphuge)
iglmat.m<-as(glmat.m,"igraph")

write.xlsx(corrmat.m,file="corrm_PREG_BMI2_OCC3.xlsx")
igraphToSif(iglmat.m, "PREG_BMI2_occ3_optlamb.sif", "myLabel")


# PREG BMI3 LUNCH NETWORK
mydata <- read.sas7bdat("C:/Users/schwedhelmramc2/Documents/PEAS data_M1/PREG/preg_bmi3_occ3.sas7bdat")
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
nphugeL = huge(nphuge,lambda=0.1343827,method = "glasso")
nphugeL
plot (nphugeL)

res.lasso.m<-glasso(nphuge,rho=0.1343827)
AM <- res.lasso.m$wi != 0
diag(AM) <- F
g.lasso.m.ug <- as(AM, "graphNEL")
nodes(g.lasso.m.ug)<-names(mydata)  
glmat.m<-as(g.lasso.m.ug,"matrix")
corrmat.m<-(glmat.m*nphuge)
iglmat.m<-as(glmat.m,"igraph")

write.xlsx(corrmat.m,file="corrm_PREG_BMI3_OCC3.xlsx")
igraphToSif(iglmat.m, "PREG_BMI3_occ3_optlamb.sif", "myLabel")


# PREG BMI1 DINNER NETWORK
mydata <- read.sas7bdat("C:/Users/schwedhelmramc2/Documents/PEAS data_M1/PREG/preg_bmi1_occ4.sas7bdat")
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
nphugeL = huge(nphuge,lambda=0.1319679,method = "glasso")
nphugeL
plot (nphugeL)

res.lasso.m<-glasso(nphuge,rho=0.1319679)
AM <- res.lasso.m$wi != 0
diag(AM) <- F
g.lasso.m.ug <- as(AM, "graphNEL")
nodes(g.lasso.m.ug)<-names(mydata)  
glmat.m<-as(g.lasso.m.ug,"matrix")
corrmat.m<-(glmat.m*nphuge)
iglmat.m<-as(glmat.m,"igraph")

write.xlsx(corrmat.m,file="corrm_PREG_BMI1_OCC4.xlsx")
igraphToSif(iglmat.m, "PREG_BMI1_occ4_optlamb.sif", "myLabel")


# PREG BMI2 DINNER NETWORK
mydata <- read.sas7bdat("C:/Users/schwedhelmramc2/Documents/PEAS data_M1/PREG/preg_bmi2_occ4.sas7bdat")
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
nphugeL = huge(nphuge,lambda=0.1558599,method = "glasso")
nphugeL
plot (nphugeL)

res.lasso.m<-glasso(nphuge,rho=0.1558599)
AM <- res.lasso.m$wi != 0
diag(AM) <- F
g.lasso.m.ug <- as(AM, "graphNEL")
nodes(g.lasso.m.ug)<-names(mydata)  
glmat.m<-as(g.lasso.m.ug,"matrix")
corrmat.m<-(glmat.m*nphuge)
iglmat.m<-as(glmat.m,"igraph")

write.xlsx(corrmat.m,file="corrm_PREG_BMI2_OCC4.xlsx")
igraphToSif(iglmat.m, "PREG_BMI2_occ4_optlamb.sif", "myLabel")


# PREG BMI3 DINNER NETWORK
mydata <- read.sas7bdat("C:/Users/schwedhelmramc2/Documents/PEAS data_M1/PREG/preg_bmi3_occ4.sas7bdat")
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
nphugeL = huge(nphuge,lambda=0.1662312,method = "glasso")
nphugeL
plot (nphugeL)

res.lasso.m<-glasso(nphuge,rho=0.1662312)
AM <- res.lasso.m$wi != 0
diag(AM) <- F
g.lasso.m.ug <- as(AM, "graphNEL")
nodes(g.lasso.m.ug)<-names(mydata)  
glmat.m<-as(g.lasso.m.ug,"matrix")
corrmat.m<-(glmat.m*nphuge)
iglmat.m<-as(glmat.m,"igraph")

write.xlsx(corrmat.m,file="corrm_PREG_BMI3_OCC4.xlsx")
igraphToSif(iglmat.m, "PREG_BMI3_occ4_optlamb.sif", "myLabel")