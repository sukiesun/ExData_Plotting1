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
## plot1
hist(power$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)") 
dev.copy(png, file = "plot1.png")
dev.off()