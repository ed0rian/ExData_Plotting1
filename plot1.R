## Construct Plot 1 for Exploratory Data Analysis, Course Project 1

## Library needed for fread
library(data.table)

## Calculate the number of rows (minutes) to be read
dRows <-    as.numeric(difftime(as.POSIXct("2007-02-03"), 
                                as.POSIXct("2007-02-01"),
                                units="mins"
                       )
            )
## Only read the rows for two days, skipping everything before the first date
data <-     fread("household_power_consumption.txt", 
                  skip="1/2/2007", 
                  nrows = dRows, 
                  na.strings = c("?", "")
            )

## Since the first line was also skipped in fread the columns must be correctly
## named again
setnames(data, 1, "Date")
setnames(data, 2, "Time")
setnames(data, 3, "Global_active_power")
setnames(data, 4, "Global_reactive_power")
setnames(data, 5, "Voltage")
setnames(data, 6, "Global_intensity")
setnames(data, 7, "Sub_metering_1")
setnames(data, 8, "Sub_metering_2")
setnames(data, 9, "Sub_metering_3")

## Combine Day and Time into one single variable, not needed in plot 1
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

## Redirect graphic output to a file of given type, name, size 
## and backhround colour
png(filename = "plot1.png",
    width = 480, 
    height = 480,
    bg = "transparent"
)

## Construct histogram with given colour and title / axis names
hist(data$Global_active_power, 
     col = "Red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)"
)

## Close graphic file
dev.off()
