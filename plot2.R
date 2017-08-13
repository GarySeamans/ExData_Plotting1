library(sqldf)
library(data.table)
# Read in the data and change the column names to work for sqldf
HCP <- read.table("household_power_consumption.txt", header = TRUE, sep=";", col.names = c("Date","Time","GlobalActivePower","GlobalReactivePower","Voltage","GlobalIntensity","SubMetering1","SubMetering2","SubMetering3"), stringsAsFactors = FALSE)

# Subset the parts with the required dates
subsettedData <- sqldf("select * from HCP where Date = '1/2/2007' or Date = '2/2/2007'")

# Get the GAP
GAP <- as.numeric(subsettedData$GlobalActivePower)

# Subset the dates and times
dates <- strptime(paste(subsettedData$Date,subsettedData$Time), "%d/%m/%Y %H:%M:%S")

# Create the plot and png
png("plot2.png", height = 480, width = 480)
plot(dates, GAP, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()