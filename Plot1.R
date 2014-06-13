# Coursera JHU Spec Data Science
#
# Exploratory Data Analysis
#
# Project 2
#
# Plot1.R
#

NEI <- readRDS("summarySCC_PM25.rds")
# Total emissions by year.
acc_emiss_year <- tapply(NEI$Emissions,NEI$year,sum)
# We open the graphic device with the size 480 x 480
png(file = "Plot1.png", width = 480, height = 480, bg = "transparent")
# As the accumulated emissions are in the order of millions of tons, we divide by 1000.000
# and add the proper indication in the y label
barplot(acc_emiss_year/1000000,ylab="PM_2.5 (Million tons)",main="Total PM_2.5 yearly emissions in USA",xlab="",axis.lty=1)
dev.off()