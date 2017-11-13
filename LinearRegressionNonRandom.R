original_data <-iris
set.seed(104)

####### Set initial parameters
portion <-0.2 # percent of missing values to occupy the data. 0.02 = 2 %
training_size <-0.7 # percent of data for training


data_length <-nrow(original_data)
missing_data <-original_data
id <-portion*data_length
missing_data[1:id,'Petal.Length'] <-NA
missing_data
m <-lm(missing_data$Petal.Length ~ missing_data$Petal.Width, data=missing_data)
missing_data
for(i in 1:nrow(missing_data))
{
  if(is.na(missing_data$Petal.Length[i]))
  {
    missing_data$Petal.Length[i] = coef(m)[1] + coef(m)[2]*missing_data$Petal.Width[i]
  }
}
# #root mean square between imputed and true values
rmse = sqrt(mean( (original_data$Petal.Length - missing_data$Petal.Length)^2, na.rm = TRUE) )
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

set.seed(103)
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
