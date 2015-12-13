# Script for creating plot1.png

# Load data.table function
library(data.table)

# Read in the data file into a data.table. Separate values by semicolons, include the header and turn ?s into NAs
dt <- fread("household_power_consumption.txt", sep=";", header = TRUE, na.strings = "?")

# Subset the data to only include entries that happened on Feb 1, 2007 and Feb 2, 2007
subdt <- subset(dt, between(as.Date(strptime(dt[,Date], format = "%d/%m/%Y")),"2007-02-01","2007-02-02"))

# Open png device 
png("plot1.png",width = 480,height = 480)

# Plot the data
hist(subdt[,Global_active_power],xlab = "Global Active Power (kilowatts)",main = "Global Active Power",col = "red")

# Close the device / Save the image.
dev.off()
