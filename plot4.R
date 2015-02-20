#Author: Esmit Pérez
#Date: Feb 16 2015
#Exploratory Data Analysis on Coursera - exdata-011

#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
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

# Find out all coal related sources
# ONLY the ones matching "Coal" anywhere in its short name are filtered in.
coalSourceCode <- SCC[grep("Coal",SCC$Short.Name),]$SCC

# filter the original data, using just this
coalCombustionData <- projectData[projectData$SCC %in% coalSourceCode,]

plot4Data <- aggregate(Emissions ~ year, coalCombustionData, sum)

png(filename = "plot4.png", width = 480, height = 480)

with (plot4Data, {
        plot(Emissions/1000 ~ year , type="o", xlab="Year", ylab="Emissions (in thousands of tons)", 
             lwd=3, lty="solid", col="coral3", col.lab="navajowhite4", 
             main = "Total emissions in the U.S. from\nCoal Combustion related sources, 1999-2008") 
        abline(lm(Emissions/1000 ~ year), lwd=2, lty="dashed", col="slateblue") 
        axis(side = 1, at = 1999:2008)
})

dev.off()