#Author: Esmit Pérez
#Date: Feb 16 2015
#Exploratory Data Analysis on Coursera - exdata-011

#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Find out all coal related sources
motorVehicleSourceCode <- SCC[grep("Motor Vehicle",SCC$Short.Name),]$SCC

# filter the original data, using just this
motorVehiclesDataBaltimore <- projectData[projectData$SCC %in% motorVehicleSourceCode & projectData$fips=="24510",]

plot4Data <- aggregate(Emissions ~ year, motorVehiclesDataBaltimore, sum)

with (plot4Data, {
        plot(Emissions ~ year , xlim = c(1999,2010), type="o", xlab="Year", ylab="Total emissions (in tons)", 
             lwd=3, lty="solid", col="coral3", col.lab="navajowhite4", 
             main = "Total emissions from PM2.5, from 1999 to 2008")
        abline(lm(Emissions ~ year), lwd=2, lty="dashed", col="slateblue") 
})