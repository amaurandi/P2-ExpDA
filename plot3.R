# plot 3
# read data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 
# Of the four TYPES of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in 
# EMISSIONS from 1999–2008 for BALTIMORE City? 
# Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

NEIB <- NEI[NEI$fips == "24510",] # only Baltimore

png("plot3.png")
g <- ggplot(NEIB, aes(year, Emissions))
g<- g + geom_line(stat = "summary", fun.y = "sum") + facet_grid(type ~ .)
g<- g + labs( title ="Emission in baltimore by Type")
g
dev.off()
