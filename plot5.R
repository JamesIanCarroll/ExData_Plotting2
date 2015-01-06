#General Set-up
setwd("G:\\My Dropbox\\Dropbox\\Coursera\\Exploratory Data Analysis 2")
unzip("G:\\My Dropbox\\Dropbox\\Coursera\\Exploratory Data Analysis 2\\exdata-data-NEI_data.zip")
NEI  <-  readRDS("summarySCC_PM25.rds")
SCC  <-  readRDS("Source_Classification_Code.rds")
NEISSC <- merge(NEI, SCC, by.x="SCC", by.y="SCC", all=TRUE)
uniques <- data.frame(unique(SCC$EI.Sector))
library(ggplot2)

#Plot5 Manipulation
#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
CarsOnly <- NEISSC[NEISSC$EI.Sector=="Mobile - On-Road Gasoline Light Duty Vehicles" | NEISSC$EI.Sector=="Mobile - On-Road Gasoline Heavy Duty Vehicles" | NEISSC$EI.Sector=="Mobile - On-Road Diesel Light Duty Vehicles" | NEISSC$EI.Sector=="Mobile - On-Road Diesel Heavy Duty Vehicles",]
CarsOnly1999 <- c("1999", sum(CarsOnly[CarsOnly$year=="1999" & CarsOnly$fips =="24510","Emissions"]/100, na.rm=TRUE))
CarsOnly2002 <- c("2002", sum(CarsOnly[CarsOnly$year=="2002" & CarsOnly$fips =="24510","Emissions"]/100, na.rm=TRUE))
CarsOnly2005 <- c("2005", sum(CarsOnly[CarsOnly$year=="2005" & CarsOnly$fips =="24510","Emissions"]/100, na.rm=TRUE))
CarsOnly2008 <- c("2008", sum(CarsOnly[CarsOnly$year=="2008" & CarsOnly$fips =="24510","Emissions"]/100, na.rm=TRUE))  
CarsOnlyGraph <- data.frame(rbind(CarsOnly1999, CarsOnly2002, CarsOnly2005, CarsOnly2008), row.names=NULL, stringsAsFactors=FALSE)
names(CarsOnlyGraph) <- c("Year", "CarsRelatedEmissions")
CarsOnlyGraph$CarsRelatedEmissions <- as.numeric(CarsOnlyGraph$CarsRelatedEmissions)

#Plot5 Graph
png("plot5.png")
graph5   <- barplot(height=CarsOnlyGraph$CarsRelatedEmissions, names.arg=CarsOnlyGraph$Year, ylab=expression('Total Car Related PM'[2.5]*' Emissions (in hundred tons)'), xlab="Years", main =("Total Car Related PM(2.5) Emissions in Baltimore City, \nMaryland from 1999 to 2008"), col="grey", ylim=c(0,4))
dev.off()
