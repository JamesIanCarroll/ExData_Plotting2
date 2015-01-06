#General Set-up
setwd("G:\\My Dropbox\\Dropbox\\Coursera\\Exploratory Data Analysis 2")
unzip("G:\\My Dropbox\\Dropbox\\Coursera\\Exploratory Data Analysis 2\\exdata-data-NEI_data.zip")
NEI  <-  readRDS("summarySCC_PM25.rds")
SCC  <-  readRDS("Source_Classification_Code.rds")
NEISSC <- merge(NEI, SCC, by.x="SCC", by.y="SCC", all=TRUE)
uniques <- data.frame(unique(SCC$EI.Sector))
library(ggplot2)

#Plot 1 Data
sum1999  <- sum(NEI[NEI$year =="1999","Emissions"])
sum2002  <- sum(NEI[NEI$year =="2002","Emissions"])
sum2005  <- sum(NEI[NEI$year =="2005","Emissions"])
sum2008  <- sum(NEI[NEI$year =="2008","Emissions"])
years = as.numeric(c("1999", "2002", "2005", "2008"))
totals = c(sum1999/1000000, sum2002/1000000, sum2005/1000000, sum2008/1000000)
tograph    <- data.frame(Years = years, Totals = totals)

#Plot 1 Graphs
png("plot1.png")
graph1   <- barplot(height=tograph$Totals, names.arg=tograph$Years, ylab=expression('Total PM'[2.5]*' Emissions (in million tons)'), xlab="Years", main =expression('Total PM'[2.5]*' Emissions from 1999 to 2008'), col="blue")
dev.off()