#Author: Esmit Pérez
#Date: Feb 16 2015
#Exploratory Data Analysis on Coursera - exdata-011

# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

plot2Data <- aggregate(Emissions ~ year, projectData[projectData$fips=="24510",], sum)

with (plot2Data, {
        plot(Emissions ~ year, 
             type="o", xlab="Year", ylab="Total emissions (in tons)", 
             lwd=3, lty="solid", col="coral3", col.lab="navajowhite4", 
             main = "Total emissions from PM2.5 in Baltimore City, from 1999 to 2008") 
        abline(lm(Emissions ~ year), lwd=2, lty="dashed", col="slateblue") 
})