## This function reads in the required data and generates the third plot (Energy sub-metering over time)

plot3 <- function (){ 
    
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
    png(file="plot3.png", width = 480, height = 480, units = "px", pointsize=14)
    
    ## As per the suggestion of Gregory Horne (TA), change the plot's background colour to white.
    ##?line https://class.coursera.org/exdata-014/forum/thread?thread_id=13
    par(bg = 'white')
    
    ## plot the three lines graphs, add the legend, and then output the file
    plot(x= plotData$datetime, y = plotData$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
    lines(x= plotData$datetime, y = plotData$Sub_metering_2, col="red")
    lines(x= plotData$datetime, y = plotData$Sub_metering_3, col="blue")
    legend(x="topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=c(2,2,2),col=c("black","red", "blue"))
    
    
    ## Since this function doesn't return any meaningful information, make the output invisible.
    invisible(dev.off())
}