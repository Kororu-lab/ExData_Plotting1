##for common setting
#loading dplyr
library(dplyr)

##Reading table with read.table()
colname <- c("Date", "Time", "GlobalActive", "GlobalReactive", "Voltage", "GlobalIntensity", "Sub1", "Sub2", "Sub3")
data1 <- read.table("household_power_consumption.txt", sep = ";", col.names = colname, skip = 1)

##Cutting out data between 2007-02-01 and 2007-02-02
data2 <- filter(data1, Date == "1/2/2007" | Date == "2/2/2007")

##And adding time order as $time2
data2$time2 <- paste(data2$Date,data2$Time)
data2$time2 <- strptime(data2$time2, "%d/%m/%Y %H:%M:%S", tz = "UTC")

##Changing other columm into numeric;

for(i in 3:9){
    data2[,i] <- as.numeric(data2[,i])
}

###########################################################################
#Q4
png(filename = "plot4.png",width = 480, height = 480)
##dividing windows into 4 section using par/mfrow
par(mfrow = c(2,2))

##4_1(Same as Q2)
with(data2, plot(time2, GlobalActive, type = 'l',xlab = "", ylab = "Global Active Power"))
##4_2
with(data2, plot(time2, Voltage, xlab = "datetime", ylab = "Voltage", type = 'l'))
##4_3(Same as Q3)
with(data2, plot(time2, Sub1, type = 'l', xlab = "", ylab = "Energy sub metering"))
lines(data2$time2, data2$Sub2, type = 'l', col = "red")
lines(data2$time2, data2$Sub3, type = 'l', col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, cex = 1, bty = "n")
##4_4
with(data2, plot(time2, GlobalReactive ,xlab = "datetime" ,ylab = "Global_reactive_power", type = 'l'))
dev.off()