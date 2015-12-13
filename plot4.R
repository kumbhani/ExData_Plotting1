# Script for creating plot4.png

# Load data.table function
library(data.table)

# Read in the data file into a data.table. Separate values by semicolons, include the header and turn ?s into NAs
dt <- fread("household_power_consumption.txt", sep=";", header = TRUE, na.strings = "?")

# Subset the data to only include entries that happened on Feb 1, 2007 and Feb 2, 2007
subdt <- subset(dt, between(as.Date(strptime(dt[,Date], format = "%d/%m/%Y")),"2007-02-01","2007-02-02"))

# Create a new column called timestamp that combines the Date and Time columns into a POSIXlt field.
subdt[,ts:=as.POSIXct(strptime(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"))]

# Open png device 
png("plot4.png",width = 480,height = 480)

# Set up the plotting layout for 2x2 (create in row format)
par(mfrow=c(2,2))

# Subplot 1
with(subdt, plot(ts,Global_active_power,type="l",xlab="",ylab="Global Active Power",main="",col = "black"))

# Subplot 2
with(subdt, plot(ts,Voltage,type="l",xlab="datetime",ylab="Voltage",main="",col = "black"))

# Subplot 3
with(subdt, plot(ts,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",main="",col = "black"))
with(subdt, lines(ts,Sub_metering_2,type="l",col = "red"))
with(subdt, lines(ts,Sub_metering_3,type="l",col = "blue"))
legend("topright",bty = "n", lty = c(1,1,1), col=c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Subplot 4
with(subdt, plot(ts,Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power",main="",col = "black"))

# Close the device / Save the image.
dev.off()
