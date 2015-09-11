data <- read.table(file = "household_power_consumption.txt" ,nrow = 5 , sep = ";" , header = T)
data <- read.table(file = "household_power_consumption.txt" , sep = ";" ,
                   header = T , col.names = colnames(data) )

data$Date <- as.Date(as.character(data$Date) , format = "%d/%m/%Y")
data <- data[(1:nrow(data))[ data$Date == as.Date("2007-02-01") |
                                   data$Date == as.Date("2007-02-02")] , ]
data$datetime <- as.POSIXct(paste(data$Date, data$Time, sep = "-"), format = "%Y-%m-%d-%X")

## Creat plot3.png
png(filename = "plot3.png" , width = 480 , height = 480)
with(data = data, plot(datetime, as.numeric(as.character(Sub_metering_1)), type = "n",
                       ylab = "Energy sub metering", xlab = ""))
with(data , lines(datetime, as.numeric(as.character(Sub_metering_1)), type = "l" , col = "black"))
with(data , lines(datetime, as.numeric(as.character(Sub_metering_2)), type = "l" , col = "red"))
with(data , lines(datetime, as.numeric(as.character(Sub_metering_3)), type = "l" , col = "blue"))
legend("topright", pch = "-", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
