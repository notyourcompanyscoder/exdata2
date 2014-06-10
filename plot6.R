
NEI_LACounty <- subset(NEI, NEI$fips == '06037')
MergeData3 <- merge(NEI_LACounty, SCC_sbst2_tmp, by = 'SCC')
MergeData3_YearTotal <- aggregate(Emissions ~ year, data = MergeData3, FUN = sum)

## Solution for Question 6
## Make a plot
png("plot6.png")
P <- ggplot(MergeData2_YearTotal)
g <-P + geom_line(aes(x = MergeData3_YearTotal$year, 
                      y = MergeData3_YearTotal$Emission, colour = "red"), size=1.3) + 
        geom_line(aes(x = MergeData2_YearTotal$year, 
                      y = MergeData2_YearTotal$Emission, colour = "blue"), size=1.3) +
        scale_x_continuous(breaks = c(1999,2002,2005,2008)) +
        labs(x = "Year", y = "Annually PM25 Emissions") +
        labs(title = "Annual PM25 Emissions in Baltimore, categorized by types") 
print(g)
dev.off()
## The changes in two cities are partially equal
## Part 6 ended