fh <- "household_power_consumption.txt"
ba <- read.table(text = grep("^[1,2]/2/2007", readLines(fh), value = TRUE), 
                 col.names = c("Date", "Time", "Global_active_power", 
                               "Global_reactive_power", "Voltage",
                               "Global_intensity", "Sub_metering_1","Sub_metering_2",
                               "Sub_metering_3"), sep = ";", header = TRUE)
ba$Date <- as.Date(ba$Date, "%d/%m/%Y")
ba <- ba[complete.cases(ba),]
dateTime <- paste(ba$Date, ba$Time)
library(dplyr)
ba <- select(ba, -c(Date,Time))
ba <- mutate(ba, DateTime = as.POSIXct(dateTime))
plot(ba$DateTime, ba$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.copy(png, "plot2.png", width=480, height=480)
dev.off()