library(data.table)

NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
#SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

#2)Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
#Use the base plotting system to make a plot answering this question.
a<-aggregate(Emissions ~ year, NEI[fips == "24510",], sum, na.action = na.exclude)

png(file = "plot2.png", width = 480, height = 480, bg = "transparent")

plot(a, type = "l", xaxt="n", ylab = "Total Emissions, tons", xlab = "Year", main = "Baltimore City, Maryland")
axis(side=1,at=a[,1])

dev.flush()
dev.off()