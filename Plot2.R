# Coursera JHU Spec Data Science
#
# Exploratory Data Analysis
#
# Project 2
#
# Plot2.R
#

NEI <- readRDS("summarySCC_PM25.rds")
# Total emissions by year in Baltimore City.
data_baltimore <- subset(NEI,NEI$fips == "24510")
acc_emiss_year <- tapply(data_baltimore$Emissions,data_baltimore$year,sum)
# Open the graphic device with the size 480 x 480
png(file = "Plot2.png", width = 480, height = 480, bg = "transparent")
barplot(acc_emiss_year,ylab="PM_2.5 (tons)",main="Total PM_2.5 yearly emissions in Baltimore City",xlab="",axis.lty=1)
dev.off()