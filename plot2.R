#General Set-up
setwd("G:\\My Dropbox\\Dropbox\\Coursera\\Exploratory Data Analysis 2")
unzip("G:\\My Dropbox\\Dropbox\\Coursera\\Exploratory Data Analysis 2\\exdata-data-NEI_data.zip")
NEI  <-  readRDS("summarySCC_PM25.rds")
SCC  <-  readRDS("Source_Classification_Code.rds")
NEISSC <- merge(NEI, SCC, by.x="SCC", by.y="SCC", all=TRUE)
uniques <- data.frame(unique(SCC$EI.Sector))
library(ggplot2)

#Plot 2 Data
baltimoresum1999  <- sum(NEI[NEI$year =="1999" & NEI$fips =="24510","Emissions"])
baltimoresum2002  <- sum(NEI[NEI$year =="2002" & NEI$fips =="24510","Emissions"])
baltimoresum2005  <- sum(NEI[NEI$year =="2005" & NEI$fips =="24510","Emissions"])
baltimoresum2008  <- sum(NEI[NEI$year =="2008" & NEI$fips =="24510","Emissions"])
baltimoretotals   <- c(baltimoresum1999/1000, baltimoresum2002/1000, baltimoresum2005/1000, baltimoresum2008/1000)
baltimoretograph    <- data.frame(Years = years, Totals = baltimoretotals)

#Plot 2 Graph
png("plot2.png")
graph2   <- barplot(height=baltimoretograph$Totals, names.arg=baltimoretograph$Years, ylab=expression('Total PM'[2.5]*' Emissions (in thousand tons)'), xlab="Years", main =expression('Total PM'[2.5]*' Emissions in Baltimore City, Maryland from 1999 to 2008'), col="blue")
dev.off()
