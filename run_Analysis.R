library(data.table)

## Read the activity labels file
activity_names <- read.table("./data/UCI_HAR_Dataset/activity_labels.txt", header=FALSE)

## Rename columns and modify column classes
activity_names$V2     <- as.character(activity_names$V2)
names(activity_names) <- c("Activity", "ActivityName")

## Read the feature.txt file to extract the names for the columns in the data sets 
feature_names <- read.table("./data/UCI_HAR_Dataset/features.txt", header=FALSE)

## Rename columns and modify column classes
feature_names$V2     <- as.character(feature_names$V2)
names(feature_names) <- c("Feature", "FeatureName")

## Read test data set
testData      <- read.table("./data/UCI_HAR_Dataset/test/X_test.txt", header=FALSE)
testData_labs <- read.table("./data/UCI_HAR_Dataset/test/y_test.txt", header=FALSE)
testData_subj <- read.table("./data/UCI_HAR_Dataset/test/subject_test.txt", header=FALSE)

## visual inspection that the length of the test data set is consistent
cat(nrow(testData), nrow(testData_labs), nrow(testData_subj))

## rename columns in the testData
colnames(testData) <- feature_names$FeatureName

## add new column which contains the name of the corresponding activity to the testData_labs dataframe
testData_labs$V2 <- factor(testData_labs$V1, levels=activity_names$Activity, labels=activity_names$ActivityName)

## now rename the columns in this dataframe
names(testData_labs) <- c("Activity", "ActivityName")

## rename column in testData_subj dataframe
names(testData_subj) <- "Subject"

## Now merge all of the test data in one data frame
testData <- cbind(testData, testData_labs)
testData <- cbind(testData, testData_subj)

##############------------- Now do the same for the training dataset ----------------#################
## Read training data set
trainData      <- read.table("./data/UCI_HAR_Dataset/train/X_train.txt", header=FALSE)
trainData_labs <- read.table("./data/UCI_HAR_Dataset/train/y_train.txt", header=FALSE)
trainData_subj <- read.table("./data/UCI_HAR_Dataset/train/subject_train.txt", header=FALSE)

## visual inspection that the length of the traning data set is consistent 
cat(nrow(trainData), nrow(trainData_labs), nrow(trainData_subj))

## rename columns in the trainData
colnames(trainData) <- feature_names$FeatureName

## add new column which contains the name of the corresponding activity to the trainData_labs dataframe
trainData_labs$V2 <- factor(trainData_labs$V1, levels=activity_names$Activity, labels=activity_names$ActivityName)

## now rename the columns in this dataframe
names(trainData_labs) <- c("Activity", "ActivityName")

## rename column in trainData_subj dataframe
names(trainData_subj) <- "Subject"

## Now merge all of the train data in one data frame
trainData <- cbind(trainData, trainData_labs)
trainData <- cbind(trainData, trainData_subj)

## Now we merge both data sets in one data set
All <- rbind(testData, trainData)

## Extracts only the measurements on the mean and standard deviation for each measurement
Mean_Std <- All[,grep("mean|std", colnames(All))]

# As a check this subset should have the same number of columns as the full merged data set
if(nrow(All) != nrow(Mean_Std)){
  print("Error! Your subsetting on the Means and standard deviations is wrong")
}

## Create a new tidy data set with the average of each variable for each activity and each subject

Ids          <- c("Activity", "ActivityName", "Subject")

## get out the name of all the columns except the ones we wanna melt the merged data set with
Measures     <- setdiff(colnames(All), Ids)

## melt the data set
All_melt     <- melt(All, id=Ids, measure.vars=Measures)

## new data set with mean of each variable for each activity and subject 
All_new <-  dcast(All_melt, ActivityName + Subject ~ variable, mean) 

## save the data to a new file
write.table(All_new, file="Tidy_Data.txt")

## to make sure the data is saved correctly reread the data and check it
tidyData <- read.table("Tidy_Data.txt")
tidyData$ActivityName
tidyData$Subject

