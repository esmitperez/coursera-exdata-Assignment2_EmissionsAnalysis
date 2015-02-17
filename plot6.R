#Author: Esmit Pérez
#Date: Feb 16 2015
#Exploratory Data Analysis on Coursera - exdata-011

#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

#Author: Esmit Pérez
#Date: Feb 16 2015
#Exploratory Data Analysis on Coursera - exdata-011

#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
library(ggplot2)

# Find out all coal related sources
motorVehicleSourceCode <- SCC[grep("Motor Vehicle",SCC$Short.Name),]$SCC

# filter the original data, using just this
motorVehiclesDataBaltimore <- projectData[projectData$SCC %in% motorVehicleSourceCode & projectData$fips=="24510",]
motorVehiclesDataCalifornia <- projectData[projectData$SCC %in% motorVehicleSourceCode & projectData$fips=="06037",]

plot5DataMD <- aggregate(Emissions ~ year, motorVehiclesDataBaltimore, sum)
plot5DataLA <- aggregate(Emissions ~ year, motorVehiclesDataCalifornia, sum)
plot5DataMD$City <- "Baltimore"
plot5DataLA$City <- "Los Angeles"

allData = rbind(plot5DataMD, plot5DataLA)

with(allData,{
        plot(Emissions.LA ~ year,
             type="l", xlab="Year", ylab="Total emissions (in tons)", 
             lwd=3, lty="solid", col="coral3", col.lab="navajowhite4", 
             main = "Total emissions from PM2.5, from 1999 to 2008")
        lines(Emissions.BA ~year, col="blue")
})

g <- ggplot(data = allData) + geom_line(aes(x=year, y=Emissions, group=City)) + theme_bw()
g

#abline(plot5DataMD, lm(Emissions ~ year), lwd=2, lty="dashed", col="slateblue") 
