# Coursera JHU Spec Data Science
#
# Exploratory Data Analysis
#
# Project 2
#
# Plot5.R
#

# Read data
library(ggplot2)
library(reshape2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
index_vehicles <- grep("Mobile - On-Road",SCC$EI.Sector)
keys_vehicles <- SCC[index_vehicles,]$SCC
baltimore_data <- NEI[NEI$SCC %in% keys_vehicles,]

acc_emiss_year <- tapply(baltimore_data$Emissions,baltimore_data$year,sum)
# Open the graphic device with the size 480 x 480
png(file = "Plot5.png", width = 480, height = 480, bg = "transparent")
barplot(acc_emiss_year,ylab="PM_2.5 (tons)",main="Vehicles PM_2.5 yearly Baltimore",xlab="",axis.lty=1)
dev.off()