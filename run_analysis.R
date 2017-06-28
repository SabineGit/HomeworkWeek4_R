run_analysis <- function() { 
  library(dplyr)
  #get all neccessary data
  TestTE <- read.table(file="C:/Users/Sabine/Downloads/UCI_HAR_Dataset/test/X_test.txt")
  TestTR <- read.table(file="C:/Users/Sabine/Downloads/UCI_HAR_Dataset/train/X_train.txt")
  TestYTrain<- read.table(file="C:/Users/Sabine/Downloads/UCI_HAR_Dataset/train/y_train.txt")
  TestYTest<- read.table(file="C:/Users/Sabine/Downloads/UCI_HAR_Dataset/test/y_test.txt")
  TestSubjTrain<- read.table(file="C:/Users/Sabine/Downloads/UCI_HAR_Dataset/train/subject_train.txt")
  TestSubjTest<- read.table(file="C:/Users/Sabine/Downloads/UCI_HAR_Dataset/test/subject_test.txt")
  Headrs<-read.table(file="C:/Users/Sabine/Downloads/UCI_HAR_Dataset/features.txt")
  Activities<-read.table(file="C:/Users/Sabine/Downloads/UCI_HAR_Dataset/activity_labels.txt")
  #combine Test-and Train
  X_komplett <-rbind(TestTR,TestTE)
  Y_komplett <-rbind(TestYTrain,TestYTest)
  Sub_komplett <-rbind(TestSubjTrain,TestSubjTest)
  #give Header-names
  names(Y_komplett)<-"activity"
  names(Sub_komplett)<-"subjects"
  colnames(X_komplett) <- Headrs$V2
  #extract only std and mean
  mean_and_std_features <- grep("-(mean|std)\\(\\)", Headrs$V2)
  X_komplett <- X_komplett[, mean_and_std_features]
  #combine x,y,subjects to 1 table
  ALL<-cbind(X_komplett,Y_komplett,Sub_komplett)
  averages_data <- ddply(ALL, .(subjects, activity), function(x) colMeans(x[, 1:66]))
  write.table(averages_data, "averages_data.txt", row.name=FALSE)

}
