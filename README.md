# Getting-Cleaning-Data
Peer-Assessed Programming Assignment for Getting and Cleaning Data Coursera course.

This repository contains the required files to be submitted for peer-assessed programming assignment.
This repo has four files
1) run_analysis.R : This is an R script that will ties up original data set[1] to generate a tidy data set.
2) tidy_output.txt : This is the tidy data file with the average of each variable for each activity and each subject .
3) CodeBook.md : The code book reference to the varialbes in my "tidy_output.txt".
4) README.MD : this is the same file whihc describes the contents of the Repository.

The run_analysis.R r script will retrive the data set from web location given an URL, makes a local copy and unzips the contents.
Then the data from training and test folders will be red into respecive variables and merged to form a single data set. 
From the single large data set, the variables that capture the mean and Standard deviation will be grabbed into a much smaller data set.
The activity names are captured as codes (1-6) and are decoded by mappings in activity_labels.txt file
Appropriate column names are created for easy of understnading the variables.

Afterthis step, the script will produce average of all the variables by actity and subject groups and outputs a tab-delimited txt file.

The script is commented as necessary. Refer to the CodeBook.md for additional details on variables etc.

Reference:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
