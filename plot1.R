#Author: Esmit Pérez
#Date: Feb 16 2015
#Exploratory Data Analysis on Coursera - exdata-011

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999,
# 2002, 2005, and 2008.

# Note, as.factor(projectData$year) says those are the years in the data already, so using whole data set

plot1Data <- aggregate(Emissions ~ year, projectData, sum)

with (plot1Data, {
        plot(Emissions/1000 ~ year , type="o", xlab="Year", ylab="Total emissions (in thousands of tons)", lwd=3, lty="solid", col="coral3", col.lab="navajowhite4", main = "Total emissions from PM2.5, from 1999 to 2008") 
        abline(lm(Emissions/1000 ~ year), lwd=2, lty="dashed", col="slateblue") 
})