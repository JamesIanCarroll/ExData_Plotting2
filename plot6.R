#General Set-up
setwd("G:\\My Dropbox\\Dropbox\\Coursera\\Exploratory Data Analysis 2")
unzip("G:\\My Dropbox\\Dropbox\\Coursera\\Exploratory Data Analysis 2\\exdata-data-NEI_data.zip")
NEI  <-  readRDS("summarySCC_PM25.rds")
SCC  <-  readRDS("Source_Classification_Code.rds")
NEISSC <- merge(NEI, SCC, by.x="SCC", by.y="SCC", all=TRUE)
uniques <- data.frame(unique(SCC$EI.Sector))
library(ggplot2)

#Plot6 Manipulation 
#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California ( fips == "06037" ). Which city has seen greater changes over time in motor vehicle emissions?
#Baltimore City
CarsOnly <- NEISSC[NEISSC$EI.Sector=="Mobile - On-Road Gasoline Light Duty Vehicles" | NEISSC$EI.Sector=="Mobile - On-Road Gasoline Heavy Duty Vehicles" | NEISSC$EI.Sector=="Mobile - On-Road Diesel Light Duty Vehicles" | NEISSC$EI.Sector=="Mobile - On-Road Diesel Heavy Duty Vehicles",]
BCCarsOnly1999 <- c("1999", sum(CarsOnly[CarsOnly$year=="1999" & CarsOnly$fips =="24510","Emissions"]/100, na.rm=TRUE))
BCCarsOnly2002 <- c("2002", sum(CarsOnly[CarsOnly$year=="2002" & CarsOnly$fips =="24510","Emissions"]/100, na.rm=TRUE))
BCCarsOnly2005 <- c("2005", sum(CarsOnly[CarsOnly$year=="2005" & CarsOnly$fips =="24510","Emissions"]/100, na.rm=TRUE))
BCCarsOnly2008 <- c("2008", sum(CarsOnly[CarsOnly$year=="2008" & CarsOnly$fips =="24510","Emissions"]/100, na.rm=TRUE))  
BCCarsOnlyGraph <- data.frame(rbind(BCCarsOnly1999, BCCarsOnly2002, BCCarsOnly2005, BCCarsOnly2008), row.names=NULL, stringsAsFactors=FALSE)
names(BCCarsOnlyGraph) <- c("Year", "CarsRelatedEmissions")
BCCarsOnlyGraph$CarsRelatedEmissions <- as.numeric(BCCarsOnlyGraph$CarsRelatedEmissions)
BCCarsOnlyGraph$Area <- c("BC")

#Los Angeles County, California
LACarsOnly1999 <- c("1999", sum(CarsOnly[CarsOnly$year=="1999" & CarsOnly$fips =="06037","Emissions"]/100, na.rm=TRUE))
LACarsOnly2002 <- c("2002", sum(CarsOnly[CarsOnly$year=="2002" & CarsOnly$fips =="06037","Emissions"]/100, na.rm=TRUE))
LACarsOnly2005 <- c("2005", sum(CarsOnly[CarsOnly$year=="2005" & CarsOnly$fips =="06037","Emissions"]/100, na.rm=TRUE))
LACarsOnly2008 <- c("2008", sum(CarsOnly[CarsOnly$year=="2008" & CarsOnly$fips =="06037","Emissions"]/100, na.rm=TRUE))  
LACarsOnlyGraph <- data.frame(rbind(LACarsOnly1999, LACarsOnly2002, LACarsOnly2005, LACarsOnly2008), row.names=NULL, stringsAsFactors=FALSE)
names(LACarsOnlyGraph) <- c("Year", "CarsRelatedEmissions")
LACarsOnlyGraph$CarsRelatedEmissions <- as.numeric(LACarsOnlyGraph$CarsRelatedEmissions)
LACarsOnlyGraph$Area <- c("LA")

#Merging Datasets
LABCCarsOnlyGraph <- data.frame(rbind(BCCarsOnlyGraph, LACarsOnlyGraph), stringsAsFactors=FALSE)
names(LABCCarsOnlyGraph) <- c("Years", "CarsRelatedEmissions", "Location")
LABCCarsOnlyGraph$Location <- as.factor(LABCCarsOnlyGraph$Location)

#Adding Normalised vs Non-Normalised Factor
LABCCarsOnlyGraph$Normalised <- c("Non-Normalised")


#Normalising the data -GOT TO HERE, NEED TO FIX THIS - maybe do as factors? Also look at Facebook chat
BCNormCarsOnlyGraph <- BCCarsOnlyGraph
BCNormCarsOnlyGraph$Normalised <- c("Normalised")
names(BCNormCarsOnlyGraph) <- c("Years", "CarsRelatedEmissions", "Location", "Normalised")
BCNormCarsOnlyGraph$CarsRelatedEmissions <- BCNormCarsOnlyGraph$CarsRelatedEmissions*100/sum(CarsOnly[CarsOnly$year=="1999" & CarsOnly$fips =="24510","Emissions"], na.rm=TRUE)
LANormCarsOnlyGraph <- LACarsOnlyGraph
LANormCarsOnlyGraph$Normalised <- c("Normalised")
LANormCarsOnlyGraph$CarsRelatedEmissions <- LANormCarsOnlyGraph$CarsRelatedEmissions*100/sum(CarsOnly[CarsOnly$year=="1999" & CarsOnly$fips =="06037","Emissions"], na.rm=TRUE)
names(LANormCarsOnlyGraph) <- c("Years", "CarsRelatedEmissions", "Location", "Normalised")

LABCNormCarsOnlyGraph <- data.frame(rbind(LABCCarsOnlyGraph, LANormCarsOnlyGraph, BCNormCarsOnlyGraph), stringsAsFactors=FALSE)
LABCNormCarsOnlyGraph$Intercept = c("3.4682000", "3.4682000", "3.4682000", "3.4682000", "39.3112000", "39.3112000", "39.3112000", "39.3112000", "1", "1", "1", "1", "1", "1", "1", "1")
LABCNormCarsOnlyGraph$Intercept <- as.numeric(LABCNormCarsOnlyGraph$Intercept)
class(LABCNormCarsOnlyGraph$Intercept)

#Plot6 Graph
graph6   <- ggplot(LABCNormCarsOnlyGraph, aes(Years, CarsRelatedEmissions, Intercept)) + geom_bar(stat="identity")
print(graph6)
graph6a  <- graph6 + facet_grid(Normalised~Location, scales="free") + ylab(expression("Total Car Related PM(2.5) Emissions (in hundred tons)")) + xlab("Years") + ggtitle(expression("Total Car Related PM(2.5) Emissions in Baltimore City (BC), Maryland, \nand Los Angeles County (LA), California from 1999 to 2008"))
print(graph6a)
ggsave(filename="plot6.png", plot=graph6a)