library(data.table)
library(ggplot2)

NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

#4)Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

coal <- as.data.table(SCC[grepl("Coal", Short.Name)&grepl("Comb", EI.Sector),])  ##extract coal combustion only
d<-NEI[SCC %in% coal$SCC,] #filtering data
d$Emissions<-log10(d$Emissions)

png(file = "plot4.png", width = 480, height = 480, bg = "transparent")

gg<-ggplot(d, aes(x=year, y=Emissions))
gg<-gg + labs(title="Emissions in Unated States", subtitle="from coal combustion-related sources", y="log Emissions, tons", x="Year", caption="")
gg<-gg + scale_x_continuous(breaks=c(1999, 2002, 2005, 2008))
gg<-gg + geom_boxplot(aes(group=year))

print(gg)

dev.flush()
dev.off()