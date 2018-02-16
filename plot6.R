# plot 6
# read data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, 
# California (fips == "06037"). Which city has seen greater changes
# over time in motor vehicle emissions?


library(ggplot2)

casosMovile <- grepl("Mobile", SCC$EI.Sector, ignore.case = TRUE)
SCCMobile <- SCC[casosMovile,] # casos con mobile

NEIBLA <- NEI[(NEI$fips == "24510"| NEI$fips == "06037"),] # only Baltimore or LA
# Merge datasets to add year
NEISCC <- merge (NEIBLA, y = SCCMobile, by = 'SCC') #only baltimore and LAConty and mobile (motor vehicle)

#LAconty
data <- NEISCC[NEISCC$fips == "06037",] 
suma <- tapply( data$Emissions, data$year, sum )
# str(suma)
dfsuma <- as.data.frame(suma)
dfsuma <- data.frame(year=rownames(dfsuma), dfsuma, place="LA Conty")
names(dfsuma)<- c("years", "emissions", "place")
LA<-dfsuma
# Baltimore
data <- NEISCC[NEISCC$fips == "24510",] 
suma <- tapply( data$Emissions, data$year, sum )
# str(suma)
dfsuma <- as.data.frame(suma)
dfsuma <- data.frame(year=rownames(dfsuma), dfsuma, place="Baltimore")
names(dfsuma)<- c("years", "emissions", "place")
BA<-dfsuma
data<- rbind(LA, BA)

png("plot6.png")
g <- ggplot(data , aes(x = years, y = emissions)) 
g <- g + geom_line(aes(group = place, color=place))
g <- g + labs(title= "Emissions from Mobile  sources in Baltimore and LA County from 1999–2008")
g <- g + geom_point() 
g
dev.off()
