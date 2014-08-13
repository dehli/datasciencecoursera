library("httr")
library("jsonlite")
library("XML")

function1 <- function(){
  oauth_endpoints("github")
  myapp <- oauth_app("github", "d0564c2bebe659279422", "SECRET_KEY")
  github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
  gtoken <- config(token = github_token)
  req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
  stop_for_status(req)
  data <- content(req)
  data <- jsonlite::fromJSON(toJSON(data))
  print(data[5,2])  #name
  print(data[5,45]) #creation date
}

function2 <- function(){  
  con = url("http://biostat.jhsph.edu/~jleek/contact.html")
  htmlCode <- readLines(con)
  close(con)
   
  print(nchar(htmlCode[10]))
  print(nchar(htmlCode[20]))
  print(nchar(htmlCode[30]))
  print(nchar(htmlCode[100]))
}

function3 <- function(){
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
}
