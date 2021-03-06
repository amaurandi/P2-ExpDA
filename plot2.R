# plot 2
# read data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.
# 

NEIB <- NEI[NEI$fips == "24510",] # oly Baltimore
suma <- tapply( NEIB$Emissions, NEIB$year, sum )
png("plot2.png")
barplot(suma, main="emissions from PM2.5 in Baltimore from 1999 to 2008")
dev.off()



