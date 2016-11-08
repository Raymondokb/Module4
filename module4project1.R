rr <- read.csv("D:\\Users\\msboon\\Desktop\\For Data science coursera\\Plots\\module4dataset.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)

#strptime(), as.Date()
# (x <- strptime(c("2006-01-08 10:07:52", "2006-08-07 19:33:02"),"%Y-%m-%d %H:%M:%S", tz = "EST5EDT")
# attr(x, "tzone")

barplot(table(rr$Global_active_power), col="red")
library(ggplot2)

ggplot(rr) + geom_histogram(aes(Global_active_power), bins=12)


