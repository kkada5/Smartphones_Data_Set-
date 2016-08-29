## 	Merges the training and the test sets to create one data set  ##

From Test Folder
x_test is "UCI HAR Dataset/test/X_test.txt" measurements
y_test is "UCI HAR Dataset/test/y_test.txt" activities
subject_test is "UCI HAR Dataset/test/subject_test.txt" subjects 

From Train Folder 

x_train is "UCI HAR Dataset/train/X_train.txt" measurements
y_train is  read.table("UCI HAR Dataset/train/y_train.txt" activities 
subject_train  is read.table("UCI HAR Dataset/train/subject_train.txt" subjects 

Binding them together in mesurements of test and train as X dataset, activites as Y data set and subjects as Subject Data set

Merged is dataset which includes X, Y and Subject 
Merged<-cbind(Subject, Y, X)

Only the measurements on the mean and standard deviation for each measurement  is 
measure_mean_std

Naming the Y dataset with Activites 
names(Y) <- "Activities"

Onedataset is data set with all appropriate labels

tidy data set is the average of each variable for each activity and each subject
