# Solution to Question 5

## Subset the SCC data frame by the condition that whether the sourse contains "mobile"
SCC_sbst2_tmp <- SCC[grep("[[Mm]obile", SCC$SCC.Level.One),]
## Merge the two dataset, Sum them by years
MergeData2 <- merge(NEI_Baltimore, SCC_sbst2_tmp, by = 'SCC')
## Subset the dataset in condition 24510
MergeData2_YearTotal <- aggregate(Emissions ~ year, data = MergeData2, FUN = sum)
## Make a plot containing a line about annual emissions by year, indicating the trends
png("plot5.png")
with(MergeData2_YearTotal, plot(year, Emissions, type = "l", col = "green", xaxt = 'n'))
axis(side = 1, c(1999,2002,2005,2008))
title(main = "Annual PM2.5 Emissions of motor vehicle related sources in BC")
dev.off()
## Plot answering the Question 5 saved as PNG named plot5
## Answer to Question 5: No
print("Answer to Question 4: No")
## Part 5 ended