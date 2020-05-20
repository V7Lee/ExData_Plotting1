fh <- "household_power_consumption.txt"
ba <- read.table(text = grep("^[1,2]/2/2007", readLines(fh), value = TRUE), 
                 col.names = c("Date", "Time", "Global_active_power", 
                               "Global_reactive_power", "Voltage",
                               "Global_intensity", "Sub_metering_1","Sub_metering_2",
                               "Sub_metering_3"), sep = ";", header = TRUE)
with(ba, hist(Global_active_power, main = "Global Active Power", col = "red", 
     xlab = "Global Active Power (Kilowatts)"))
dev.copy(png, "plot1.png", width=480, height=480)
dev.off()