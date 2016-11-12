library(lattice)
library(datasets)
xyplot(Ozone ~ Wind, data = airquality)

#Converting MONTH to a factor
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout =c(5,1))
p <- xyplot(Ozone ~ Wind, data = airquality)


####
set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))
xyplot(y ~ x | f, layout=c(2,1))

#custom
xyplot(y ~ x | f, panel = function(x,y,...){
  panel.xyplot(x,y,...)
  panel.abline(h=median(y), lty = 2)
})

#Now ggplot2
#gg stands for Grammar of Graphics
library(ggplot2)
#qplot()
#factors SHOULD be labelled

str(mpg)
qplot(displ, hwy, data = mpg, color = drv)
qplot(displ, hwy, data = mpg, geom = c("point", "smooth")) # Adding a geom
qplot(hwy, data = mpg, fill = drv)
#facets are similiar to panels
#facets = row~column
qplot(displ, hwy, data = mpg, facets = .~drv)
qplot(hwy, data = mpg, facets = drv~., binwidth = 2)
#geom = "density"
#shape=v1; color = v2
# + geom_smooth(method = "lm") #linear relationship
qplot(displ, hwy, data = mpg, color = drv) + geom_smooth(method = "lm") #diff line
qplot(displ, hwy, data = mpg, facets = .~drv) + geom_smooth(method = "lm") #diff plot


##ggplot plotting part 2
#stats = binning, quantiles, smoothing
#scales 
g <- ggplot(data = mpg, aes(displ, hwy))
g1 <- g + geom_point()
print(g1)
g1 + geom_smooth()
g1 + geom_smooth(method = "lm")

g1 + facet_grid(.~drv)
g1 + geom_smooth(method = "lm") + facet_grid(drv~.) + theme_bw()

#now, annotations
#xlab, ylab, labs, ggtitle
#theme(legend.position = "none")
#theme_gray(); theme_bw()
g + geom_point(color = "steelblue", size = 4, alpha=1/2) #constant color
g + geom_point(aes(color = drv), size = 4, alpha = 1/2) #need aes for assigning variable as color

g1 + labs(x = expression("exp "+ PM[2.5]), y = "changed y label")

g1 + geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE)
#Modified smoother

g1 + theme_bw(base_family = "Papyrus")
g1 + theme_bw(base_family = "sans")

#Now Axis Limits
testdat <- data.frame( x= 1:100, y = rnorm(100))
testdat[50,2] <- 100 ##Outlier
plot(testdat$x, testdat$y, type ="l", ylim = c(-3, 3))

g <- ggplot(testdat, aes(x=x, y=y))
g + geom_line()

#making sure outlier is included
g + geom_line() + coord_cartesian(ylim = c(-3, 3))
#versus just g + geom_line() + ylim(c(-3, 3))  #see the outlier is removed

#now use cut()
cutpoints <- quantile(mtcars$hp, seq(0, 1, length = 4), na.rm=TRUE)
mtcars2 <- mtcars
mtcars2$no2dec <- cut(mtcars$hp, cutpoints)
levels(mtcars2$no2dec)

g <- ggplot(data = mtcars, aes(x=disp, y = mpg))
g + geom_point(alpha = 1/3) +
  facet_wrap(vs~am) + 
  geom_smooth(method="lm", se=FALSE, color = "steelblue")+
  theme_bw(base_family="Papyrus",base_size = 10) +
  labs(x = expression("log" * pM[2.5])) +
  labs(y = "mpg") +
  labs(title = "Disp against mpg, wrt am, vs")





#Quiztime

#1. returns trellis
#2. 
library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)

#3
#multipanel: panel.abline


#4
library(lattice)
library(datasets)
data(airquality)
p <- xyplot(Ozone ~ Wind | factor(Month), data = airquality)

#5
?trellis.par.set

#8
#geom is a plotting object

#9: ggplot needs layers

#10
qplot(votes, rating, data = movies)
qplot(displ, hwy, data =mpg) + geom_smooth()
