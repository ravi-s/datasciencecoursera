#Codebook

##Author
Ravi S

##Summary
This document explains the process steps performed by the master script file run_analysis.R

1. Read the activity file from "activity_labels.txt" file to be used in enriching raw data.
2. Read the subject data from subject_test.txt and subject_train.txt files.  This data is used for enriching actual measurement data
3. Activity measurement data is read from training and test folders (y_train.txt and y.test.txt
4. Read user-defined file **variables.txt** to read the column numbers of mean and std measures and corresponding user-defined variables names.  Note: The original names from features.txt were cleaned up for a more user-friendly names.
5. Raw data (X_train.txt and X_test.txt) is read from train and test folders respectively. Note: Each of this data is separately processed.
6. The processed data is pruned to variables defined in the data read from variables text file.
7. The column names are mapped in the pruned data from the data read from variables text file.
8. The activity and subject data read from 1 and 2 are merged with the pruned data.
 
9. The respective training and the test data is merged for analysis.
10. Analysis is done as follows:
	* Using dplyr package, merged data is grouped by subject and activity columns.
	* final data is calculated using the summarise_this function using mean as the function to apply on each column.
	* The resulting data is written to a file called **summary.txt** to the working folder.

## Variable details
1. Activity file is read as a data.frame with 2 user-defined variables id and activity. Activity being a character type.
2. Activity measurement data is read and labelled as id variable. This is joined with data in step 1 and transformed to actual activity names.
3. variables.txt file is read as 2 column of column number and mapped variable name. This data is used to enrich the pruned data.
4. Subject and activity measurement data is added to pruned data as 2 columns. This is done for training and test data.
5. The resultant data is row merged and analysis performed on the merged data.
6. This data is written out as white space separated output file **summary.txt**.