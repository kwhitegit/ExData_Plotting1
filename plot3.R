library(data.table)
library(dplyr)
library(lubridate)

if (!file.exists("household_power_consumption.txt")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "./exdata-data-household_power_consumption.zip") 
        unzip("./exdata-data-household_power_consumption.zip") }

if (!exists("PowerCons")) {
        PowerCons <- tbl_df(fread(input = "./household_power_consumption.txt", 
                                  showProgress = TRUE,
                                  na.strings = "?")) %>%
                mutate(datetime = dmy_hms(paste(Date,Time))) %>%
                mutate(Date = dmy(Date)) %>% 
                filter(Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))
}

attach(PowerCons)

png(file="plot3.png",width=480, height=480)
ylimit <- range(c(Sub_metering_1, Sub_metering_2, Sub_metering_3))
plot(datetime,Sub_metering_1, 
     type = "l", main = "", xlab = "", 
     ylim = ylimit, axes = TRUE,
     ylab = "Energy sub metering")
par(new = TRUE)
plot(Sub_metering_2, type = "l", main = "", xlab = "", 
     ylim = ylimit, axes = FALSE, col = "red",
     ylab = "")
par(new = TRUE)
plot(Sub_metering_3, type = "l", main = "", xlab = "", 
     ylim = ylimit, axes = FALSE, col = "blue",
     ylab = "")
par(new = FALSE)
legend(1875,39.5,
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),
       lwd=c(2.5,2.5,2.5),col=c("black","blue","red")) 
dev.off()

detach(PowerCons)