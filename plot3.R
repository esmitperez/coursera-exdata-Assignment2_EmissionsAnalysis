#Author: Esmit Pérez
#Date: Feb 16 2015
#Exploratory Data Analysis on Coursera - exdata-011

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

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

plot3Data <- projectData[projectData$fips=="24510",]

baltimoreData <- aggregate(Emissions ~ year * type, plot3Data, sum)
#png(filename = "plot3.png", width = 480, height = 480)

# Customizations based on http://zevross.com/blog/2014/08/04/beautiful-plotting-in-r-a-ggplot2-cheatsheet-3/#working-with-the-legend
g <- ggplot(data = baltimoreData) 
g <- g + geom_line(aes(x=year, y=Emissions, color="Emissions"))
g <- g + geom_point(aes(x=year, y=Emissions, color="Emissions"))
g <- g + facet_wrap(~type) 
g <- g + stat_smooth(method="lm", aes(x=year, y=Emissions, color="Tendency"))
g <- g + ggtitle("Total emissions for Baltimore City, 1999-2008") + ylab("Emissions (in tons)") + xlab("Years")
g <- g + theme_bw() + theme(legend.key = element_blank())
# Map our aes colors to real colors
g <- g + scale_colour_manual(name='', values=c('Emissions'='coral3', 'Tendency'='slateblue'))
g <- g + guides(colour = guide_legend(override.aes = list(linetype=c(1,1), shape=c(16,NA))))
g <- g + scale_x_continuous(breaks=c(1999,2002,2005,2008))
g
ggsave(file="plot3.png", width=8, height=4, dpi=100)
#dev.off()