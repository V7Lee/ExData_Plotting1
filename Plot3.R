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
with(ba, {plot(Sub_metering_1 ~ DateTime, type = "l", ylab = "Global Avtive Power (kilowatts)", 
     xlab = "")
        lines(Sub_metering_2 ~ DateTime, col = "Red")
        lines(Sub_metering_3 ~ DateTime, col = "Blue")
})
legend(x = "topright", col = c("black", "red", "blue"), legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"), lty = 1, lwd = 2)
dev.copy(png, "plot3.png", height=480, width=480)
dev.off()
