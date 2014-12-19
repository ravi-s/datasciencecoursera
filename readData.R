library(data.table)
library(plyr)
library(dplyr )

###
### Author: User Id: 5548503
### Date: 12-Dec-2014
####

##
#   Description:
#       Read activities file
#       return measured activities as a data.frame object
#   Parameters:
#       dir: character vector starting from working directory
#       file: the file to read data from
#   
##
readActivities <- function (dir, file = "activity_labels.txt") {
    
    filePath <- file.path(dir,file)
    #read.table(filePath, col.names = c("Id", "Activity"), colClasses = c("integer","character"))
    d <- fread(filePath)
    setnames(d,c("id", "activity"))
    
    return(d)
}


##
#   Description:
#       Read activity labels  file for measurement data as a data frame
#       return activity data with descriptive names
#   Parameters:
#       dir: directory path starting from working directory
#       file: the file to read data from 
#   
##
readActivityData <- function (dir, ..., file) {
    # read activity labels 
    activityLabels <- readActivities(dir)
    
    # read measurement y labels (train or test)
    filePath <- file.path(dir,...,file)
    d <- fread(filePath)
    setnames(d, "id")
    # combine the data by activity id and remove measurement id
    data <- join(d, activityLabels, by = "id")
    data$id <- NULL
    data
}



##
#   Description:
#       Read subject id for measurement data
#       return subject data with column name as "subject"
#   Parameters:
#       dir: directory path starting from working directory
#       file: the file to read data from 
#   
##
readSubjectData <- function (dir, ..., file) {
   
     # read subject measurement labels (train or test)
    filePath <- file.path(dir,...,file)
    d <- fread(filePath)
    setnames(d, "subject")
    
}

##
#   Description:
#       Read raw measurements data
#       return data as data.frame
#   Parameters:
#       dir: directory path starting from working directory
#       file: the file to read data from 
#   
##
readMeasurementsData <- function (dir, ..., file) {
    
    # read subject measurement labels (train or test)
    filePath <- file.path(dir,...,file)
    
    data5rows <- read.table(filePath, nrows = 5)
    classes <- sapply(data5rows, class)
    data <- read.table(filePath, colClasses = classes)
}

##
#   Description:
#       prune measurements data to only columns that are
#       mean or std deviation types. Return pruned data frame object.
#   Parameters:
#       data: data.frame raw data
#       cols: vector of columns (variables) to prune the data
##
pruneMeasurementsData <- function (data, cols) {
    select(data, cols )
}

##
#   Description:
#       Read column index and names from user supplied file
#       return data frame consisting of column numbers and their mapped names
#   Parameters:
#       file: file in current working directory
#       
##
readColumns <- function(file) {
    read.table(file, colClasses = c("numeric", "character"))
}

##
#   Description:
#       Rename columns to meaningful names
#       return modified data with column names
#   Parameters:
#       data: data.frame raw data
#       cols: vector of variable names
##
renameColumns <- function(data, variableNames) {
    names(data) <- variableNames
    data
}

##
#   Description:
#        Add subject and activity data to pruned measurements data
#        return modified data that includes added data
#   Parameters:
#       measurements: measurements data
#       subject: subject data
#       activity : activity data
#       cols: vector of variable names
##
enrichData <- function(measurements, subject, activity) {
    
    d <- cbind(subject,activity,measurements)
    d
}

##
#   Description:
#        merge train and test data
#        return modified data that includes merged data
#   Parameters:
#       data1: enriched train data
#       data2: enriched test data
##

mergeData <- function(data1, data2) {
    data <- rbind(data1,data2)
    data
}
