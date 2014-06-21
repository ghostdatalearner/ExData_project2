# Coursera JHU Spec Data Science
#
# Exploratory Data Analysis
#
# Project 2
#
# Plot6.R
#

# Read data
library(ggplot2)
library(reshape2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
index_vehicles <- grep("Mobile - On-Road",SCC$EI.Sector)
keys_vehicles <- SCC[index_vehicles,]$SCC
baltimore_data <- NEI[NEI$SCC %in% keys_vehicles & NEI$fips == "24510",]
LA_data <- NEI[NEI$SCC %in% keys_vehicles & NEI$fips == "06037",]
balt_emiss_year <- tapply(baltimore_data$Emissions,baltimore_data$year,sum)
LA_emiss_year <- tapply(LA_data$Emissions,LA_data$year,sum)
png(file = "Plot6.png", width = 1200, height = 600, bg = "transparent")
par(mfrow=c(1,2))
b <- barplot(balt_emiss_year,ylab="PM_2.5 (tons)",main="Baltimore PM_2.5 yearly emissions",xlab="",axis.lty=1,ylim=c(0, 1.3*round(balt_emiss_year[1],2)))
percent_labels <- paste0(100*(round((balt_emiss_year-balt_emiss_year[1])/balt_emiss_year[1],3)),"%")
percent_labels[1] <- "1999 Reference: 100%"
text(x=b,y=as.vector(acc_emiss_year),labels=percent_labels, pos=3,col="black",cex=0.75) 
c <- barplot(LA_emiss_year,ylab="PM_2.5 (tons)",main="LA PM_2.5 yearly emissions",xlab="",axis.lty=1,ylim=c(0, 1.3*round(LA_emiss_year[1],2)))
percent_labels <- paste0(100*(round((LA_emiss_year-LA_emiss_year[1])/LA_emiss_year[1],3)),"%")
percent_labels[1] <- "1999 Reference: 100%"
text(x=c,y=as.vector(LA_emiss_year),labels=percent_labels, pos=3,col="black",cex=0.75) 
dev.off()
