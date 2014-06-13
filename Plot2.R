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
# Open the graphic device
png(file = "Plot2.png", width = 480, height = 480, bg = "transparent")
b <- barplot(acc_emiss_year,ylab="PM_2.5 (tons)",main="Total PM_2.5 yearly emissions in Baltimore City",xlab="",axis.lty=1,ylim=c(0, 1.2*round(acc_emiss_year[1],2)))
percent_labels <- paste0(100*(round((acc_emiss_year-acc_emiss_year[1])/acc_emiss_year[1],3)),"%")
percent_labels[1] <- "1999 Reference: 100%"
text(x=b,y=as.vector(acc_emiss_year),labels=percent_labels, pos=3,col="black",cex=0.75) 
dev.off()