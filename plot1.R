#Author: Esmit Pérez
#Date: Feb 16 2015
#Exploratory Data Analysis on Coursera - exdata-011

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999,
# 2002, 2005, and 2008.

# Note, as.factor(projectData$year) says those are the years in the data already, so using whole data set

zipFilename <- "exdata-data-NEI_data.zip"

if ( !file.exists(zipFilename)){
        message("Downloading file...")
        download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", 
                      destfile = zipFilename, 
                      method = "curl",)    
        
}else{
        message("Zip file already downloaded.")
}
if (!file.exists("summarySCC_PM25.rds")){
        message("Unzipping data .zip...")
        unzip(zipfile = zipFilename)
}else{
        message("Data file already unzipped.")
}

if (!exists("projectData")){
        message("Creating data structures from files...")
        ## This first line will likely take a few seconds. Be patient!
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")
        projectData <- merge(NEI,SCC, by = "SCC")
}else{
        message("Project Data already in environment :)")
}

########### Plotting code ########### 

plot1Data <- aggregate(Emissions ~ year, projectData, sum)

png(filename = "plot1.png", width = 480, height = 480)

with (plot1Data, {
        plot(Emissions/1000 ~ year , type="o", xlab="Year", ylab="Emissions (in thousands of tons)", 
             lwd=3, lty="solid", col="coral3", col.lab="navajowhite4", 
             main = "Total emissions in the United States, 1999-2008") 
        abline(lm(Emissions/1000 ~ year), lwd=2, lty="dashed", col="slateblue") 
        axis(side = 1, at = 1999:2008)
})

dev.off()