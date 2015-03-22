##Read and store Data in different variables
testActivitydata<-read.table("./UCI HAR Dataset/test/y_test.txt", header=F)
trainActivitydata<-read.table("./UCI HAR Dataset/train/y_train.txt", header=F)
testSubjectdata<-read.table("./UCI HAR Dataset/test/subject_test.txt", header=F)
trainSubjectdata<-read.table("./UCI HAR Dataset/train/subject_train.txt", header=F)
testFeaturedata<-read.table("./UCI HAR Dataset/test/X_test.txt", header=F)
trainFeaturedata<-read.table("./UCI HAR Dataset/train/X_train.txt", header=F)

##Combine Training and Test Datasets
Activitydata<-rbind(trainActivitydata,testActivitydata)
Subjectdata<-rbind(trainSubjectdata,testSubjectdata)
Featuredata<-rbind(trainFeaturedata,testFeaturedata)

##Label the Column Variables for all datasets
names(Subjectdata)<-c("subject")
names(Activitydata)<-c("activity")
FeatureNames<-read.table("./UCI HAR Dataset/features.txt", header=F)
names(Featuredata)<-FeatureNames$V2

##Combine all the columns   data frame size = (10299,563)
data<-cbind(Subjectdata,Activitydata,Featuredata)

##Subset data by mean() and std() related columns    data frame size = (10299,68)
subFeatureNames<-FeatureNames$V2[grep("mean\\(\\)|std\\(\\)",FeatureNames$V2)]
data<-subset(data,select = c("subject","activity",as.character(subFeatureNames)))

##Name the activities
ActivityNames<-read.table("./UCI HAR Dataset/activity_labels.txt", header=F)
library(dplyr)    #chose dplyr package to implement chaining
data<-tbl_df(data)
data<-merge(data,ActivityNames,by.x="activity",by.y="V1")
data<-data %>% arrange(subject) %>% mutate(activity=V2) %>% select(-V2)

##Descriptive variables mnemonics 
names(data)<-gsub("^t","Time", names(data))
names(data)<-gsub("^f","Frequency", names(data))
names(data)<-gsub("Acc","Accelerometer", names(data))
names(data)<-gsub("Gyro","Gyroscope", names(data))
names(data)<-gsub("Mag","Magnitude", names(data))
names(data)<-gsub("BodyBody","Body", names(data))

##new date set with mean values of all activities for each subject
data2<-aggregate(.~subject+activity,data,mean)  #aggregate function from dplyr package

##output file
write.table(data2,file="tidydataset.txt", row.name=F)
