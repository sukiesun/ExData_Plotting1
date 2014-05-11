##read table
power <- read.table("household_power_consumption.txt", skip = 66637, nrow=2880, sep = ";", colClasses = "character", col.names = colnames(read.table("household_power_consumption.txt", nrow= 1, header = T, sep = ";")))
##check if date is 1/2/2007-2/2/2007
tail(power) 
head(power) 
## convert any "?" to "NA"
for( i in 1:9) {
        power[power[, i] == "?"] <- "NA"
}
## convert power measurements to numeric
for(i in 3:9){
        power[, i] <- as.numeric(power[, i])
}
## convert date and time, paste them together
power$MergedDate <- strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S")
## plot3
png(filename = "plot3.png", width = 480, height = 480)
with(power, plot(power$MergedDate, power$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering"))
lines(power$MergedDate, as.numeric(as.character(power$Sub_metering_2)), type = "l", col = "red")
lines(power$MergedDate, as.numeric(as.character(power$Sub_metering_3)), type = "l", col = "blue")
legend("topright", cex=0.8, lty = 1,col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
