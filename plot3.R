#read the unzipped data file into R
electrical <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")

#convert Date column from factor to character
electrical$Date <- as.character(electrical$Date)

#select data from 01/02/2007 to 02/02/2007
electrical_subset <- subset(electrical, Date == "1/2/2007" | Date == "2/2/2007")

#create new column in which "Date" and "Time" column contents are concatenated
electrical_subset$DateTime <- paste(electrical_subset$Date, 
                                    electrical_subset$Time)

#convert DateTime column from character to Date-time class
electrical_subset$DateTime <- strptime(electrical_subset$DateTime, "%d/%m/%Y %H:%M:%S")

#open PNG device, with assumption that background (argument "bg") is "white", not "transparent"
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")

#make plot
with(electrical_subset, plot(electrical_subset$DateTime,
                             as.numeric(as.character(electrical_subset$Sub_metering_1)),
                             type="l", xlab=NA, ylab="Energy sub metering"))

with(electrical_subset, points(electrical_subset$DateTime,
                               as.numeric(as.character(electrical_subset$Sub_metering_2)),
                               type="l", col="red"))

with(electrical_subset, points(electrical_subset$DateTime,
                               as.numeric(as.character(electrical_subset$Sub_metering_3)),
                               type="l", col="blue"))
                               
#add legend
legend("topright", lty=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#close PNG device
dev.off()

