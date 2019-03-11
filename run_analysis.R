tidyDataSet <- function() {

##Step 1
##read in descriptions of the 561 derived features 
featureDescriptions <- 
  read.table("H:/Data Science/Coursera/Course 3_Project/UCI HAR Dataset/features.txt"
             , colClasses = "character", col.names = c("","TimeFrequencyFeature"))[2]
  
##Step 2
##extract and create dataframe including vector position and values from 'features'   
##that only contain mean() or std() calculations
meanstdFeatures <- 
  data.frame("TimeFrequencyFeature"=as.factor(grep('mean()|std()', featureDescriptions[,]))
             , "TimeFrequencyFeatureDescription"=grep('mean()|std()', featureDescriptions[,], value=TRUE)
             , stringsAsFactors = FALSE)
  
##Step 3
##activity category records for friendly activity description---for subsequent  
##merge with 'testData' or 'trainData' to replace activity ID's w/ friendly description
activityLabels <- 
  read.table("H:/Data Science/Coursera/Course 3_Project/UCI HAR Dataset/activity_labels.txt"
             , colClasses = "factor" , col.names = c("ActivityLabel","ActivityDescription"))
  
##Step 4
##read in subject/activity labels and derived feature values
##for each record of test and train data sets
testData <- cbind(
  read.table("H:/Data Science/Coursera/Course 3_Project/UCI HAR Dataset/test/subject_test.txt"
              , colClasses = "factor", nrows = 3000, col.names = "SubjectID", comment.char = "")
  , read.table("H:/Data Science/Coursera/Course 3_Project/UCI HAR Dataset/test/y_test.txt"
              , colClasses = "factor", nrows = 3000, col.names = "ActivityLabel", comment.char = "")
  , read.table("H:/Data Science/Coursera/Course 3_Project/UCI HAR Dataset/test/X_test.txt"
              , colClasses = "numeric", nrows = 3000, comment.char = ""))
  
trainData <- cbind(
  read.table("H:/Data Science/Coursera/Course 3_Project/UCI HAR Dataset/train/subject_train.txt"
              , colClasses = "factor", nrows = 3000, col.names = "SubjectID", comment.char = "")
  , read.table("H:/Data Science/Coursera/Course 3_Project/UCI HAR Dataset/train/y_train.txt"
              , colClasses = "factor", nrows = 3000, col.names = "ActivityLabel", comment.char = "")
  , read.table("H:/Data Science/Coursera/Course 3_Project/UCI HAR Dataset/train/X_train.txt"
              , colClasses = "numeric", nrows = 3000, comment.char = ""))

##Step 5
##merge to replace activity label with activity description
testDataMerge <- merge(activityLabels, testData, by.x = "ActivityLabel"
                       , by.y = "ActivityLabel")[,c(3,2,4:564)]
trainDataMerge <- merge(activityLabels, trainData, by.x = "ActivityLabel"
                        , by.y = "ActivityLabel")[,c(3,2,4:564)]

##rename columns from generic V1, V2, V3, ... to 1, 2, 3, ...
##will be field values values after melting dataframe (561 feature variables down to 1)
colnames(testDataMerge)[3:563] <- 1:561
colnames(trainDataMerge)[3:563] <- 1:561

##Step 6
##melt dataframe to reduce 561 feature variables to a single 561-level factor variable
testDataMelt <- 
  reshape2::melt(testDataMerge, id = c("SubjectID", "ActivityDescription")
                 , variable.name = "TimeFrequencyFeature", value.name = "DerivedFeatureValue")
trainDataMelt <- 
  reshape2::melt(trainDataMerge, id = c("SubjectID", "ActivityDescription")
                 , variable.name = "TimeFrequencyFeature", value.name = "DerivedFeatureValue")

##Step 7
##merge/update previous step's outputs (melted dataframes) to only include  
##features with mean() and std() calculations; and combine to establish 
##final dataframe for tidySet1
tidySet1 <- rbind(
  merge(meanstdFeatures, testDataMelt, by.x = "TimeFrequencyFeature"
        , by.y = "TimeFrequencyFeature")[,c(3,4,1,2,5)]
  , merge(meanstdFeatures, trainDataMelt, by.x = "TimeFrequencyFeature"
          , by.y = "TimeFrequencyFeature")[,c(3,4,1,2,5)]
)

##Step 8
##tidySet1 with group_by applied by TimeFrequencyFeatureDescription, 
##ActivityDescription, and SubjectID
tidySet1Grp <- dplyr::group_by(tidySet1, TimeFrequencyFeatureDescription
                               , ActivityDescription, SubjectID)
    
##Step 9
##grouped tidySet1 dataframe is summarized by AvgDerivedFeatureValue and
##then arranged by groupings for readability
dplyr::arrange(dplyr::summarize(tidySet1Grp, AvgDerivedFeatureValue = 
                                  mean(DerivedFeatureValue))[,c(3,2,1,4)]
               , ActivityDescription, SubjectID, TimeFrequencyFeatureDescription)
}
  
