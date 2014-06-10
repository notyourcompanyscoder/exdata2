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
