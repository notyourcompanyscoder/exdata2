
## Solution for Question 2
##
## Subset the NEI dataset by condition that source is from Baltimore City (fips == "24510")
NEI_Baltimore <- subset(NEI, fips == "24510")
## Sum all the emissions from all sources, grouped by year
NEI_Baltimore_YrTtl <- aggregate(NEI_Baltimore$Emissions ~ NEI_Baltimore$year, FUN = sum)
names(NEI_Baltimore_YrTtl) <- c("year","Emissions")
## Make a plot containing a line about annual emissions by year, indicating the trends
png("plot2.png")
with(NEI_Baltimore_YrTtl, plot(year, Emissions, type = "l", col = "blue", xaxt = 'n'))
axis(side = 1, c(1999,2002,2005,2008))
title(main = "Annual PM2.5 Emissions in Baltimore City, Maryland (fips = 24510)")
dev.off()
## Plot answering the Question 1 saved as PNG named plot2
## Answer to Question 2: No, the annual PM25 emission hadn't decrease constantly from 1999 to 2008
print("Answer to Question 2: No, the annual PM25 emission hadn't decrease constantly from 1999 to 2008")
## Part 2 ended