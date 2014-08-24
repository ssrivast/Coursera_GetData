setwd("~/Desktop/Coursera/3_getdata/")
"
Tidy Data Set should have following columns: 
1. Subject Id
2. Activity (Name)
3. Mean of all colums from x_test and x_train merged set (from Task 2). 
Note: This will select only columns with mean and std in the column name. All colmns (from task 1) could be easily selected using this 
same approach but resulting DS will be much larger)
"

# Set the number of rows you want to extract from datasets (for all rows enter -1)
n <- -1 

# Specify the name of zip file with all the data
zipfile <- "getdata_projectfiles_UCI HAR Dataset.zip"

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists(zipfile)) {
  download.file(fileUrl, destfile = zipfile, method = "curl") #may need modifying if binary etc
  library(tools)       # for md5 checksum
  sink("download_metadata.txt")
  print("Download date:")
  print(Sys.time() )
  print("Download URL:")
  print(target_url)
  print("Downloaded file Information")
  print(file.info(zipfile))
  print("Downloaded file md5 Checksum")
  print(md5sum(zipfile))
  sink()
}

unzip(zipfile, exdir = ".")

features <- read.table("./UCI HAR Dataset/features.txt")
activity_lab <- read.table("./UCI HAR Dataset/activity_labels.txt")

y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", nrows = n)
x_test <- read.table("./UCI HAR Dataset/test/x_test.txt", nrows = n)
sub_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", nrows = n)

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", nrows = n)
x_train <- read.table("./UCI HAR Dataset/train/x_train.txt", nrows = n)
sub_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", nrows = n)

all.y <- rbind(y_train, y_test)
all.x <- rbind(x_train, x_test)
all.sub <- rbind(sub_train, sub_test)

# Change the column names in x dataset to be meaningful 
col <- features[,"V2"]
colnames(all.x) <- col

# Pick only the columns with mean and std in the name
c1 <- c(grep("mean", col), grep("std", col))
c1 <- sort(c1)
all.x <- all.x[,c1]

# Add verbose acitivy text in the activity data
library(car)
all.y$activity <- recode(all.y[, 1], "1= 'WALKING'; 2='WALKING_UPSTAIRS'; 3='WALKING_DOWNSTAIRS'; 4='SITTING' ;5='STANDING'; 6='LAYING'")

colnames(all.sub) <- c("subject")
all.sub$activity <- all.y[,2]
all.data <- data.frame(subject = all.sub$subject, activity = all.sub$activity, all.x)

# Find the mean of all columns by Subject and Activity.
# First melt the dataset, followed by cast
library(reshape)
mel <- reshape::melt(all.data, id = c("subject", "activity"))
melmean <- cast(mel, subject + activity ~ variable, mean)

# Write final tidy dataset
write.table(melmean, file = "UCI HAR Tidy DataSet.txt", row.names = FALSE)
