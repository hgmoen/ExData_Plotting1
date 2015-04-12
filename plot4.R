##set working directory
setwd("/Users/hgmoen/Documents/Data Science/4-ExDatAnalysis")
##download zip file and unzip. creates txt file of data in working directory
if (!file.exists("household_power_consumption.txt")) {
        download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="household_power_consumption.zip", method = "curl")
        unzip(zipfile="household_power_consumption.zip")
}
##read in first row of table only to get the vector for the column headings
row1<-read.table("household_power_consumption.txt", sep = ";", nrows=1)
row1ch<-sapply(row1, as.character)
colnames<-as.character(row1ch)
##read in the table, skipping the first row, and setting the column headings using "colnames"
HPC<-read.table("household_power_consumption.txt", sep = ";", col.names=colnames, skip = 1, stringsAsFactors=FALSE)
setwd("/Users/hgmoen/Documents/Data Science/4-ExDatAnalysis/ExData_Plotting1")
##create a subset of the data frame based on the two dates specified in the assignment
HPCFeb<-subset(HPC, Date=="1/2/2007" | Date=="2/2/2007")
##convert all variables except Date and Time to numeric class
HPCFeb[,3:9]<-sapply(HPCFeb[,3:9], as.numeric)
##convert the Date and Time variables to a Date/Time class (new variable: DateTime)
HPCFeb$DateTime<-strptime(paste(HPCFeb$Date, HPCFeb$Time, sep="T"), format = "%d/%m/%YT%T")

##make the png file and print the graphs based on format criteria defined by the assignment
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

##1
plot(HPCFeb$DateTime, HPCFeb$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
##2
plot(HPCFeb$DateTime, HPCFeb$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
##3 
plot(HPCFeb$DateTime, HPCFeb$Sub_metering_1, type = "l", ylim = c(0, max(HPCFeb$Sub_metering_1, HPCFeb$Sub_metering_2, HPCFeb$Sub_metering_3)), xlab="", ylab="Energy sub metering")
lines(HPCFeb$DateTime, HPCFeb$Sub_metering_2, type="l", col="red")
lines(HPCFeb$DateTime, HPCFeb$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=c(1,1), bty = "n", col=c("black", "blue","red"))
##4
plot(HPCFeb$DateTime, HPCFeb$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()