#read the unzipped data file into R
electrical <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")

#convert Date column from factor to character
electrical$Date <- as.character(electrical$Date)

#select data from 01/02/2007 to 02/02/2007
electrical_subset <- subset(electrical, Date == "1/2/2007" | Date == "2/2/2007")

#convert "Global_active_power" column to numeric
electrical_subset$Global_active_power <- as.numeric(as.character
                                                    (electrical_subset$Global_active_power))

#open PNG device, with assumption that background (argument "bg") is "white", not "transparent"
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")

#make plot
hist(electrical_subset$Global_active_power, main = "Global Active Power",
     xlab="Global Active Power (kilowatts)", ylim=c(0,1200), col="red")

#close PNG device
dev.off()

