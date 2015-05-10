## This function reads in the required data and generates the following four plots
## 1) Global active power over time , 2) Voltage over time
## 3) Sub metering over time , 4) Global reactive power over time

plot4 <- function (){ 
    
    ## For ease of dealing with dates/times, I am using the lubridate package.
    library("lubridate")
    
    ## First, check if the file is present. If not, download and unpack it into current dir.
    if (!file.exists("household_power_consumption.txt")){
        fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileurl, destfile = "data.zip", mode="wb", method = "auto")
        unzip("data.zip")
    }
    
    ## Next read the data into a table
    srcFile <- "household_power_consumption.txt"
    baseData <- read.table(file = srcFile, header = TRUE, sep = ";", na.strings = "?")
    
    ## Now, subset out the 2880 relevant rows of the two days in question
    ## For ease of use, convert the string dates/times into PosixCT objects using lubridate
    plotData <- baseData[baseData$Date=="1/2/2007" | baseData$Date=="2/2/2007",]
    plotData$datetime <- parse_date_time(paste(plotData[,1],plotData[,2]), "dmyhms")
    
    ## open the graphics device
    png(file="plot4.png", width = 480, height = 480, units = "px", pointsize=12)
    
    ## As per the suggestion of Gregory Horne (TA), change the plot's background colour to white.
    ## Also, set the output to plot multiple graphs to a single graphics device
    par(bg = 'white', mfrow=c(2,2))    
    
    ## plot the first graph (as per plot1.R)
    plot(x = plotData$datetime, plotData$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

    ## plot the second graph
    plot(x = plotData$datetime, y = plotData$Voltage, type = "l", ylab = "Voltage")
    
    ## plot the third graph (as per plot3.R)
    plot(x = plotData$datetime, y = plotData$Sub_metering_1, type = "l", ylab = "Energy sub metering")
    lines(x = plotData$datetime, y = plotData$Sub_metering_2, col="red")
    lines(x = plotData$datetime, y = plotData$Sub_metering_3, col="blue")
    legend(x="topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), lwd=c(1,1,1),col=c("black","red", "blue"), bty = "n")
    
    ## plot the fourth graph
    plot(x = plotData$datetime, y = plotData$Global_reactive_power, type = "l", ylab = "Global_reactive_power")
    
    ## Since this function doesn't return any meaningful information, make the output invisible.
    invisible(dev.off())
}