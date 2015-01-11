## Construct Plot 4 for Exploratory Data Analysis, Course Project 1

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

## Combine Day and Time into one single variable
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

## Ensure that the names of the weekdays are given in English
Sys.setlocale("LC_TIME", "C")

## Redirect graphic output to a file of given type, name, size 
## and backhround colour
png(filename = "plot4.png",
    width = 480, 
    height = 480,
    bg = "transparent"
)

## DraW 4 plots, arranged in a 2x2 array
par(mfrow = c(2, 2))

## Subplot 1
## Same as Plot 2, except the shorter y-label
plot(data$DateTime,
     data$Global_active_power, 
     type = "l", 
     xlab = "",
     ylab = "Global Active Power"
)

## Subplot 2
## Voltage vs. time
with(data, plot(DateTime, 
                Voltage,
                type = "l", 
                col = "black",
                xlab = "datetime",
                ylab = "Voltage"
           )
)

## Subplot 3
## Same as Plot 3, except the missing box around the legend
with(data, plot(DateTime, 
                Sub_metering_1,
                type = "l", 
                col = "black",
                xlab = "",
                ylab = "Energy sub metering"
           )
)
with(data, lines(DateTime, 
                 Sub_metering_2,
                 col = "red"
           )
)
with(data, lines(DateTime, 
                 Sub_metering_3,
                 col = "blue"
           )
)
legend("topright",
       bty = "n",
       lty = c(1, 1, 1),
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"
                )
)

## Subplot 4
## Global reactive power vs. time
with(data, plot(DateTime, 
                Global_reactive_power,
                type = "l", 
                col = "black",
                xlab = "datetime",
                ylab = "Global_reactive_power"
           )
)

## Close graphic file
dev.off()
