#Author: Esmit Pérez
#Date: Feb 16 2015
#Exploratory Data Analysis on Coursera - exdata-011

# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
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

plot2Data <- aggregate(Emissions ~ year, projectData[projectData$fips=="24510",], sum)

png(filename = "plot2.png", width = 480, height = 480)

with (plot2Data, {
        plot(Emissions ~ year, 
             type="o", xlab="Year", ylab="Emissions (in tons)", 
             lwd=3, lty="solid", col="coral3", col.lab="navajowhite4", 
             main = "Total emissions in Baltimore City, 1999-2008") 
        abline(lm(Emissions ~ year), lwd=2, lty="dashed", col="slateblue") 
        axis(side = 1, at = 1999:2008)
})

dev.off()