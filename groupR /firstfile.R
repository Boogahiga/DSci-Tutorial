library(httr)
library(XML)
library(RCurl)

# get download page url path 
pathURL = "https://www.ptt.cc/bbs/movie/index.html"
tempDATA = getURL(pathURL)

# /n, /t: html => xxl
xmldoc = htmlParse(tempDATA, encoding = "UTF-8")

# \
title = xpathApply(xmldoc, "//div[@class=\"title\"]", xmlValue)
url = xpathApply(xmldoc, "//div[@class=\"title\"]/a//@href",  xmlValue)
date = xpathApply(xmldoc, "//div[@class=\"date\"]", xmlValue)
alldata = data.frame(title)


