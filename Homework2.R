original_data <-iris
set.seed(103)

####### Set initial parameters
portion <-0.02 # percent of missing values to occupy the data. 0.02 = 2 %
training_size <-0.7 # percent of data for training


data_length <-nrow(original_data)
missing_data <-original_data
missing_data[sample(1:data_length,portion*data_length),'Sepal.Length'] <-NA
missing_data <-knnImputation(missing_data)
#impute missing data with mean
# missing_data$Sepal.Length[is.na(missing_data$Sepal.Length)] <-mean(missing_data$Sepal.Length, na.rm = TRUE)
# #root mean square between imputed and true values
rmse = sqrt(mean( (original_data$Sepal.Length - missing_data$Sepal.Length)^2, na.rm = TRUE) )
print("RMSE")
rmse
#Random splitting of iris data as 70% train and 30%test datasets


#first we normalize whole dataset
indexes <- sample(1:nrow(iris), floor(training_size*nrow(iris)))
iris.train <- iris[indexes,-5]
iris.train.target <-  iris[indexes,5]
iris.test <- iris[-indexes,-5]
iris.test.target <- iris[-indexes,5]
original_prediction <- knn(train=iris.train, test=iris.test, cl=iris.train.target, k=3)
confusion_matrix <- table(iris.test.target, original_prediction)
accuracy <- (sum(diag(confusion_matrix)))/sum(confusion_matrix)
accuracy

set.seed(101)
indexes_imputed <- sample(1:nrow(missing_data), floor(training_size*nrow(missing_data)))
iris.imputed.train <- missing_data[indexes_imputed,-5]
iris.imputed.train.target <-  missing_data[indexes_imputed,5]
iris.imputed.test <- missing_data[-indexes_imputed,-5]
iris.imputed.test.target <- missing_data[-indexes_imputed,5]

imputed_prediction <- knn(train=iris.imputed.train, test=iris.imputed.test, cl=iris.imputed.train.target, k=3)
imputed_confusion_matrix <- table(iris.imputed.test.target, imputed_prediction)
imputed_confusion_matrix
imputed.accuracy <- (sum(diag(imputed_confusion_matrix)))/sum(imputed_confusion_matrix)
imputed.accuracy