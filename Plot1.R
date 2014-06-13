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
# We open the graphic 
png(file = "Plot1.png", width = 480, height = 480, bg = "transparent")
# As the accumulated emissions are in the order of millions of tons, we divide by 1000.000
# and add the proper indication in the y label
df_scaled <- acc_emiss_year/1000000
b<-barplot(df_scaled,ylab="PM_2.5 (Million tons)",main="Total PM_2.5 yearly emissions in USA",xlab="",axis.lty=1,ylim=c(0, 1.3*round(df_scaled[1],2)))
percent_labels <- paste0("-",100*(1-round(df_scaled/df_scaled[1],3)),"%")
percent_labels[1] <- "1999 Reference: 100%"
text(x=b,y=as.vector(df_scaled),labels=percent_labels, pos=3,col="black",cex=0.75) 
dev.off()