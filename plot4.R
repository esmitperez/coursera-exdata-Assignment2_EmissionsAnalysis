#Author: Esmit Pérez
#Date: Feb 16 2015
#Exploratory Data Analysis on Coursera - exdata-011

#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# Find out all coal related sources
coalSourceCode <- SCC[grep("Coal",SCC$Short.Name),]$SCC

# filter the original data, using just this
coalCombustionData <- projectData[projectData$SCC %in% coalSourceCode,]

plot4Data <- aggregate(Emissions ~ year, coalCombustionData, sum)

with (plot4Data, {
        plot(Emissions/1000 ~ year , type="o", xlab="Year", ylab="Total emissions (in thousands of tons)", 
             lwd=3, lty="solid", col="coral3", col.lab="navajowhite4", 
             main = "Total emissions from PM2.5, from 1999 to 2008") 
        abline(lm(Emissions/1000 ~ year), lwd=2, lty="dashed", col="slateblue") 
})