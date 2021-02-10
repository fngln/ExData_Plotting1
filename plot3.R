data <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
Date <- as.Date(data$Date, "%d/%m/%Y")
data <- cbind(Date, data[,2:9])
data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

library(dplyr)
data <- data %>% mutate("datetime"=paste(Date, Time),.before=Date) 
data <- cbind(strptime(data[,1], "%Y-%m-%d %H:%M:%S"), as.data.frame(lapply(data[,4:10],as.numeric)))
colnames(data)[1] <- "datetime"

png(file="plot3.png")
with(data, plot(Sub_metering_1~datetime, type="n",ylab="Energy sub metering",xlab=""))
with(data, points(Sub_metering_1~datetime, type="l",col="black"))
with(data, points(Sub_metering_2~datetime, type="l",col="red"))
with(data, points(Sub_metering_3~datetime, type="l",col="blue"))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1, col=c("black","red","blue"))
dev.off()