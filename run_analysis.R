# require dplyr package
require(dplyr)

# Read the common files features.txt and activity_labels.txt into R studio
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")
names(activity_labels) <- c("Index", "Activity")

# Read the test data files
X_test <- read.table("test/X_test.txt")
Y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# Read the training data files
X_train <- read.table("train/X_train.txt")
Y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

# Extract only columns with mean and std in variable names
col_nums <- grep("(mean|std)", features$V2)
features <- features[col_nums, ]
X_test <- X_test[, col_nums]
X_train <- X_train[, col_nums]

# Set column names
names(X_test) <- features$V2
names(Y_test) <- "Act"
names(subject_test) <- "Subject"

names(X_train) <- features$V2
names(Y_train) <- "Act"
names(subject_train) <- "Subject"

# Build the test and train tables
test_data <- cbind(subject_test, Y_test, X_test)
train_data <- cbind(subject_train, Y_train, X_train)

# bind the test and train tables together to create one data table
data <- rbind(test_data, train_data)

# Give the activities names instead of numbers and get rid of Index column
data <- merge(activity_labels, data, by.x="Index", by.y="Act", all=TRUE)
data <- tbl_df(data)
data <- select(data, -Index)

# Remove variable measurements from Fast Fourier Transform (FFT)
data <- select(data, -starts_with("f"))

# Cleanup column names
names(data) <- gsub("[-()]", "", names(data))
names(data) <- gsub("mean", "Mean", names(data))
names(data) <- gsub("std", "Std", names(data))

# Reorder columns
data <- select(data, Subject, Activity, tBodyAccMeanX:tBodyGyroJerkMagStd)

# clean up
rm("activity_labels", "features", "subject_test", "subject_train", "X_test", "X_train",
   "Y_test", "Y_train", "col_nums", "test_data", "train_data")

## Start tidying
require(tidyr)

groupedMeans <- group_by(data, Subject, Activity) %>%
      summarise_each(funs(mean), starts_with("t"))




