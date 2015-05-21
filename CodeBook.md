CodeBook
Description: Document containing description of the data, variables, and information related to transformations or work that are performed for data clean-up
Assumptions
You have working installation of R,  Rstudio and an internet connection.
Obtain data:
“data.table” library is called into environment.
Code lines 7 through16.
Two variables url (to hold the html link to the source file) and “local_copy” destination file name are created.
“download.file” function with url/local_copy and “web arguments is used to pull down data and “unzip” function to decompress the source file.
merge_data
Contents of individual files from both test and train folders with “read.table” function.
“x_train” and “x_test” collects variable measurements form train and test folders.
“y_train” and “y_test” collects activity codes from train and test folders
“train_subject” and “test_subject” collects subject codes from train and test folders
“training_set” holds the merged data from all “*_train” data frames
“testing_set” holds the merged data from all the “*_test data frames”
“mydf” is the data frame created by merging “Training_set” and “testing_set” data frames
Transformations inside merge_data 
•	“col_names_for_x_readings” holds the descriptive olumn names stored in features.txt
•	“colnames_for_mydf” holds the column names for mydf with elements from “col_names_for_x_readings” along with first two colmn names forced with “Activity” and “Subject”
•	Next line of code just force fitted with the data set.
•	“mydf_mean_std” is created by grep function by extracting only variable names that contain “mean” and “std”.
•	Activity  is a variable that holds the activity labels to activity ID mappings reported in “Activity_labels.txt”
•	Colmn labels were then edited with a series of grep function calls (Lines 46-57)
Write tidy set
“aggdata” holds the data melting and creating the mean value of all the variables grouped by Activity name and Activity label.
Output data
Then the data is written out using “write.table” function into a tab delimited txt file  called “tidy_output.txt
