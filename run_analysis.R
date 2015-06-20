# set working directory
# setwd("~/OneDrive/Coursera/03 - Getting and Cleaning Data/
#       DataScience-03-GCD-Project1")

run_analysis <- function() {
    # Part 1: Merge training and test data into a single data set
    # REMINDER TO REMOVE NROWS TO GET THE FULL DATA SET
    x = rbind( 
        read.table("./data/test/X_test.txt", nrows=100)
        , read.table("./data/train/X_train.txt", nrows=100) 
    )
    
    y = rbind( 
        read.table("./data/test/y_test.txt", nrows=100)
        , read.table("./data/train/y_train.txt", nrows=100)
    )
    
    z = rbind(
        read.table("./data/test/subject_test.txt", nrows=100)
        , read.table("./data/train/subject_train.txt", nrows=100)
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
    names(y) = "Activity Name"
    
    # Part 4: Naming data set
    names(z) = "Subject"
    
    # final merge
    mergedData = cbind(z, y, x)
    write.table(mergedData, "mergedData.txt", row.names=FALSE)
    
    
}

