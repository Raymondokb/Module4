library(ggplot2)
#SImpson's paradox: trend appears in different groups of data but disappears or reverses when these groups are combined

# Rules
# 1. Show comparisons
# 2. Show causalit, mechanism, explanation
# 3. Show multivariate data
# 4. Integrate multiple modes of evidence
# 5. Describe and document the evidence (source code)
# 6. Content is king

library(swirl)
install_from_swirl("Exploratory Data Analysis")

#quantile(vector) gets 0, 25, 50, 75, 100%
#boxplot(ppm, col="blue")
#abline(h=12) draws horizontal line at value 12. Simple quick "indicator" to prove a point on a plot
#hist(ppm, col = "green")
#rug(ppm): grayscale representation of histogram, shows concentration density
#hist(ppm, col = "green", breaks=100)
#abline(v=12, lwd=2) draws a vertical line,of thickness 2
#abline(v=median(ppm), col="magenta", lwd=4)
#names(pollution)

#barplot(reg, col = "wheat", main = "Number of Counties in Each Region")
#boxplot( pm25 ~ region, data = pollution, col = "red")
#
#par(mfrow=c(2,1),mar=c(4,4,2,1)) is two rows, one column
#east <- subset(pollution, region=="east")
#hist(east$pm25, col = "green")
#hist(subset(pollution, region=="west")$pm25, col="green")

#################
#with(pollution, plot(latitude, pm25)) IMPORTANT SHORTCUT
#################
#abline(h=12, lwd = 2, lty = 2); lty is type of line, lwd is thickness
#plot(x = pollution$latitude, y = ppm, col = pollution$region)
#

#par(mfrow = c(1, 2), mar= c(5, 4, 2, 1))
#west <- subset(pollution, region == "west")
#plot(west$latitude, west$pm25, main = "West")
#plot(east$latitude, east$pm25, main = "East")
#


