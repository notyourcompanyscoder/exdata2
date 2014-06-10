## Solution for Question 1
##
## Sum all the emissions from all sources, grouped by year
NEI_YrTtl <- aggregate(NEI$Emissions ~ NEI$year, FUN = sum)
names(NEI_YrTtl) <- c("year","Emissions")
## Make a plot containing a line about annual emissions by year, indicating the trends
png("plot1.png")
with(NEI_YrTtl, plot(year, Emissions, type = "l", col = "red", xaxt = 'n'))
axis(side = 1, c(1999,2002,2005,2008))
title(main = "Annual PM2.5 Emissions in the United States")
dev.off()
## Plot answering the Question 1 saved as PNG named plot1
## Answer to Question 1: Yes, the annual PM25 emission decreased from 1999 to 2008. 
print("Answer to Question 1:Yes, the annual PM25 emission decreased from 1999 to 2008.")
## Part 1 ended
