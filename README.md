
First, the code reads data files from the working directory and stores the data in respective variables. For example, the test activity data from y_test is read from the working directory and is stored in tesActivitydata variable.

Second, the rows of test data is combined to the train data using rbind() function for activity, subject, and feature datesets. This results in a total of 3 datasets -- Subjectdata, Activitydata, and Featuredata

Third, the columns are labeled. For subject data, 

Fourth, all the columns from the 3 datasets are combined using cbind() function. This results in one data set with 10299 rows and 563 columns.

Fifth, the previously created dataset is subsetted to only have column names that include "mean()" or "std ()". This results in 10299x68 dataset

Sixth, the activity code numbers are replaced by descriptors. The activity names are read and stored from the activity_labels.txt file from the working directory. dplyr package is used to merge the acitivty names with the dataset.

Seventh, using text editing features (gsub()), the abbreviated variable names are transformed into full names. 

Eigth, new data set is created using aggreagate function from dplyr package and means of all the variables are reported for each subject under each activity.

Finally, the output text file is created and saved. 
