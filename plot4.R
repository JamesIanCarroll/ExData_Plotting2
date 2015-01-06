#General Set-up
setwd("G:\\My Dropbox\\Dropbox\\Coursera\\Exploratory Data Analysis 2")
unzip("G:\\My Dropbox\\Dropbox\\Coursera\\Exploratory Data Analysis 2\\exdata-data-NEI_data.zip")
NEI  <-  readRDS("summarySCC_PM25.rds")
SCC  <-  readRDS("Source_Classification_Code.rds")
NEISSC <- merge(NEI, SCC, by.x="SCC", by.y="SCC", all=TRUE)
uniques <- data.frame(unique(SCC$EI.Sector))
library(ggplot2)

#Plot4 Manipulation
#Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008
CoalOnly <- NEISSC[NEISSC$EI.Sector=="Fuel Comb - Electric Generation - Coal" | NEISSC$EI.Sector=="Fuel Comb - Industrial Boilers, ICEs - Coal" | NEISSC$EI.Sector=="Fuel Comb - Comm/Institutional - Coal",]
CoalOnly1999 <- c("1999", sum(CoalOnly[CoalOnly$year=="1999","Emissions"]/100000, na.rm=TRUE))
CoalOnly2002 <- c("2002", sum(CoalOnly[CoalOnly$year=="2002","Emissions"]/100000, na.rm=TRUE))
CoalOnly2005 <- c("2005", sum(CoalOnly[CoalOnly$year=="2005","Emissions"]/100000, na.rm=TRUE))
CoalOnly2008 <- c("2008", sum(CoalOnly[CoalOnly$year=="2008","Emissions"]/100000, na.rm=TRUE))  
CoalOnlyGraph <- data.frame(rbind(CoalOnly1999, CoalOnly2002, CoalOnly2005, CoalOnly2008), row.names=NULL, stringsAsFactors=FALSE)
names(CoalOnlyGraph) <- c("Year", "CoalRelatedEmissions")
CoalOnlyGraph$CoalRelatedEmissions <- as.numeric(CoalOnlyGraph$CoalRelatedEmissions)

#Plot4 Graph
png("plot4.png")
graph4   <- barplot(height=CoalOnlyGraph$CoalRelatedEmissions, names.arg=CoalOnlyGraph$Year, ylab=expression('Total Coal Related PM'[2.5]*' Emissions (in hundred thousand tons)'), xlab="Years", main =expression('Total Coal Related PM'[2.5]*' Emissions in USA from 1999 to 2008'), col="grey", ylim=c(0,6))
dev.off()
