# plot 5
# read data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


library(ggplot2)


# table(SCC$EI.Sector)
# str(SCC$EI.Sector)
# levels(SCC$EI.Sector)
casosMovile <- grepl("Mobile", SCC$EI.Sector, ignore.case = TRUE)
SCCMobile <- SCC[casosMovile,] # casos con mobile
NEIB <- NEI[NEI$fips == "24510",] # only Baltimore
# Merge datasets to add year
NEISCC <- merge (NEIB, y = SCCMobile, by = 'SCC') #only baltimore and mobile (motor vehicle)
suma <- tapply( NEISCC$Emissions, NEISCC$year, sum )
# str(suma)
dfsuma <- as.data.frame(suma)
dfsuma <- data.frame(year=rownames(dfsuma), dfsuma)
names(dfsuma)<- c("years", "emissions")

png("plot5.png")
g <- ggplot(dfsuma , aes(x = years, y = emissions)) 
g <- g + geom_line(aes(group = 1)) 
g <- g + labs(title= "Emissions from Mobile  sources in Baltimore  from 1999–2008")
g <- g + geom_point() 
g
dev.off()
# rm(g)
