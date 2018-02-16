# plot1
# read data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# str(NEI); head(NEI)
# str(SCC); head(SCC)

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

suma <- tapply( NEI$Emissions, NEI$year, sum )
png("plot1.png")
barplot(suma, main="emissions from PM2.5 in the United States from 1999 to 2008")
dev.off()

