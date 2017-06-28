run_analysis <- function() { 
  TestTE <- read.table(file="C:/Users/Sabine/Downloads/UCI_HAR_Dataset/test/X_test.txt", nrows = 115)
  TestTR <- read.table(file="C:/Users/Sabine/Downloads/UCI_HAR_Dataset/train/X_train.txt", nrows = 115)
  TestYTrain<- read.table(file="C:/Users/Sabine/Downloads/UCI_HAR_Dataset/train/y_train.txt", nrows = 115)
  TestYTest<- read.table(file="C:/Users/Sabine/Downloads/UCI_HAR_Dataset/test/y_test.txt", nrows = 115)
  TestY_cpl<-rbind(TestYTest,TestYTrain)
  names(TestY_cpl)<-"activity"

  TestSubjTrain<- read.table(file="C:/Users/Sabine/Downloads/UCI_HAR_Dataset/train/subject_train.txt", nrows = 115)
  TestSubjTest<- read.table(file="C:/Users/Sabine/Downloads/UCI_HAR_Dataset/test/subject_test.txt", nrows = 115)
  TestSubj_cpl<-rbind(TestSubjTest,TestSubjTrain)
  names(TestSubj_cpl)<-"subjects"
  
  
print("°°°°°°")
  TestALL<-rbind(TestTE,TestTR)
  Headrs<-read.table(file="C:/Users/Sabine/Downloads/UCI_HAR_Dataset/features.txt")
  colnames(TestALL) <- Headrs$V2
print("*****")
  #print(TestALL[,555:562])
print("%%%%%")
  TestSOME_mean <- TestALL[ , grepl(( "mean" ) , names( TestALL ) ) ]
  TestSOME_std <- TestALL[ , grepl(( "std" ) , names( TestALL ) ) ]
  ind <- apply( TestSOME_std , 1 , function(x) any( x > 0 ) )
  TestSOME_std[ ind , ]
  Test_ALL<-cbind(TestSOME_mean,TestSOME_std,TestY_cpl, TestSubj_cpl)
  Test_ALL <- Test_ALL[ , !grepl(( "-X"  ) , names( Test_ALL ) ) ]
  Test_ALL <- Test_ALL[ , !grepl(( "-Y"  ) , names( Test_ALL ) ) ]
  Test_ALL <- Test_ALL[ , !grepl(( "-Z"  ) , names( Test_ALL ) ) ]
  Test_ALL <- Test_ALL[ , !grepl(( "Freq()"  ) , names( Test_ALL ) ) ]
  ind <- apply( Test_ALL , 1 , function(x) any( x > 0 ) )
  Test_ALL[ ind , ]
print(".....")  
  Test_ALL$activity<-replace(Test_ALL$activity, Test_ALL$activity==1, "WALKING" )
  Test_ALL$activity<-replace(Test_ALL$activity, Test_ALL$activity==2, "WALKING_UPSTAIRS" )
  Test_ALL$activity<-replace(Test_ALL$activity, Test_ALL$activity==3, "WALKING_DOWNSTAIRS" )
  Test_ALL$activity<-replace(Test_ALL$activity, Test_ALL$activity==4, "SITTING" )
  Test_ALL$activity<-replace(Test_ALL$activity, Test_ALL$activity==5, "STANDING" )
  Test_ALL$activity<-replace(Test_ALL$activity, Test_ALL$activity==6, "LAYING" )
#print(Test_ALL)
  print("°°°°°")
  print(class(Test_ALL))
  print(class(Test_ALL[1,1]))
  namesERG<-names(Test_ALL)
  print(namesERG)
  aa<-split(Test_ALL,Test_ALL$activity)
  
  print(class(aa))
  #print(class(aa[1,1]))
  ERG<-sapply(Test_ALL , FUN=mean)
  print((ERG))
  #y<-sapply(aa,function(x) colMeans(x [c("fBodyBodyGyroJerkMag-std()","fBodyAccMag-std()")]))
  #y<-sapply(aa,function(x) colMeans(x[c(namesERG)]))
  #sapply(aa,function(x) colMeans(x[-1]))
  aggregate(. ~ activity, data = Test_ALL)
  #y<-sapply(aa,FUN=mean, na.rm =TRUE)
  #print(Test_ALL)
  print("&&&&&")
  print(y)
  
}