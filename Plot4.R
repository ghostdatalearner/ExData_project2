# Coursera JHU Spec Data Science
#
# Exploratory Data Analysis
#
# Project 2
#
# Plot4.R
#

# Read data
library(ggplot2)
library(reshape2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
d<-as.character(SCC$Short.Name)
# Search all the sources that contain the word 'coal'
index_coal <- grep("[Cc]oal",SCC[grep("Combustion",SCC$SCC.Level.One,ignore.case = TRUE),]$SCC.Level.Three)
keys_coal <- SCC[index_coal,]$SCC
data_coal <- NEI[NEI$SCC %in% keys_coal,]

acc_emiss_year <- tapply(data_coal$Emissions,data_coal$year,sum)
# Open the graphic device with the size 480 x 480
png(file = "Plot4.png", width = 480, height = 480, bg = "transparent")
barplot(acc_emiss_year/1000000,ylab="PM_2.5 (Million tons)",main="Coal combustion related PM_2.5 yearly emissions in USA",xlab="",axis.lty=1)
dev.off()