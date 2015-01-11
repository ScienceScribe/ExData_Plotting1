#read the unzipped data file into R
electrical <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")

#convert Date column from factor to character
electrical$Date <- as.character(electrical$Date)

#select data from 01/02/2007 to 02/02/2007
electrical_subset <- subset(electrical, Date == "1/2/2007" | Date == "2/2/2007")

#convert "Global_active_power" column to numeric
electrical_subset$Global_active_power <- as.numeric(as.character
                                                    (electrical_subset$Global_active_power))

#create new column in which "Date" and "Time" column contents are concatenated
electrical_subset$DateTime <- paste(electrical_subset$Date, 
                                    electrical_subset$Time)

#convert DateTime column from character to Date-time class
electrical_subset$DateTime <- strptime(electrical_subset$DateTime, "%d/%m/%Y %H:%M:%S")

#open PNG device, with assumption that background (argument "bg") is "white", not "transparent"
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")

#set graphical parameters
par(mfcol = c(2, 2), cex=0.79, mar=c(5, 4, 4, 2))

#make plots
with(electrical_subset, {
  plot(electrical_subset$DateTime, electrical_subset$Global_active_power,
       type="l", xlab=NA, ylab = "Global Active Power" )
  
  plot(electrical_subset$DateTime, as.numeric
       (as.character(electrical_subset$Sub_metering_1)),
                               type="l", xlab=NA, ylab="Energy sub metering")
  
  points(electrical_subset$DateTime, as.numeric
         (as.character(electrical_subset$Sub_metering_2)),
                                 type="l", col="red")
  
  points(electrical_subset$DateTime, as.numeric
         (as.character(electrical_subset$Sub_metering_3)),
                                 type="l", col="blue")
  
  legend("topright", bty = "n", lty=1, col=c("black", "red", "blue"), 
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(electrical_subset$DateTime, as.numeric
       (as.character(electrical_subset$Voltage)), type="l",
       xlab="datetime", ylab="Voltage")
  
  plot(electrical_subset$DateTime, as.numeric
       (as.character(electrical_subset$Global_reactive_power)),
       type="l", xlab="datetime", ylab="Global_reactive_power")  
})

#close PNG device
dev.off()








