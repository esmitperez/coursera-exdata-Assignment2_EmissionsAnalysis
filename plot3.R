#Author: Esmit Pérez
#Date: Feb 16 2015
#Exploratory Data Analysis on Coursera - exdata-011

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

plot3Data <- projectData[projectData$fips=="24510",]

baltimoreData <- aggregate(Emissions ~ year * type, plot3Data, sum)

# Customizations based on http://zevross.com/blog/2014/08/04/beautiful-plotting-in-r-a-ggplot2-cheatsheet-3/#working-with-the-legend
g <- ggplot(data = baltimoreData) 
g <- g + geom_line(aes(x=year, y=Emissions, color="Emissions"))
g <- g + geom_point(aes(x=year, y=Emissions, color="Emissions"))
g <- g + facet_wrap(~type) 
g <- g + stat_smooth(method="lm", aes(x=year, y=Emissions, color="Tendency"))
g <- g + ggtitle("Total emissions for Baltimore City") + ylab("Emissions (in tons)") + xlab("Years")
g <- g + theme_bw() + theme(legend.key = element_blank())
# Map our aes colors to real colors
g <- g + scale_colour_manual(name='', values=c('Emissions'='coral3', 'Tendency'='slateblue'))
g <- g + guides(colour = guide_legend(override.aes = list(linetype=c(1,1), shape=c(16,NA))))
g
