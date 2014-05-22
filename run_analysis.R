if(!file.exists("./data")){dir.create("./data")}
if(!file.exists("./temp")){dir.create("./temp")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileUrl, destfile = "./data/dataset.zip", method = "curl")
unzip("./data/dataset.zip", exdir = "./data/")
dataDirTest <-  "/home/john/datasciencecoursera/Getting.Cleaning.Data/data/UCI HAR Dataset/test/"
dataDirTrain <-  "/home/john/datasciencecoursera/Getting.Cleaning.Data/data/UCI HAR Dataset/train/"
dataDir <- "/home/john/datasciencecoursera/Getting.Cleaning.Data/data/UCI HAR Dataset/"
inertiaDataDir <- "/home/john/datasciencecoursera/Getting.Cleaning.Data/data/UCI HAR Dataset/train/Inertia Signals/"

xTestDat <- read.table(paste(dataDirTest, "X_test.txt", sep = ""))
yTestlabels <- read.table(paste(dataDirTest, "y_test.txt", sep = ""))

xTrainDat <- read.table(paste(dataDirTrain, "X_train.txt", sep = ""))
yTrainlabels <- read.table(paste(dataDirTrain, "y_train.txt", sep = ""))

featuresList <- read.table(paste(dataDir, "features.txt", sep = ""), stringsAsFactors = FALSE)

for (i in 1:nrow(featuresList)) {
        featuresList[i, 2] <- tolower(gsub("([-/(/)/,])", "", featuresList[i, 2]))
    }


activityLabels <- read.table(paste(dataDir, "activity_labels.txt", sep = ""))

trainSubject <- read.table(paste(dataDirTrain, "subject_train.txt", sep = ""))






fitData <- read.table(unz(temp, "Dataset.dat"))
