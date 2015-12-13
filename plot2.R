# Script for creating plot2.png

# Load data.table function
library(data.table)

# Read in the data file into a data.table. Separate values by semicolons, include the header and turn ?s into NAs
dt <- fread("household_power_consumption.txt", sep=";", header = TRUE, na.strings = "?")

# Subset the data to only include entries that happened on Feb 1, 2007 and Feb 2, 2007
subdt <- subset(dt, between(as.Date(strptime(dt[,Date], format = "%d/%m/%Y")),"2007-02-01","2007-02-02"))

# Create a new column called timestamp that combines the Date and Time columns into a POSIXlt field.
subdt[,ts:=as.POSIXct(strptime(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"))]

# Open png device 
png("plot2.png",width = 480,height = 480)

# Plot the data
with(subdt, plot(ts,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)",main="",col = "black"))

# Close the device / Save the image.
dev.off()
