set.seed(1234)
par(mar = c(0, 0, 0, 0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))

#Hierarichal clustering: by distances between points
#Pairwise distances, using dist() function
dataFrame <- data.frame(x = x, y = y)
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
plot(hClustering) #points further up get clustered later
#Drawing horizontal line to "cut" the tree will yield the # of groups for # of cut branches
#Hierarchical clustering is the basis of clustering (distance wise, absolute distance)

#Dendograms
myplclust <- function(hclust, lab = hclust$labels, lab.col = rep(1, length(hclust$labels)),
                      hang = 0.1, ...) {
  ## modifiction of plclust for plotting hclust objects *in colour*! Copyright
  ## Eva KF Chan 2009 Arguments: hclust: hclust object lab: a character vector
  ## of labels of the leaves of the tree lab.col: colour for the labels;
  ## NA=default device foreground colour hang: as in hclust & plclust Side
  ## effect: A display of hierarchical cluster with coloured leaf labels.
  y <- rep(hclust$height, 2)
  x <- as.numeric(hclust$merge)
  y <- y[which(x < 0)]
  x <- x[which(x < 0)]
  x <- abs(x)
  y <- y[order(x)]
  x <- x[order(x)]
  plot(hclust, labels = FALSE, hang = hang, ...)
  text(x = x, y = y[hclust$order] - (max(hclust$height) * hang), labels = lab[hclust$order],
       col = lab.col[hclust$order], srt = 90, adj = c(1, 0.5), xpd = NA, ...)
}

dataFrame <- data.frame(x = x, y = y)
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
myplclust(hClustering, lab = rep(1:3, each = 4), lab.col = rep(1:3, each = 4))

#heatmap
dataFrame <- data.frame(x = x, y = y)
set.seed(143)
dataMatrix <- as.matrix(dataFrame)[sample(1:12), ]
heatmap(dataMatrix)
#visualize better
#quickly looking for table/matrix data
#first and foremost: need a merging strategy


####
#K-Means clustering
set.seed(1234)
par(mar = c(0, 0, 0, 0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))

dataFrame <- data.frame(x, y)
kmeansObj <- kmeans(dataFrame, centers = 3)
names(kmeansObj)

kmeansObj$cluster
#labels all set, now to plot

par(mar = rep(0.2, 4))
plot(x, y, col = kmeansObj$cluster, pch = 19, cex = 2)
points(kmeansObj$centers, col = 1:3, pch = 3, cex = 3, lwd = 3)
#"cross" is the centroid of each of the three respective groups

#Heatmaps
set.seed(1234)
dataMatrix <- as.matrix(dataFrame)[sample(1:12), ]
kmeansObj2 <- kmeans(dataMatrix, centers = 3)
par(mfrow = c(1, 2), mar = c(2, 4, 0.1, 0.1))
image(t(dataMatrix)[, nrow(dataMatrix):1], yaxt = "n")
image(t(dataMatrix)[, order(kmeansObj$cluster)], yaxt = "n")
#advice: run kmeans() a few times as the centroid is randomly generated


#############
#Principal Component Analysis (PCA)
set.seed(12345)
par(mar = rep(0.2, 4))
dataMatrix <- matrix(rnorm(400), nrow = 40)
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])

set.seed(678910)
for (i in 1:40) {
  # flip a coin
  coinFlip <- rbinom(1, size = 1, prob = 0.5)
  # if coin is heads add a common pattern to that row
  if (coinFlip) {
    dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0, 3), each = 5)
  }
}
par(mar = rep(0.2, 4))
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])
#obvious split by coin flips

par(mar = rep(0.2, 4))
heatmap(dataMatrix)
#obvious column pattern

hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order, ]
par(mfrow = c(1, 3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(rowMeans(dataMatrixOrdered), 40:1, , xlab = "Row Mean", ylab = "Row", pch = 19)
plot(colMeans(dataMatrixOrdered), xlab = "Column", ylab = "Column Mean", pch = 19)
#2nd: mean for each of the row)
#3rd: 

#sample svd
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1, 3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(svd1$u[, 1], 40:1, , xlab = "Row", ylab = "First left singular vector",pch = 19)
plot(svd1$v[, 1], xlab = "Column", ylab = "First right singular vector", pch = 19)
#see two distinct groups forming more visually after svd()

par(mfrow = c(1, 2))
plot(svd1$d, xlab = "Column", ylab = "Singular value", pch = 19)
plot(svd1$d^2/sum(svd1$d^2), xlab = "Column", ylab = "Prop. of variance explained",pch = 19)
#works similarly to eigenvalues

#Singular values' relationship to principal components
svd1 <- svd(scale(dataMatrixOrdered))
pca1 <- prcomp(dataMatrixOrdered, scale = TRUE)
plot(pca1$rotation[, 1], svd1$v[, 1], pch = 19, xlab = "Principal Component 1",
     ylab = "Right Singular Vector 1")
abline(c(0, 1))

constantMatrix <- dataMatrixOrdered*0
for(i in 1:dim(dataMatrixOrdered)[1]){constantMatrix[i,] <- rep(c(0,1),each=5)}
svd1 <- svd(constantMatrix)
par(mfrow=c(1,3))
image(t(constantMatrix)[,nrow(constantMatrix):1])
plot(svd1$d,xlab="Column",ylab="Singular value",pch=19)
plot(svd1$d^2/sum(svd1$d^2),xlab="Column",ylab="Prop. of variance explained",pch=19)


svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1, 3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(svd1$u[, 1], 40:1, , xlab = "Row", ylab = "First left singular vector", pch = 19)
plot(svd1$v[, 1], xlab = "Column", ylab = "First right singular vector", pch = 19)



###############

svd1 <- svd(scale(dataMatrixOrdered))
#scale centers matrix
#svd computes singular value decomposition of rectangular matrix
#svd1 has d, u, v, and note that u%*%d%*%t(v)
#dd <- svd1$u%*%diag(svd1$d)%*%t(svd1$v)
par(mfrow = c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(svd1$u[,1], xlab = "Row", ylab = 'First left singular vector', pch = 19)
plot(svd1$v[,1], xlab = "Column", ylab = "First right singular vector", pch = 19)


#Variance explained
par(mfrow = c(1,2))
plot(svd1$d, xlab ="Column", ylab = 'Singu;lar value', pch = 19)
plot(svd1$d^2/sum(svd1$d^2), xlab = "Column", ylab = "Prop. of variance explained", pch = 19)
#note, first farleft point explains 40% of the data's variance.
# High variance -> good


#Relationship to Principal Components
svd1 <- svd(scale(dataMatrixOrdered))
pca1 <- prcomp(dataMatrixOrdered, scale = TRUE)
plot(pca1$rotation[,1], svd1$v[,1],pch = 19, xlab = "Principal component 1", ylab = "Right singular Vector 1")
abline(c(0,1))


#part 2
constantMatrix <- dataMatrixOrdered*0
for(i in 1:dim(dataMatrixOrdered)[1]){constantMatrix[i,] <- rep(c(0,1), each = 5)}
svd1 <- svd(constantMatrix)
par(mfrow = c(1,3))
image(t(constantMatrix)[, nrow(constantMatrix):1])
plot(svd1$d, xlb = "Column", ylab = "Singular Value", pch = 19)
plot(svd1$d^2/sum(svd1$d^2), xlab = "Column", ylab = "Proportion of variance explained", pch = 19)
# since constantMatrix's columns are constant, svd1$d values for 2 onwards are very small,
# implying that only the first v column has captures significant variance of data

set.seed(678910)
for(i in 1:40){
 #flip a coin
  coinFlip1 <- rbinom(1, size = 1, prob = 0.5)
  coinFlip2 <- rbinom(1, size = 1, prob = 0.5)
  
  #if coin is heads add a common pattern t that row
  if(coinFlip1){
    dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0,5), each = 5)
  }
  if (coinFlip2){
    dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0,5), 5)
  }
}
#dist is distance matrix computation, compute distances between rows of a data matrix
hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order,]


#True patterns
svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1,3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(rep(c(0,1), each = 5), pch = 19, xlab = "Column", ylab = "Pattern 1")
plot(rep(c(0,1), 5), pch = 19, xlab = "Column", ylab = "Pattern 2")


#v and patterns of variances in rows
svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(svd2$v[, 1], pch = 19, xlab = "Column ", ylab = "First right singular vector")
plot(svd2$v[, 2], pch = 19, xlab = "Column ", ylab = "First right singular vector")

#d anv variance explained
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1, 2))
plot(svd1$d, xlab = "Column", ylab = "Singular Value", pch = 19)
plot(svd1$d^2/sum(svd1$d^2), xlab = "Column", ylab = "Percentage of variance explained", pch = 19)



#Color
install.packages("RColorBrewer")
library("RColorBrewer")
mypalette<-brewer.pal(4,"Blues")
image(1:7,1,as.matrix(1:7),col=mypalette,xlab="Greens (sequential)",
      ylab="",xaxt="n",yaxt="n",bty="n")




#https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#Module4Week4
setwd("D:\\Users\\msboon\\Desktop\\For Data science coursera\\Plots")
rr <- readRDS("D:\\Users\\msboon\\Desktop\\For Data science coursera\\Plots\\exdata%2Fdata%2FNEI_data (1)\\summarySCC_PM25.rds")
ee <- readRDS("D:\\Users\\msboon\\Desktop\\For Data science coursera\\Plots\\exdata%2Fdata%2FNEI_data (1)\\Source_Classification_Code.rds")
ee <- data.frame(ee, stringsAsFactors = FALSE)
#1
str(rr)
table(rr$year)
table(rr$Pollutant)
#want total emission for each of the four years
#thiking: use a bar plot or histogram
#1
#barplot
#manually create
store1 <- matrix(data=0, nrow = 4, ncol = 2); colnames(store1) <- c("Year", "Total PM2.5  emission")

years <- unique(rr$year)
for(i in 1:length(years)){
  store1[i,1] <- years[i]
  store1[i,2] <- sum(rr[which(rr$year==years[i]),4])
}
rownames(store1) <- store1[,1]
png("plot1a.png", width = 500, height = 450)
barplot(store1[,2], main = "Total PM2.5 emissions for four years", col = brewer.pal(4,"Blues"), xlab = "Years", ylab = "Total PM2.5 emission")
dev.off()
#2
#fips=="24510"
#use which() to single out just Maryland
rrM <- rr[which(rr$fips=="24510"),]
store2 <- matrix(data=0, nrow = 4, ncol = 2); colnames(store1) <- c("Year", "Total PM2.5  emission")

years <- unique(rrM$year)
for(i in 1:length(years)){
  store2[i,1] <- years[i]
  store2[i,2] <- sum(rr[which(rrM$year==years[i]),4])
}
rownames(store2) <- store2[,1]
png("plot2a.png", width = 500, height = 450)
barplot(store2[,2], main = "Total PM2.5 emissions for four years in Maryland", col =brewer.pal(4,"Blues") , xlab = "Years", ylab = "Total PM2.5 emission")
dev.off()

#3
#for Baltimore
library(ggplot2)
library(reshape2)
unique(rr$type)
type1 <- unique(rr$type)
#rrM
#######Below one line is the answer
library(plyr)

#ppa3 <- ggplot(rrM, aes(x=factor(year), fill=type)) + geom_bar(position = "dodge"   )+ggtitle("Sources of emission over 4 years")
#ppa3 + geom_text(aes(y =2, label = rrM$Emissions), position = position_dodge(0.9), vjust = 0)

##
png("plot3a.png", width = 500, height = 450)
ggplot(rrM, aes(factor(type), fill=factor(year))) + geom_bar(position = "dodge")+ggtitle("Sources of emission over 4 years")
dev.off()
#ggplot(rrM, aes(x = factor(type))) + geom_bar(stat="count")  + ggtitle("hi")

i=1
rrM2 <- rrM[which(rrM$type==type1[i]),]
ggplot(rrM2, aes(x = factor(year))) + geom_bar(stat = "count", fill =brewer.pal(5,"Blues")[2:5]) + ggtitle(type1[i] )

i=2
rrM2 <- rrM[which(rrM$type==type1[i]),]
ggplot(rrM2, aes(x = factor(year))) + geom_bar(stat = "count", fill =brewer.pal(5,"Blues")[2:5]) + ggtitle(type1[i] )

i=3
rrM2 <- rrM[which(rrM$type==type1[i]),]
ggplot(rrM2, aes(x = factor(year))) + geom_bar(stat = "count", fill =brewer.pal(5,"Blues")[2:5]) + ggtitle(type1[i] )

i=4
rrM2 <- rrM[which(rrM$type==type1[i]),]
ggplot(rrM2, aes(x = factor(year))) + geom_bar(stat = "count", fill =brewer.pal(5,"Blues")[2:5]) + ggtitle(type1[i] )




#4
##check ee variable to see which are COAL
#store its respective SCC and do a simple which() on rr
coalR <- t(data.frame(lapply(ee[grepl("Coal",ee$EI.Sector),1], as.character), stringsAsFactors = FALSE))


store3 <- rr[which(rr$SCC==as.numeric(coalR[1,1])),]
for(i in 2:length(coalR)){
  store3 <- rbind(store3, rr[which(rr$SCC==as.numeric(coalR[i,1])),])
}
mstore3 <- matrix(data=0, nrow = 4, ncol = 2)
years3 <- unique(store3$year)
for(i in 1:length(years3)){
  mstore3[i,1] <- years3[i]
  mstore3[i,2] <- sum(store3[which(store3$year==years3[i]),4])
}
rownames(mstore3) <- mstore3[,1]
png("plot4a.png", width = 500, height = 450)
ppa4 <- barplot(mstore3[,2], main = "Total PM2.5 emissions for four years (coal-related)", col =brewer.pal(8,"Blues")[2:5], xlab = "Years", ylab = "Total PM2.5 emission (coal-related)")
#text(ppa4, 10, round(mstore3[,2],3), cex = 1, pos = 3, col = "red")
dev.off()

#5
##get baltimore only
rrM <- rr[which(rr$fips=="24510"),]
vehicle <- t(data.frame(lapply(ee[grepl("Vehicle",ee$SCC.Level.Two),1], as.character), stringsAsFactors = FALSE))

store4 <- rrM[which(rrM$SCC==as.numeric(vehicle[1,1])),]
for(i in 2:length(vehicle)){
  store4 <- rbind(store4, rrM[which(rrM$SCC==as.numeric(vehicle[i,1])),])
}
mstore4 <- matrix(data=0, nrow = 4, ncol = 2)
years4 <- unique(rrM$year)
for(i in 1:length(years4)){
  mstore4[i,1] <- years4[i]
  mstore4[i,2] <- sum(store4[which(store4$year==years4[i]),4])
}
rownames(mstore4) <- mstore4[,1]
png("plot5a.png", width = 500, height = 450)
ppa <-barplot(mstore4[,2], main = "Total PM2.5 emissions for four years (vehicle-related) in Baltimore", col =brewer.pal(8,"Blues")[2:5], xlab = "Years", ylab = "Total PM2.5 emission (vehicle-related)")
#text(ppa, 10, round(mstore4[,2],3), cex = 1, pos = 3, col = "red")
dev.off()
#?????????


#6
rrL <- rr[which(rr$fips=="06037"),]
vehicle <- t(data.frame(lapply(ee[grepl("Vehicle",ee$SCC.Level.Two),1], as.character), stringsAsFactors = FALSE))
store4L <- rrL[which(rrL$SCC==as.numeric(vehicle[1,1])),]
for(i in 2:length(vehicle)){
  store4L <- rbind(store4L, rrL[which(rrL$SCC==as.numeric(vehicle[i,1])),])
}
mstore4L <- matrix(data=0, nrow = 4, ncol = 2)
years4L <- unique(rrM$year)
for(i in 1:length(years4L)){
  mstore4L[i,1] <- years4L[i]
  mstore4L[i,2] <- sum(store4L[which(store4L$year==years4L[i]),4])
}
rownames(mstore4L) <- mstore4L[,1]
ppa6 <- barplot(mstore4L[,2], main = "Total PM2.5 emissions for four years (vehicle-related) in Los Angeles", col =brewer.pal(8,"Blues")[2:5], xlab = "Years", ylab = "Total PM2.5 emission (vehicle-related)")
text(ppa6, 20, round(mstore4L[,2],3), cex = 1, pos = 3, col= "red")

#To have the years graph side by side
mstore4a <- cbind(mstore4, mstore4L[,2])
colnames(mstore4a) <- c("Year", "Baltimore", "Los Angeles")
png("plot6a.png", width = 500, height = 450)
pp <- barplot(mstore4a[,c(2,3)], beside=TRUE, names.arg = colnames(mstore4a)[2:3], main = "Total PM2.5 emissions for four years (vehicle-related ", col =brewer.pal(5,"Blues")[2:5] )
text(pp, 30, years, cex = 1, pos = 3)
dev.off()

