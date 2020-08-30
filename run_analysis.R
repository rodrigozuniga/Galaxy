
setwd("C:\\Users\\rodri\\Dropbox\\Education\\R\\RClass3\\UCIHARDataset\\Galaxy")
##Y:test and train
y_test<-read.table(".\\test\\y_test.txt")
subjectid_test<-read.table(".\\test\\subject_test.txt")
y_test_all<-cbind(y_test,subjectid_test)
y_test_all$testortrain<-c("test")
names(y_test_all)<-c("activity","subjectid","testortrain")

y_train<-read.table(".\\train\\y_train.txt")
subjectid_train<-read.table(".\\train\\subject_train.txt")
y_train_all<-cbind(y_train,subjectid_train)
y_train_all$testortrain<-c("train")
names(y_train_all)<-c("activity","subjectid","testortrain")

y_all<-rbind(y_test_all,y_train_all)
y_all$activity<-as.factor(y_all$activity)
y_activitylevels<-c("walking","walkingupstairs","walkingdownstairs","sitting","standing","laying")
levels(y_all$activity)<-y_activitylevels;
y_all$testortrain<-as.factor(y_all$testortrain)

##X:test and train
X_varnames<-read.table("features.txt",header=F,sep=" ")

X_test<-read.table(".\\test\\X_test.txt",header = F,sep = "")
names(X_test)<-X_varnames$V2
X_train<-read.table(".\\train\\X_train.txt",header = F,sep = "")
names(X_train)<-X_varnames$V2
X_all=rbind(X_test,X_train)

##X:mean and std only; exclude meanFreq
xvarnames_w_meanstd<-grep('mean|std',X_varnames$V2,value=T)
xvarnames_w_meanstd_wo_freq<-xvarnames_w_meanstd[-grep('(Freq)',xvarnames_w_meanstd)]
X_all_meanstd<-X_all[,xvarnames_w_meanstd_wo_freq]

##finaldataset: y_all and X_all_meanstd
finaldataset<-cbind(y_all,X_all_meanstd)
dim(finaldataset)

##finaldatasetaggregate: mean by activity and subjectid
finaldatasetaggregate<-aggregate(finaldataset[,4:69],FUN=mean,list(activity=finaldataset$activity,subjectid=finaldataset$subjectid))

