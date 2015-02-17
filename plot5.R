#Author: Esmit Pérez
#Date: Feb 16 2015
#Exploratory Data Analysis on Coursera - exdata-011

#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

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
motorVehicleSourceCode <- SCC[grep("Motor Vehicle",SCC$Short.Name),]$SCC

# filter the original data, using just this
motorVehiclesDataBaltimore <- projectData[projectData$SCC %in% motorVehicleSourceCode & projectData$fips=="24510",]

plot5Data <- aggregate(Emissions ~ year, motorVehiclesDataBaltimore, sum)

png(filename = "plot5.png", width = 480, height = 480)

with (plot5Data, {
        plot(Emissions ~ year , xlim = c(1999,2010), type="o", xlab="Year", ylab="Emissions (in tons)", 
             lwd=3, lty="solid", col="coral3", col.lab="navajowhite4", 
             main = "Total emissions from Motor Vehicle sources,\n in the United States, 1999-2008")
        abline(lm(Emissions ~ year), lwd=2, lty="dashed", col="slateblue") 
        axis(side = 1, at = 1999:2008)
})

# close the device, this "dumps" the graph into the physical file.
dev.off()
