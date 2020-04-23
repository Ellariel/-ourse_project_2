library(data.table)
library(ggplot2)

NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
#SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

#3)Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
#Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.

d<-NEI[fips == "24510",] #get city
d$Emissions<-log10(d$Emissions)
m<-aggregate(Emissions ~ year+type, d, median, na.action = na.exclude) #get median

png(file = "plot3.png", width = 480, height = 480, bg = "transparent")

gg<-ggplot(d, aes(x=year, y=Emissions))
gg<-gg + labs(title="Emissions in Baltimore City", subtitle="by different types of source", y="log Emissions, tons", x="Year", caption="lines represent a median")
gg<-gg + scale_x_continuous(breaks=c(1999, 2002, 2005, 2008))
gg<-gg + geom_point(aes(col=type), size=2, alpha=0.7)
gg<-gg + geom_line(aes(linetype = type), m)

print(gg)

dev.flush()
dev.off()