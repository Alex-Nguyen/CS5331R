#VINH NGUYEN

#Import built-in dataset which contain 150 obs and 5 variables
library(stats)
library(ggplot2)
iris
str(iris)
# 'data.frame':	150 obs. of  5 variables:
# $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
# $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
# $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
# $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
# $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...

# TAPPLY FUNCTION
# First we would like to calculate the mean of Sepal.Length over each group of species. 
# One traditional way to do it is to subset the whole data set into three part corresponding to each caterogy.
## First approach using loop function to iterate through each element and accumulate result
#initialize mean value of each group to zero
forloopf <-function(){
  setosa.sum <-0;
  setosa.count <-0;
  versicolor.sum <-0;
  versicolor.count <-0;
  virginica.sum <-0;
  virginica.count <-0;
  
  for(i in 1:nrow(iris)){
    if(iris$Species[i]=="setosa"){
      setosa.sum = setosa.sum + iris$Sepal.Length[i]
      setosa.count = setosa.count+1;
    }  
    
    if(iris$Species[i]=="versicolor"){
      versicolor.sum = versicolor.sum + iris$Sepal.Length[i]
      versicolor.count = versicolor.count+1;
    }  
    
    if(iris$Species[i]=="virginica"){
      virginica.sum = virginica.sum + iris$Sepal.Length[i]
      virginica.count = virginica.count+1;
    }  
    
  }
  setosa.mean <-setosa.sum/setosa.count
  versicolor.mean <-versicolor.sum/versicolor.count
  virginica.mean <-virginica.sum/setosa.count
  
}



#2nd approach is to use tapply function with one line of code


tapply_f <- tapply (iris$Sepal.Length, iris$Species, mean)

mbm = microbenchmark(tapply_f <- tapply (iris$Sepal.Length, iris$Species, mean), forloopf(), times =50L)
autoplot(mbm)

# SAPPLY and LAPPLY FUNCTION
#These two functiosn work in a similar way, that is, traversing over a set each element in the dataset and apply the defined function to each element. LAPPLY return the output as a list whereas sapply return as a vector for easy visualization.
# say we have a vector of 10 element, c(2:20), we want to raise to power of two in each element
data <-c(1:1000)
#lapply(c(1:10), function(x) x^2)
#sapply(c(1:10), function(x) x^2)
#
loop2 <-function(){
  for(i in 1:length(data)){
    data[i] = data[i]^2
  }
}

loop2vslapply = microbenchmark(lapply(data, function(x) x^2), loop2(), times =50L)
autoplot(loop2vslapply)

loop2vssapply = microbenchmark(sapply(data, function(x) x^2), loop2(), times =50L)
autoplot(loop2vssapply)

sapplyvslapply = microbenchmark(sapply(data, function(x) x^2), lapply(data, function(x) x^2), times =50L)
sapplyvslapply

#MAPPLY function is for Multivariate. The idea of mapply function is that it applies a function in parallel over a set of arguments. We've noticed about lapply, tapply, sapply is that they only apply a function over the elements of a single object
#Example the input of lapply function is a single list and then the function was applied over the elements of that list. What happens if you have two lists that you want to apply a function over? the element of the first list go into the one argument of the function 
#and the elements of the second list go into another argument of the function. So lapply and sapply can't really be used for that purpose. One way to do that is to write a for loop where the for loop will index the elements of each of the different lists
# and you can pass a function to each of those elements of the list
# Another way to do that is with mapply where mapply can take multiple list arguments and then apply a function to the element of those multiple lists in parallel. The function of mapply is little bit different because it has to allow the possibility of a variable
# of arguments 
# The first argument of the mapply is the function you want to apply and the function you're going to pass to mapply has to have the number of arguments that the function takes has to be at least as many as the number of lists that you're going to pass
#to mapply 
data1 <- c(4,6,8)
data2 <- c(6,2,7)

loopvsmapply = microbenchmark(for(i in 1:length(data1)){
  data1[i] = data1[i]^data2[i]
}, mapply(function(x,y) x^y, data1, data2 ), times =5L)
autoplot(loopvsmapply)