# Solution to Question 3
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