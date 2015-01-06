#General Set-up
setwd("G:\\My Dropbox\\Dropbox\\Coursera\\Exploratory Data Analysis 2")
unzip("G:\\My Dropbox\\Dropbox\\Coursera\\Exploratory Data Analysis 2\\exdata-data-NEI_data.zip")
NEI  <-  readRDS("summarySCC_PM25.rds")
SCC  <-  readRDS("Source_Classification_Code.rds")
NEISSC <- merge(NEI, SCC, by.x="SCC", by.y="SCC", all=TRUE)
uniques <- data.frame(unique(SCC$EI.Sector))
library(ggplot2)

#Plot 3 Data
library(ggplot2)
#Create NON-ROAD Emissions Data
nonroadtypesum1999  <- c("1999", "NonRoad", sum(NEI[NEI$year =="1999" & NEI$fips =="24510" & NEI$type=="NON-ROAD","Emissions"]))
nonroadtypesum2002  <- c("2002", "NonRoad", sum(NEI[NEI$year =="2002" & NEI$fips =="24510" & NEI$type=="NON-ROAD","Emissions"]))
nonroadtypesum2005  <- c("2005", "NonRoad", sum(NEI[NEI$year =="2005" & NEI$fips =="24510" & NEI$type=="NON-ROAD","Emissions"]))
nonroadtypesum2008  <- c("2008", "NonRoad", sum(NEI[NEI$year =="2008" & NEI$fips =="24510" & NEI$type=="NON-ROAD","Emissions"]))

#Create Non-Point Emissions Data
nonpointtypesum1999  <- c("1999", "NonPoint", sum(NEI[NEI$year =="1999" & NEI$fips =="24510" & NEI$type=="NONPOINT","Emissions"]))
nonpointtypesum2002  <- c("2002", "NonPoint", sum(NEI[NEI$year =="2002" & NEI$fips =="24510" & NEI$type=="NONPOINT","Emissions"]))
nonpointtypesum2005  <- c("2005", "NonPoint", sum(NEI[NEI$year =="2005" & NEI$fips =="24510" & NEI$type=="NONPOINT","Emissions"]))
nonpointtypesum2008  <- c("2008", "NonPoint", sum(NEI[NEI$year =="2008" & NEI$fips =="24510" & NEI$type=="NONPOINT","Emissions"]))

#Create On-Road Emissions Data
onroadtypesum1999  <- c("1999", "OnRoad", sum(NEI[NEI$year =="1999" & NEI$fips =="24510" & NEI$type=="ON-ROAD","Emissions"]))
onroadtypesum2002  <- c("2002", "OnRoad", sum(NEI[NEI$year =="2002" & NEI$fips =="24510" & NEI$type=="ON-ROAD","Emissions"]))
onroadtypesum2005  <- c("2005", "OnRoad", sum(NEI[NEI$year =="2005" & NEI$fips =="24510" & NEI$type=="ON-ROAD","Emissions"]))
onroadtypesum2008  <- c("2008", "OnRoad", sum(NEI[NEI$year =="2008" & NEI$fips =="24510" & NEI$type=="ON-ROAD","Emissions"]))

#Create Point Emissions Data
pointtypesum1999  <- c("1999", "Point", sum(NEI[NEI$year =="1999" & NEI$fips =="24510" & NEI$type=="POINT","Emissions"]))
pointtypesum2002  <- c("2002", "Point", sum(NEI[NEI$year =="2002" & NEI$fips =="24510" & NEI$type=="POINT","Emissions"]))
pointtypesum2005  <- c("2005", "Point", sum(NEI[NEI$year =="2005" & NEI$fips =="24510" & NEI$type=="POINT","Emissions"]))
pointtypesum2008  <- c("2008", "Point", sum(NEI[NEI$year =="2008" & NEI$fips =="24510" & NEI$type=="POINT","Emissions"]))

#Collating
collate <- data.frame(rbind(nonroadtypesum1999, nonpointtypesum1999, onroadtypesum1999, pointtypesum1999, nonroadtypesum2002, nonpointtypesum2002, onroadtypesum2002, pointtypesum2002, nonroadtypesum2005, nonpointtypesum2005, onroadtypesum2005, pointtypesum2005, nonroadtypesum2008, nonpointtypesum2008, onroadtypesum2008, pointtypesum2008))
colnames(collate) <- c("Year", "Type", "Emissions")
collate$Type  <- as.factor(collate[ , "Type"])
collate$Emissions <- as.numeric(as.character(collate[ , "Emissions"]))

#Plot 3 Graph
png("plot3.png")
graph3   <- ggplot(collate, aes(Year, Emissions, color=Type))
graph3a   <- graph3 + geom_line(aes(group=Type)) + ylim(0,2250)  + xlab("Year") + ylab(expression('Total PM'[2.5]*' Emissions in tons')) + ggtitle('Total Emission in Baltimore City, Maryland from 1999 to 2008')
print(graph3a)
dev.off()
