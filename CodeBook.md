# Codebook describing variables used

Primary working variables: 
* x - The main data set. Each 
* y - data set containing activities
* z - data set containing subjects

Pulling label names:
* features - variable created from extracting data to be used as the feature label names for x
* requiredFeatures - variable that stores the indexes of our desired columns for subsetting
  * This brought down the data frame from 561 variables down to 79 variables (since we only wanted to show the mean and standard deviations)
* activities - variable created frome xtracting data to be used as the activity label names for y

Final data set:
* mergedData - variable that stores the final merged data set

Additional processing:
* p5 - variable used to store the chained result of grouping and summarising the data as required
* startTime - time that the function started running
* endTime - time that the function stopped running

See the README.md file for instructions on how to get the data and how to run the code. 
