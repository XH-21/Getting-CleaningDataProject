setwd('C:\\Users\\xiaonah\\Desktop\\Data_science_Coursera\\Course3-DataCleaning\\week4\\getdata%2Fprojectfiles%2FUCI HAR Dataset\\UCI HAR Dataset')
library(tidyr)
library(dplyr) 

##read in measured data, activity lables, subjects and features(variable names) 
##for test and train sets 
traindata<-read.table(file.path(getwd(),'X_train.txt'))
testdata<-read.table(file.path(getwd(),'X_test.txt'))
test_activity<-read.table(file.path(getwd(),'Y_test.txt'))
train_activity<-read.table(file.path(getwd(),'Y_train.txt'))
train_sub<-read.table(file.path(getwd(),'subject_train.txt'))
test_sub<-read.table(file.path(getwd(), 'subject_test.txt'))
varname<-read.table(file.path(getwd(),'features.txt'),stringsAsFactors = FALSE)

##turn all data frames into tbl_df
traindata<-tbl_df(traindata)
testdata<-tbl_df(testdata)
test_activity<-tbl_df(test_activity)
train_activity<-tbl_df(train_activity)
train_sub<-tbl_df(train_sub)
test_sub<-tbl_df(test_sub)
varname<-tbl_df(varname)

##combine measured data, activity lables and subjects into one dataset for test and train
test_sub<-rename(test_sub,subject=V1)
train_sub<-rename(train_sub,subject=V1)
test_activity<-rename(test_activity,activity=V1)
train_activity<-rename(train_activity,activity=V1)
test_all<-tbl_df(cbind(test_sub,test_activity,testdata))
train_all<-tbl_df(cbind(train_sub,train_activity,traindata))

##combine test and train data
all<-tbl_df(rbind(train_all,test_all))


##Extract only the measurements on the mean and standard deviation for each measurement
all_mean_std<-select(all,1:2,grep('mean\\(\\)|std\\(\\)',varname$V2)+2)

##rename data variables using the features.txt file
names(all_mean_std)[3:(ncol(all_mean_std))]<-grep('mean\\(\\)|std\\(\\)',varname$V2,value=TRUE)

##Recode activity column using values from the Activity labels text file
all_mean_std$activity[all_mean_std$activity==1] <-'WALKING'
all_mean_std$activity[all_mean_std$activity==2] <-'WALKING_UPSTAIRS'
all_mean_std$activity[all_mean_std$activity==3] <-'WALKING_DOWNSTAIRS'
all_mean_std$activity[all_mean_std$activity==4] <-'SITTING'
all_mean_std$activity[all_mean_std$activity==5] <-'STANDING'
all_mean_std$activity[all_mean_std$activity==6] <-'LAYING'

##create a second, independent tidy data set with the average of each variable 
##for each activity and each subject.
tidy_set<-
    all_mean_std%>% 
    group_by(subject,activity)%>%
    summarise_all(mean)%>%
    gather(measurement,mean, -subject,-activity)

write.table(tidy_set, file=file.path(getwd(),'tidy_set.txt'),row.names = FALSE)

