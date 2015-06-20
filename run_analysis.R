# load required libraries
library(dplyr)
library(lubridate)

# set working directory
# setwd("~/OneDrive/Coursera/03 - Getting and Cleaning Data/
#       DataScience-03-GCD-Project1")

run_analysis <- function() {
    startTime = now()
    
    # Part 1: Merge training and test data into a single data set
    x = rbind( 
        read.table("./data/test/X_test.txt")
        , read.table("./data/train/X_train.txt") 
    )
    
    y = rbind( 
        read.table("./data/test/y_test.txt")
        , read.table("./data/train/y_train.txt")
    )
    
    z = rbind(
        read.table("./data/test/subject_test.txt")
        , read.table("./data/train/subject_train.txt")
    )
    
    # Part 2: Extract mean and standard deviations only
    features = read.table("./data/features.txt")
    #grep==regex
    requiredFeatures = grep("-mean|-std", features[, 2]) 
    x = x[, requiredFeatures]
    names(x) = features[ requiredFeatures, 2 ]
    
    # Part 3: Naming activities in the data set
    activities = read.table("./data/activity_labels.txt")
    #gsub==regex replace
    activities[, 2] = gsub("_", " ", tolower(activities[, 2])) 
    # this line converts the activities to a title case (first letter is caps)
    activities[, 2] = gsub("\\b([a-z])([a-z]+)"
                           , "\\U\\1\\L\\2"
                           , activities[, 2]
                           , perl=TRUE
                           )
    
    y[, 1] = activities[y[, 1], 2]
    names(y) = "ActivityName"
    
    # Part 4: Naming data set
    names(z) = "Subject"
    
    # final merge
    mergedData = cbind(z, y, x)
    write.table(mergedData, "mergedData.txt", row.names=FALSE)
    
    # Part 5: Create a second, independent tidy data set
    # i.e. pivot the data such that you get:
    # average for each variable, for each activity and each subject
    
    p5 = mergedData %>%
        group_by(Subject, ActivityName) %>%
        summarise_each(funs(mean))
    
    write.table(p5, "mergedData_withMeans.txt", row.names=FALSE)
    
    endTime = now()
    print(paste("This function took ", endTime - startTime, "to run."))
}

