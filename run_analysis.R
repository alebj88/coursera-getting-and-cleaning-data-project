library(reshape2)

# Download and unzip the dataset:
fileName<- "getdata_dataset.zip"
if (!file.exists(fileName)){
     URL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
     download.file(URL, destfile=fileName)
}  
if (!file.exists("UCI HAR Dataset")) { 
     unzip(fileName) 
}

#Loading train and test data frames.
arch1<-"UCI HAR Dataset/train/X_train.txt"
arch2<-"UCI HAR Dataset/train/y_train.txt"
arch3<-"UCI HAR Dataset/train/subject_train.txt"
xtrain<-read.table(arch1)
ytrain<-read.table(arch2)
subjectTrain<-read.table(arch3)

arch1<-"UCI HAR Dataset/test/X_test.txt"
arch2<-"UCI HAR Dataset/test/y_test.txt"
arch3<-"UCI HAR Dataset/test/subject_test.txt"
xtest<-read.table(arch1)
ytest<-read.table(arch2)
subjectTest<-read.table(arch3)

#Loading activity labels and features.
arch1<-"UCI HAR Dataset/features.txt"
arch2<-"UCI HAR Dataset/activity_labels.txt"
features<-read.table(arch1)
activityLabels<-read.table(arch2)

#Adding subject and activity columns to the original data frames.
names(xtrain)<-features$V2
names(xtest)<-features$V2
xtrain<-cbind(subject=subjectTrain$V1,activity=ytrain$V1,xtrain)
xtest<-cbind(subject=subjectTest$V1,activity=ytest$V1,xtest)

#Adding descriptive activity names.
xtrain<-merge(xtrain,activityLabels,by.x="activity",by.y="V1",all.x=TRUE)
xtrain$activity<-xtrain$V2
xtrain$V2<-NULL
xtest<-merge(xtest,activityLabels,by.x="activity",by.y="V1",all.x=TRUE)
xtest$activity<-xtest$V2
xtest$V2<-NULL

#Merging train and test data frames by rows.
data<-rbind(xtrain,xtest)

#Extract only the measurements on the mean and standard deviation for each 
#measurement.
data<-data[,c(1,2,grep(".*mean.*|.*std.*",names(data)))]

#Assigning descriptive variable names.
newName<-gsub("-mean()","Mean",names(data))
newName<-gsub("[()]","",newName)
newName<-gsub("-std","Std",newName)
names(data)<-newName

#Subject and activity variables as factors.
data$subject<-as.factor(data$subject)
data$activity<-as.factor(data$activity)

#Creating second tidy data frame. 
dataMean <- melt(data, id = c("subject", "activity"))
dataMean <- dcast(dataMean, subject + activity ~ variable, mean)
write.table(dataMean, "tidy.txt", row.names = FALSE, quote = FALSE)
