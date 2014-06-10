# Solution to Question 4
SCC$Data.Category <- toupper(SCC$Data.Category)
## Subset the SCC_short data frame by the condition that whether the sourse contains "coal" and "conbustion"
SCC_sbst1 <- SCC[intersect(grep("[Cc]ombustion", SCC$SCC.Level.One),
                           grep("[Cc]oal", SCC$SCC.Level.Four)),]
## Merge the two dataset, Sum them by years
MergeData1 <- merge(NEI, SCC_sbst1, by = 'SCC')
MergeData1_YearTotal <- aggregate(Emissions ~ year, data = MergeData1, FUN = sum)
## Make a plot containing a line about annual emissions by year, indicating the trends
png("plot4.png")
with(MergeData1_YearTotal, plot(year, Emissions, type = "l", col = "green", xaxt = 'n'))
axis(side = 1, c(1999,2002,2005,2008))
title(main = "Annual PM2.5 Emissions of coal conbustion related sources")
dev.off()
## Plot answering the Question 4 saved as PNG named plot4
## Answer to Question 4: Yes
print("Answer to Question 4: Yes")
## Part 4 ended