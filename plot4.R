library(sqldf)
library(data.table)
# Read in the data and change the column names to work for sqldf
HCP <- read.table("household_power_consumption.txt", header = TRUE, sep=";", col.names = c("Date","Time","GlobalActivePower","GlobalReactivePower","Voltage","GlobalIntensity","SubMetering1","SubMetering2","SubMetering3"), stringsAsFactors = FALSE)

# Subset the parts with the required dates
subsettedData <- sqldf("select * from HCP where Date = '1/2/2007' or Date = '2/2/2007'")

# Get the GAP
GAP <- as.numeric(subsettedData$GlobalActivePower)

# Get GRP
GRP <- as.numeric(subsettedData$GlobalReactivePower)

# Subset the dates and times
dates <- strptime(paste(subsettedData$Date,subsettedData$Time), "%d/%m/%Y %H:%M:%S")

# Get each of the submetering data columns seperately
subMetering1 <- as.numeric(subsettedData$SubMetering1)
subMetering2 <- as.numeric(subsettedData$SubMetering2)
subMetering3 <- as.numeric(subsettedData$SubMetering3)

# Get the Voltage
Voltage <- as.numeric(subsettedData$Voltage)

# Create the plot and png
png("plot4.png", height = 480, width = 480)

par(mfrow = c(2,2))

plot(dates, GAP, type = "l", xlab = "", ylab = "Global Active Power")

plot(dates, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(dates, subMetering1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(dates, subMetering2, type = "l", col = "red")
lines(dates, subMetering3, type = "l", col = "blue")
legend("topright", legend = c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"), lty = 1, col = c("black","red","blue"))

plot(dates, GRP, type = "l", xlab = "datetime", ylab = "Global_Reactive_Power")

dev.off()