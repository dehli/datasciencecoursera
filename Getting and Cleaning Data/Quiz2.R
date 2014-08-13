library("httr")
library("jsonlite")

oauth_endpoints("github")
myapp <- oauth_app("github", "d0564c2bebe659279422", "cad43bbd666b010c61a1bed10147b40284c2504c")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
data <- content(req)
data <- jsonlite::fromJSON(toJSON(data))
data[5,2]  #name
data[5,45] #creation date

con = url("./search.html")   #("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
nchar(htmlCode[,10])
nchar(htmlCode[,20])
nchar(htmlCode[,30])
nchar(htmlCode[,100])