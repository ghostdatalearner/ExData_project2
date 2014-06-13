# Coursera JHU Spec Data Science
#
# Exploratory Data Analysis
#
# Project 2
#
# Plot3.R
#

# Read data
library(ggplot2)
library(reshape2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
names_NEI <- names(NEI)
types_emission <- unique(NEI$type)
# Total emissions by year in Baltimore City.
data_baltimore <- subset(NEI,NEI$fips == "24510")
# Split by type of emission
data_chunks <- split(data_baltimore,data_baltimore$type)
# Build an empty results data frame
data_frame_sums <- data.frame(matrix(nrow=0, ncol=3))
names(data_frame_sums) <- c("Emissions","Year","Type")
# For loop to create a data frame with the sum of emission per year and per type
for (i in types_emission)
{
  partial_df <- as.data.frame(data_chunks[i])
  names(partial_df) <- names_NEI
  # Add by year
  acc_emiss_year <- tapply(partial_df$Emissions,partial_df$year,sum)
  res_df <- data.frame(as.vector(acc_emiss_year),names(acc_emiss_year))
  # Add a colum with the type
  res_df <- cbind(res_df,rep(i,nrow(res_df)))
  names(res_df) <- names(data_frame_sums)
  # Bind the partial results to the data_frame_results
  data_frame_sums <- rbind(data_frame_sums,res_df)
}

# Open the graphic device
png(file = "Plot3.png", width = 1000, height = 800, bg = "transparent")
gr <-ggplot(data_frame_sums,aes(x=Year, y= Emissions, group = Type, colour=Type)) 
gr <- gr + geom_line(size=1) + geom_point() + ylab("PM_2.5 (tons)") + ggtitle("Total PM_2.5 yearly emissions")
gr <- gr + geom_text(data = data_frame_sums[data_frame_sums$Year=="1999",], aes(label = round(Emissions,0)), hjust = 1.2,vjust =0)
gr <- gr + geom_text(data = data_frame_sums[data_frame_sums$Year %in% c("2002","2005"),], aes(label = round(Emissions,0)), hjust = -0.4,vjust = -0.4)
gr <- gr + geom_text(data = data_frame_sums[data_frame_sums$Year=="2008" & data_frame_sums$Type!="NON-ROAD" ,], aes(label = round(Emissions,0)), hjust = -0.4,vjust =0)
gr <- gr + geom_text(data = data_frame_sums[data_frame_sums$Year=="2008" & data_frame_sums$Type=="NON-ROAD" ,], aes(label = round(Emissions,0)), hjust = -0.4,vjust =0.4)

print(gr)
dev.off()