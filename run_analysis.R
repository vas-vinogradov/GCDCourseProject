##Preparing Data

#Reading column names from file
col_names<-read.table("Dataset\\features.txt")$V2
#Reading activity labels
activities<-read.table("Dataset\\activity_labels.txt")

##Test Data

#Reading Test Data
test_x_data<-read.table("Dataset\\test\\X_test.txt")
#Setting up Feature names
names(test_x_data)<-col_names
#Reading Activities
y_data<-factor(read.table("Dataset\\test\\Y_test.txt")$V1,activities$V1,activities$V2)
#Reading Subject
s_data<-read.table("Dataset\\test\\subject_test.txt")$V1
#Combining
test_data<-cbind(y_data,s_data,test_x_data)

##Train Data

#Reading Train Data
train_x_data<-read.table("Dataset\\train\\X_train.txt")
#Setting up Feature names
names(train_x_data)<-col_names
#Reading Activities
y_data<-factor(read.table("Dataset\\train\\Y_train.txt")$V1,activities$V1,activities$V2)
#Reading Subject
s_data<-read.table("Dataset\\train\\subject_train.txt")$V1
#Combining
train_data<-cbind(y_data,s_data,train_x_data)

##Merging Data

data<-rbind(test_data,train_data)

##Filtering columns
sub_data<-data[,c("y_data","s_data",colnames(data)[c(grep("std\\(\\)",colnames(data)),
                                    grep("mean\\(\\)",colnames(data)))])]

##Creating new dataset
result<-sub_data %>% group_by(y_data,s_data) %>% summarise_each(funs(mean))

#Saving results
write.table(result,file="test.txt",row.names = F) 

