#First, lets create and set our working directory
setwd("../")
WorkinDir = paste(getwd(), "/", "plotassigment1", "/", sep = "")
ifelse(!dir.exists(file.path(WorkinDir)), dir.create(file.path(WorkinDir)),FALSE)
setwd(WorkinDir)
getwd()

#Now, lets download the data
subDir = "data" #This is only for the entire zip file.
ifelse(!dir.exists(file.path(WorkinDir, subDir)), dir.create(file.path(WorkinDir, subDir)), FALSE) #this checks and create the data folder

# download file from server and unziping
ifelse(!file.exists("./data/power_consumption.zip"),
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "./data/power_consumption.zip",
              method = "libcurl"),FALSE)
unzip("./data/power_consumption.zip", exdir = "./data")


#Now, we have to read our dataset between 2007-02-1 (line 66636) and 2007-02-2 (line 69517). Remember, the NA values are "?"
consumptiondb <- read.table(file="./data/household_power_consumption.txt", header = FALSE, sep=";", na.strings = "?", skip=66636, nrows= 2880)

#Unfortunaly, when you skip lines you lost the headers, so we have to assign the headers manualy
headers   <- read.table(file="./data/household_power_consumption.txt", nrows= 1, header = FALSE, sep =";")
colnames(consumptiondb) <- as.vector(as.matrix(headers[1,]))
rm(headers) #we dont need this anymore, so lets delete the headers

#Date and time are "Factor" clases. So we have to convert them to date and time variables. We merge both variables and assign the correct format
consumptiondb$datetime <- paste(consumptiondb$Date,consumptiondb$Time)
consumptiondb$datetime <- strptime(consumptiondb$datetime, format ="%d/%m/%Y %H:%M:%S")

#Now we have our data complete. Lets build our plots.
#Plot 1
hist(consumptiondb$Global_active_power, xlab="Global Active Power (kilowatts)", ylab="Frecuency", main="Global Active Power", col="red")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()  ## Don't forget to close the PNG device!

