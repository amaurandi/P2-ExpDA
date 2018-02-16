# plot 4
# read data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Across the United States, how have emissions from 
# coal combustion-related sources changed from 1999–2008?
  
library(ggplot2)


table(SCC$EI.Sector)
str(SCC$EI.Sector)
levels(SCC$EI.Sector)
casosconcoal <- grepl("coal", SCC$EI.Sector, ignore.case = TRUE)
SCCCoal <- SCC[casosconcoal,] # casos con coal
# Merge datasets to add year
NEISCC <- merge (NEI, y = SCCCoal, by = 'SCC')
suma <- tapply( NEISCC$Emissions, NEISCC$year, sum )
# str(suma)
dfsuma <- as.data.frame(suma)
dfsuma <- data.frame(year=rownames(dfsuma), dfsuma)
names(dfsuma)<- c("years", "emissions")

png("plot4.png")
g <- ggplot(dfsuma , aes(x = years, y = emissions)) 
g <- g + geom_line(aes(group = 1)) 
g <- g + labs(title= "emissions from coal combustion-related sources from 1999–2008")
g <- g + geom_point() 
g
dev.off()

