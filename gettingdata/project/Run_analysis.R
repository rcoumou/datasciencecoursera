# Coursera Data Science Project        -	Getting and Cleaning Data
# Author: R.Coumou
# Date: 27-7-2014

# Install the required packages if they are not yet installed:
if (!require("data.table")) {
  install.packages("data.table")
}

# Read in the data sets and assign column names:
if (!require("reshape2")) {
  install.packages("reshape2")
}

# Read in the data sets and assign column names:

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

# Assign the features to the x-axis and the activities to the y-axis:
names(x.train)	  <- feature$name
names(x.test)	  <- feature$name
names(y.train)	  <- c("activities")
names(y.test)	  <- c("activities")
names(subject.train)<- c("subject")
names(subject.test) <- c("subject")


# Merge the data sets:
x <- rbind(x.train, x.test)
y <- rbind(y.train, y.test)
subject <- rbind(subject.train, subject.test) 

# Assign a readable name for the activities 
y$activities <- activity[y$activities, ]$name


# Extract only the mean and standard deviations for each measurement:
z <- x[ , grep(".*mean\\(\\)|.*std\\(\\)", feature$name)]

# Blend the data sets into a tidy one:
data.set <- cbind(subject, y, z)

# Write the tidy data set with the selected measurements to disk:
write.table(data.set, file="mean.and.std.measurements.txt")

# Calculate the average of each variable for each activity and each subject:

library(reshape2)
melted.data.set <- melt(data.set, id.vars=c("subject", "activities"), na.rm=TRUE)
tidy.data.set <- dcast(melted.data.set, subject + activities ~ variable, mean)

# Write the tidy data set to disk:
write.table(tidy.data.set, file="tidy.data.set.txt")
