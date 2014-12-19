##
#  This is the master script that does the following:
#   1.    Reads a user-defined file (please see variables.txt in git repository)
#       of mean and std variables along with column numbers in original data.
#       Note: variable names are changed from original file for ease of use
#   2.  Reads raw training and test data respectively. Ignores Inertial Signals data.
#   3.  Prunes raw data to data base on columns read from variables.txt columns.
#   4.  Read Activity labels for labeling data later on.
#   5.  Read participants data from respective subject data file.
#   6.  Enriches each data with activity labels and subject data.
#   7.  Merges pruned training and test data to a combined single data.
#   8.  Groups the combined data by subject and activity (step 5).
#   9.  Mean is calculated for each variable by the grouped data.
#   10. This data is written to a file called summary.txt
#
###
### Note: This script is dependent on functions in readData.R, that is also uploaded in git.
###

# Read a user defined file for columns to be use later on for merging
cols <- readColumns("variables.txt")
# Read Training Data
activityTrainData <- readActivityData("UCI HAR Dataset", "train", file = "y_train.txt")
subjectTrainData <- readSubjectData("UCI HAR Dataset", "train", file = "subject_train.txt")
train_data <- readMeasurementsData( "UCI HAR Dataset", "train", file = "X_train.txt")
pruned_train_data <- pruneMeasurementsData(train_data,cols[,1])
pruned_train_data <- renameColumns(pruned_train_data, cols[,2])
pruned_train_data <- enrichData(pruned_train_data, subjectTrainData, activityTrainData)

# Read Test Data
activityTestData <- readActivityData("UCI HAR Dataset", "test", file = "y_test.txt")
subjectTestData <- readSubjectData("UCI HAR Dataset", "test", file = "subject_test.txt")
test_data <- readMeasurementsData( "UCI HAR Dataset", "test", file = "X_test.txt")
pruned_test_data <- pruneMeasurementsData(test_data,cols[,1])
pruned_test_data <- renameColumns(pruned_test_data, cols[,2])
pruned_test_data <- enrichData(pruned_test_data, subjectTestData, activityTestData)

# merge training and test data
merged_data <- mergeData(pruned_train_data, pruned_test_data)
# Summarize to calculate average for new data set
merged_subject_activity_data <- group_by(merged_data,subject,activity)
summaryData <- summarise_each(merged_subject_activity_data,c("mean"))

# Write summary data to a file
write.table(summaryData, file = "summary.txt", row.names = FALSE)