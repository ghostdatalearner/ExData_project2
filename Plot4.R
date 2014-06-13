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
# Open the graphic device
png(file = "Plot4.png", width = 480, height = 550, bg = "transparent")
df_scaled <- acc_emiss_year/1000000
b<- barplot(df_scaled,ylab="PM_2.5 (Million tons)",
            main="Coal combustion related PM_2.5 yearly emissions in USA",xlab="",axis.lty=1, ylim=c(0, 1.2*round(df_scaled[1],2)))
#par(mar = c(5, 4, 6, 2))
percent_labels <- paste0("-",100*(1-round(df_scaled/df_scaled[1],3)),"%")
percent_labels[1] <- "1999 Reference: 100%"
text(x=b,y=as.vector(df_scaled),labels=percent_labels, pos=3,col="black",cex=0.75) 
dev.off()