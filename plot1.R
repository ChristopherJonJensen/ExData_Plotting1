## This function reads in the required data and generates the first plot

plot1 <- function (){ 
    
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
    plotData$DateTime <- parse_date_time(paste(plotData[,1],plotData[,2]), "dmyhms")
    
    ## open the graphics device
    png(file="plot1.png", width = 480, height = 480, units = "px", pointsize=14)
    
    ## As per the suggestion of Gregory Horne (TA), change the plot's background colour to white.
    ## https://class.coursera.org/exdata-014/forum/thread?thread_id=13
    par(bg = 'white')
    
    ## plot the histogram and then output the file
    hist(x=plotData$Global_active_power,xlab = "Global Active Power (kilowatts)", col = "red", main="Global Active Power")
    
    ## Since this function doesn't return any meaningful information, make the output invisible.
    invisible(dev.off())
}