#Principle of analytic graphics: show comparisons
# Role of exploratory data: xin place of formal modelling
#
########

#Week 1, Lesson 2
#Base plotting
library(datasets)
data(cars)
with(cars, plot(speed, dist))

#Lattice
# All in one command, hence need to specify alot including margins and spacing
#eg: conditioning plot, plot y~x conditioning on diff variables z
library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4,1))

library(ggplot2)
###########
library(lattice)

library(datasets)
hist(airquality$Ozone)
with(airquality, plot(Wind, Ozone))

airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month , airquality, xlab = "Month", ylab = "Ozone(pbb)")

#pch: plotting symbol
#lty : line type
#lwd: line width
#col: line color
#xlab, ylab: label on respective axes

#par(): oma: outer margin for printing aesthetics
par("lty") #and below to see the current settings of the par parameters
par("oma")
par("mar") #clockwise direction, starting from left. Margin length
par("mfrow")


#Adding to plot
##lines points, text, title, mtext (margin text) (arbitrary text to margins), axis

with(airquality, plot(Wind, Ozone))
title(main ="Ozone and WInd on NYC")   #Adding a title
with(subset(airquality, Month==5), points(Wind, Ozone, col = "blue"))

with(airquality, plot(Wind, Ozone), main = "Ozone and Wind in NYC", type = "n")
with(subset(airquality, Month ==5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other months"))

with(airquality, plot(Wind, Ozone, pch = 20), main = "Ozone and Wind in NYC")
model <- lm(Wind ~ Ozone, airquality)
abline(model, lwd = 2)
