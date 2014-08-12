one <- function() {
  x <- 4
  print(class(x))
}
two <- function() {
  x <- c(4, "a", TRUE)
  print(class(x))
}
three <- function() {
  x <- c(1,3, 5)
  y <- c(3, 2, 10)
  rbind(x, y)
}
four <- function() {
  x <- 1:4
  y <- 2:3
  print(class(x+y))
  print(x + y)
}

data <- read.csv("hw1_data.csv")

colMeans(data, na.rm=TRUE)

subset(data, Month == 5)

colMeans(subset(data, Month == 6), na.rm=TRUE)

colMeans(subset(data, Ozone > 31 & Temp > 90), na.rm=TRUE)