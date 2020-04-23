library(data.table)
library(ggplot2)

NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

#5)How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

motor <- as.data.table(SCC[grepl("Vehicle", EI.Sector),])  ##extract motor Vehicle only
d<-NEI[(fips == "24510") & (SCC %in% motor$SCC),] #get city and filtering data
d$Emissions<-log10(d$Emissions)

png(file = "plot5.png", width = 480, height = 480, bg = "transparent")

gg<-ggplot(d, aes(x=year, y=Emissions))
gg<-gg + labs(title="Emissions in Baltimore City", subtitle="from motor vehicle sources", y="log Emissions, tons", x="Year", caption="")
gg<-gg + scale_x_continuous(breaks=c(1999, 2002, 2005, 2008))
gg<-gg + geom_boxplot(aes(group=year))

print(gg)

dev.flush()
dev.off()