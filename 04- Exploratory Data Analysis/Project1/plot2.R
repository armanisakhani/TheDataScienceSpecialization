data <- read.table(file = "household_power_consumption.txt" ,nrow = 5 , sep = ";" , header = T)
data <- read.table(file = "household_power_consumption.txt" , sep = ";" ,
                   header = T , col.names = colnames(data) )

data$Date <- as.Date(as.character(data$Date) , format = "%d/%m/%Y")
data <- data[(1:nrow(data))[ data$Date == as.Date("2007-02-01") |
                                   data$Date == as.Date("2007-02-02")] , ]
data$datetime <- as.POSIXct(paste(data$Date, data$Time, sep = "-"), format = "%Y-%m-%d-%X")

## Creat plot2.png
data$Global_active_power <- as.numeric(as.character(data$Global_active_power) )
png(filename = "plot2.png" , width = 480 , height = 480)
with(data = data, plot(datetime, Global_active_power, type = "n", ylab = "Global Active Power (killowatts)", xlab = ""))
lines(x = data$datetime, y = data$Global_active_power, type = "l")
dev.off()
