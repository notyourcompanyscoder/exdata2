## Load the necessary packages
library(ggplot2)

## Down data, Extract zip, and load data.
setwd("E:/Rdir/exdata2")
getwd()
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./exdata2.zip")
unzip("./exdata2.zip")
dir()
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

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

## Solution to Question 3
##
## Sum the Emissions in BC by year and types
NEI_Baltimore_YrTypeTtl <- aggregate(
        NEI_Baltimore$Emissions ~ NEI_Baltimore$year + NEI_Baltimore$type, FUN = sum)
names(NEI_Baltimore_YrTypeTtl) <- c("year","type","Emissions")

## Make a plot
png("plot3.png")
P <- ggplot(NEI_Baltimore_YrTypeTtl)
g <- P + geom_line(aes(x = unique(NEI_Baltimore_YrTypeTtl$year), 
                       y = subset(NEI_Baltimore_YrTypeTtl, type == 'NON-ROAD')$Emissions,
                       colour = 'red', size = 1.1)) + 
         geom_line(aes(x = unique(NEI_Baltimore_YrTypeTtl$year), 
                       y = subset(NEI_Baltimore_YrTypeTtl, type == 'NONPOINT')$Emissions,
                       colour = 'blue', size = 1.1)) +
         geom_line(aes(x = unique(NEI_Baltimore_YrTypeTtl$year), 
                       y = subset(NEI_Baltimore_YrTypeTtl, type == 'ON-ROAD')$Emissions,
                       colour = 'green', size = 1.1)) +
         geom_line(aes(x = unique(NEI_Baltimore_YrTypeTtl$year), 
                       y = subset(NEI_Baltimore_YrTypeTtl, type == 'POINT')$Emissions,
                       colour = 'purple', size = 1.1)) + 
         scale_x_continuous(breaks = c(1999,2002,2005,2008)) +
         labs(x = "Year", y = "Annually PM25 Emissions") +
         labs(title = "Annual PM25 Emissions in Baltimore, categorized by types") 
print(g)
rm(P)
dev.off()
## Except fot the type NONPOINT, all the other types of sources emissions had decreased
## Part 3 ended

## Solution to Question 4
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


## Solution to Question 5

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