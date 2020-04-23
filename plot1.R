library(data.table)

NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
#SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

#1)Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
a<-aggregate(Emissions ~ year, NEI, sum, na.action = na.exclude) #tapply(data$Emissions, data$year, sum)

png(file = "plot1.png", width = 480, height = 480, bg = "transparent")

plot(a, type = "l", xaxt="n", ylab = "Total Emissions, tons", xlab = "Year", main = "United States")
axis(side=1,at=a[,1])

dev.flush()
dev.off()