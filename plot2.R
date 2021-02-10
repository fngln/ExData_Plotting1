data <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
Date <- as.Date(data$Date, "%d/%m/%Y")
data <- cbind(Date, data[,2:9])
data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

library(dplyr)
data <- data %>% mutate("datetime"=paste(Date, Time),.before=Date) 
data <- cbind(strptime(data[,1], "%Y-%m-%d %H:%M:%S"), as.data.frame(lapply(data[,4:10],as.numeric)))
colnames(data)[1] <- "datetime"

png(file="plot2.png")
with(data, plot(Global_active_power~datetime,type="l",ylab="Global Active Power (kilowatts)",xlab=""))
dev.off()