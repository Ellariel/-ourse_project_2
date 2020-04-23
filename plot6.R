library(data.table)
library(ggplot2)

NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

#6)Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips=="06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

motor <- as.data.table(SCC[grepl("Vehicle", EI.Sector),])  ##extract motor Vehicle only
d<-NEI[(fips == "24510" | fips=="06037") & (SCC %in% motor$SCC),] #get city and filtering data
d$Emissions<-log10(d$Emissions)

BC<-d[fips == "24510"]
BC$fips <- "BC"
LAC<-d[fips == "06037"]
LAC$fips <- "LAC"

png(file = "plot6.png", width = 480, height = 480, bg = "transparent")

gg<-ggplot(d, aes(x=year, y=Emissions, fill=fips))
gg<-gg + labs(title="Compare Baltimore City & Los Angeles County", subtitle="from motor vehicle sources", y="log Emissions, tons", x="Year", caption="")
gg<-gg + scale_x_continuous(breaks=c(1999, 2002, 2005, 2008))
gg<-gg + geom_boxplot(data=BC, aes(group=year), position=position_nudge(0.3))
gg<-gg + geom_boxplot(data=LAC, aes(group=year))

print(gg)

dev.flush()
dev.off()