Please follow the instructions below to run the function correctly
# Simple Perceptron Algorithm

## Description

The purpose of this function is to train a simple perceptron algorithm following the slide lecture by Instructor Dr. Abdul Serwadda

## Usage
```
simple_percetron(train, label, epochs, learning_rate, test_data, test_label)
```
## Arguments

train	
train is the data frame for training
label	
label is the vector label for training
epochs	
epochs The number of iterations to scan the data frame. Default value is set to 10 if not specified
learning_rate	
learning_rate Learning rate of the algorithm. Default value is set to 0.01 if not specified
test_data	
test_data is the data frame for testing.
test_label	
test_label is the vector label for testing
Details

If test data (test_data, test_label) is not provided. The function will return the weight vector and the graph of error learning rate. Otherwise, it will return additional confusion matrix and accuracy (percent)

## Value

weight_vector	
Final updated weight vector values after #epochs times
graph of error rate	
Error rate in each epoch is plotted
accuracy	
The accuracy of the trained model on the test data if provided
confusion_matrix	
The confusion matrix indicating prediction vs actual values if test data is provided
##Author(s)

Vinh T. Nguyen, Texas Tech University

## Examples


dataset <-read.csv("dataset.csv")
train <-dataset[1:70,1:3]
label <-as.vector(dataset$label[1:70])
test_data <-dataset[71:100,1:3]
test_label <-as.vector(dataset$label[71:100])
error <-simple_perceptron(train,label,epochs = 20, learning_rate = 0.01, test_data = test_data, test_label = test_label)

[1] "Confusion Matrix"

     0  1
  0 16  0
  1  0 14
The accuracy of the model is:  100

The final weight vector is:  -0.01 -0.012 -0.044 0.075

Add data manually.!
train <- data.frame(c(0,0,1,1),c(0,1,0,1))
label <-c(0,0,0,1)
result <- simple_perceptron(train,label,epochs = 10, learning_rate = 0.4)

The final weight vector is:  -0.8 0.8 0.4
error in each epoch: [1] 1 3 3 2 1 0 0 0 0 0
