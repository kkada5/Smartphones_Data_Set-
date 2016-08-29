## 	Merges the training and the test sets to create one data set  ##
library(plyr)
library(data.table)
testdata <- unzip("getdataprojectfilesUCI HAR Dataset.zip")
x_test<- read.table("UCI HAR Dataset/test/X_test.txt")
y_test<- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <-read.table("UCI HAR Dataset/test/subject_test.txt")
x_train<- read.table("UCI HAR Dataset/train/X_train.txt")
y_train<- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <-read.table("UCI HAR Dataset/train/subject_train.txt")
X<-rbind(x_test, x_train)
Y<-rbind(y_test, y_train)
Subject<-rbind(subject_test, subject_train)
Merged<-cbind(Subject, Y, X)
head(Merged)
dim(Merged)

## 	Extracts only the measurements on the mean and standard deviation for each measurement ##
measure_mean_std <- X[, grep("-(mean|std)\\(\\)", read.table("UCI HAR Dataset/features.txt")[, 2])]
names(measure_mean_std) <- read.table("UCI HAR Dataset/features.txt")[grep("-(mean|std)\\(\\)", read.table("UCI HAR Dataset/features.txt")[, 2]), 2] 
View(measure_mean_std)
dim(measure_mean_std)

## 	Uses descriptive activity names to name the activities in the data set
Y[, 1] <- read.table("UCI HAR Dataset/activity_labels.txt")[Y[, 1], 2]
names(Y) <- "Activities"
View(Y)

## 	Appropriately labels the data set with descriptive variable names.
names(Subject) <- "Subject"
summary(Subject)

Onedataset <- cbind(x_mean_std, Y, Subject)
names(Onedataset) <- gsub('^f',"FrequencyDomain.",names(Onedataset))
names(Onedataset) <- gsub('\\.mean',".Mean",names(Onedataset))
names(Onedataset) <- gsub('\\.std',".StandardDeviation",names(Onedataset))
names(Onedataset) <- gsub('Freq\\.',"Frequency.",names(Onedataset))
names(Onedataset) <- gsub('Freq$',"Frequency",names(Onedataset))
names(Onedataset) <- make.names(names(Onedataset))
names(Onedataset) <- gsub('Acc',"Acceleration",names(Onedataset))
names(Onedataset) <- gsub('GyroJerk',"AngularAcceleration",names(Onedataset))
names(Onedataset) <- gsub('Gyro',"AngularSpeed",names(Onedataset))
names(Onedataset) <- gsub('Mag',"Magnitude",names(Onedataset))
names(Onedataset) <- gsub('^t',"TimeDomain.",names(Onedataset))
names(Onedataset) <- gsub('^f',"FrequencyDomain.",names(Onedataset))
names(Onedataset) <- gsub('\\.mean',".Mean",names(Onedataset))
names(Onedataset) <- gsub('\\.std',".StandardDeviation",names(Onedataset))
names(Onedataset) <- gsub('Freq\\.',"Frequency.",names(Onedataset))
names(Onedataset) <- gsub('Freq$',"Frequency",names(Onedataset))
View(Onedataset)
names(Onedataset)

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject
Data <-aggregate(. ~Subject + Activity, Onedataset, mean)
Data <-Data [order(Data$Subject,Data$Activity),]
write.table(Data, file = "tidydata.txt",row.name=FALSE)
