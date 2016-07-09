# coursera-getting-and-cleaning-data-project
Project for "Getting and Cleaning Data"
The R script, run_analysis.R, does the following:

1.Download the dataset if it does not already exist in the working directory
2.Loads both training and test dataset with their respective subjects.
3.Loads the activity labels and features datasets.
4.Assigns the feature names as headers of the train and test data frames.
5.Merges the activity and subject columns with the both training and test datasets.
6.Replaces the values of the activity column by descriptive activity names given by the activity_labels dataset in both data frames. 
7.Merges the two datasets, training and test by rows.
8.Reduces the merged data frame keeping only those columns which reflect a mean or standard deviation.
9.Assigns descriptive variable names.
6.Converts the activity and subject columns into factors
7.Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
The end result is shown in the file tidy.txt.
