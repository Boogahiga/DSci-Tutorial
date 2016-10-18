######################
##       Setup      ##
######################

## Install packages ??
# install.packages("XML")
# install.packages("RCurl")
# install.packages("httr")





## Setup & Clear memory (variables) 
rm(list=ls(all.names=TRUE))
library(XML)
library(RCurl)
library(httr)

## Check language 
# Sys.getlocale("LC_ALL")
Sys.setlocale(category = "LC_ALL", locale = "cht")
startNo = 4637
endNo   = 4641 
subPath <- "https://www.ptt.cc/bbs/movie/index"
alldata = data.frame()

for( pid in startNo:endNo )
    {
      urlPath <- paste(subPath, pid, ".html", sep='')
      temp    <- getURL(urlPath, encoding = "big5")
      xmldoc  <- htmlParse(temp)
      
      ## xpathSApply vs. xpathApply
      ## the backscape symbol \"
      title   <- xpathSApply(xmldoc, "//div[@class=\"title\"]", xmlValue)
      
      ## Clean data "\n\t..."
      # regular expression: http://regexr.com/ 
      # title = gsub("\\[n-t]", "", title) //not working?? 
      title   <- gsub("\n", "", title)
      title   <- gsub("\t", "", title)
      
      
      # no value for path 
      path    <- xpathSApply(xmldoc, "//div[@class='title']/a//@href")
      Erroresult<- tryCatch({
        subdata <- data.frame(title, path)
        alldata <- rbind(alldata, subdata)
      }, warning = function(war) {
        print(paste("MY_WARNING:  ", urlPath))
      }, error = function(err) {
        print(paste("MY_ERROR:  ", urlPath))
      }, finally = {
        print(paste("End Try&Catch", urlPath))
      })
    }

write.table(alldata, file = "movie.csv")
suburlPath <- "https://www.ptt.cc"
for( i in 1:length(alldata[,1]) )
    {
      ipath   <- paste(suburlPath, alldata$path[i], sep='')
      print(ipath)
      content <- getURL(ipath, encoding = "big5")
      xmldoc  <- htmlParse(content)
      article <- xpathSApply(xmldoc, "//div[@id=\"main-content\"]", xmlValue)
      filename<- paste("./data/", i, ".csv", sep='')
      write.csv(article, filename)
    }
