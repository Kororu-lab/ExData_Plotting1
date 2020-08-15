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
#Q2
png(filename = "plot2.png",width = 480, height = 480)
with(data2, plot(time2, GlobalActive, type = 'l',xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()