run_analysis <- function() {
    #extract which measurement we need and get the indices and feature names for them
    features <- read.table(file.path(getwd(), "UCI HAR Dataset", "features.txt"))
    indices <- grep("-(mean|std)\\(\\)-", features$V2)
    features_filtered <- grep("-(mean|std)\\(\\)-", features$V2, value = TRUE)
    colNames <- c("subject", "activity", features_filtered)
    
    activities <- read.table(file.path(getwd(), "UCI HAR Dataset", "activity_labels.txt"))
    
    #prepare the test data
    #   read in the test data
    #   replace the activity ids with their descriptive names
    #   merge the measurements, activities and subjects together by columns
    #   replace the default column names with the appropriate ones
    testDir <- file.path(getwd(), "UCI HAR Dataset","test")
    x_test <- read.table(file.path(testDir, "X_test.txt"))
    x_test_filtered <- x_test[,indices]
    y_test <- read.table(file.path(testDir, "y_test.txt"))
    y_test_descriptive <- merge(y_test, activities, by="V1")$V2
    subject_test <- read.table(file.path(testDir, "subject_test.txt"))
    merged_test <- cbind(subject_test, y_test_descriptive, x_test_filtered)
    colnames(merged_test) <- colNames
    
    #prepare the train data
    #   read in the train data
    #   replace the activity ids with their descriptive names
    #   merge the measurements, activities and subjects together by columns
    #   replace the default column names with the appropriate ones
    trainDir <- file.path(getwd(), "UCI HAR Dataset","train")
    x_train <- read.table(file.path(trainDir, "X_train.txt"))
    x_train_filtered <- x_train[,indices]
    y_train <- read.table(file.path(trainDir, "y_train.txt"))
    y_train_descriptive <- merge(y_train, activities, by="V1")$V2
    subject_train <- read.table(file.path(trainDir, "subject_train.txt"))
    merged_train <- cbind(subject_train, y_train_descriptive, x_train_filtered)
    colnames(merged_train) <- colNames
    
    #merge the test and train data together by rows
    merged_data <- rbind(merged_test, merged_train)
    
    #arrange the data by subject and activity
    #NOTE: "plyr" library is required
    arranged_data <- arrange(merged, subject, activity)
    
    
}