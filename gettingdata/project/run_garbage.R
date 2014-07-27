# Coursera Data Science Project	-	Getting and Cleaning Data

# You should create one R script called run_analysis.R that does the following:
#	1. Merges the training and the test sets to create one data set.
#	2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#	3. Uses descriptive activity names to name the activities in the data set
#	4. Appropriately labels the data set with descriptive variable names. 
#	5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Here is the original data set for this assignement:
#	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip [1]
#	[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
# Download this file to your computer and unzip it in your working directory in R for this project


activity_labels.txt
features.txt
features_info.txt
README.txt
test
train



ACTIVITIES:
walking
walking_upstairs
walking_downstairs
sitting
standing
laying

# 1.	Create one data set from the training and test data
# a.	Read in the data sets and assign column names:

activity	<- read.table("activity_labels.txt")
    names(activity) <- c("id", "name")

feature	<- read.table("features.txt")
    names(feature) <- c("id", "name")

x.train	 <- read.table("./train/x_train.txt")
y.train	 <- read.table("./train/y_train.txt")
x.test	 <- read.table("./test/x_test.txt")
y.test	 <- read.table("./test/y_test.txt")
subject.train<- read.table("./train/subject_train.txt")
subject.test <- read.table("./test/subject_test.txt")

# We are going to assign the features to the x-axis and the activities to the y-axis:
names(x.train)	  <- feature$name
names(x.test)	  <- feature$name
names(y.train)	  <- c("activities")
names(y.test)	  <- c("activities")
names(subject.train)<- c("subject")
names(subject.test) <- c("subject")


# merge all the data sets into one
x <- rbind(x.train, x.test)
y <- rbind(y.train, y.test)
subject <- rbind(subject.train, subject.test) 

# Assign a readable name for the activities 
y$activities <- activity[y$activities, ]$name


# Extract only the mean and standard deviations for each measurement:
z <- x[ , grep(".*mean\\(\\)|.*std\\(\\)", feature$name)]

# Blend the data sets into a tidy one:
data.set <- cbind(subject, y, z)

# Write the data file to disk:
write.table(data.set, file="mean.and.std.measurements.txt")

# Calculate the average of each variable for each activity and each subject:

library(reshape2)
melted.data.set <- melt(data.set, id.vars=c("subject", "activities"), na.rm=TRUE)
tidy.data.set <- dcast(melted.data.set, subject + activities ~ variable, mean)

# Write the tidy data set to disk:

write.table(tidy.data.set, file="tidy.data.set.txt")



#m.data.set <- melt(data.set, id.vars=c("subject", "activities"), na.rm=TRUE)
#library(plyr)
#calc.data.set <- dcast(data.set, subject, activities ~ variable, ave)






read.table()
write.table() - set the option of not writing the line numbers


 - Data samenvoegen met de cbind() of rbind() functie

mean()
std()

- Make a README file