library(datasets)
data(iris)

# mean of 'Sepal.Length' for the species virginica
mean(iris[which(iris$Species=="virginica"),1])

# Returns a vector of the means of the variables
# 'Sepal.Length', 'Sepal.Width', 'Petal.Length', 
# and 'Petal.Width'
apply(iris[, 1:4], 2, mean)



library(datasets)
data(mtcars)

# calculate the average miles per gallon (mpg) by 
# number of cylinders in the car
sapply(split(mtcars$mpg, mtcars$cyl), mean)

# absolute difference between the average horsepower 
# of 4-cylinder cars and the average horsepower of 
# 8-cylinder cars
sapply(split(mtcars$hp, mtcars$cyl), mean)