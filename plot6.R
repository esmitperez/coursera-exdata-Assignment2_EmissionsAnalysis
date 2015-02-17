#Author: Esmit Pérez
#Date: Feb 16 2015
#Exploratory Data Analysis on Coursera - exdata-011

#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

#Author: Esmit Pérez
#Date: Feb 16 2015
#Exploratory Data Analysis on Coursera - exdata-011

#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
library(ggplot2)
library(gridExtra)
library(scales)  

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

# Find out all coal related sources
# ONLY Short Names containing the exact substring "Motor Vehicle" are taken in account
motorVehicleSourceCode <- SCC[grep("Motor Vehicle",SCC$Short.Name),]$SCC

# filter the original data, using just this
motorVehiclesDataBaltimore <- projectData[projectData$SCC %in% motorVehicleSourceCode & projectData$fips=="24510",]
motorVehiclesDataCalifornia <- projectData[projectData$SCC %in% motorVehicleSourceCode & projectData$fips=="06037",]

plot5DataMD <- aggregate(Emissions ~ year, motorVehiclesDataBaltimore, sum)
plot5DataLA <- aggregate(Emissions ~ year, motorVehiclesDataCalifornia, sum)
plot5DataMD$City <- "Baltimore"
plot5DataLA$City <- "Los Angeles"

allData = rbind(plot5DataMD, plot5DataLA)

g <- ggplot(data = allData) 
g <- g + geom_line(aes(x=year, y=Emissions, group=City, color=City, width=5))
g <- g + geom_point(aes(x=year, y=Emissions, group=City, color=City))
g <- g + ggtitle("Total emissions for Baltimore and Los Angeles\n1999-2008") + ylab("Emissions (in tons)") + xlab("Years")
g <- g + scale_x_continuous(breaks=c(1999,2002,2005,2008))
g <- arrangeGrob(g, sub = textGrob("Note: Only measurements with sources explicitly containing 'Motor Vehicle' in their name were used", x = 0, hjust = -0.1, vjust=0.1, gp = gpar(fontface = "italic", fontsize = 18)))

ggsave(file="plot6.png", width=8, height=4)