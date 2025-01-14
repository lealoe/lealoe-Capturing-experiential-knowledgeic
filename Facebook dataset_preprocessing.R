#################################################################
#
# Facebook comments to news articles analysis
#
# Pre-processing of the texts & Keyword analysis 
# 
################################################################


setwd("C:/Users/...")
fb <- read.csv(file = 'FB_....csv', 
               na.strings=c("", "NA"),encoding = "UTF-8", sep = ";")

library(quanteda)

#Adjust some meta data
colnames(fb)
names(fb)[names(fb) == 'like.summary.total_count'] <- 'like_count'
names(fb)[names(fb) == 'love.summary.total_count'] <- 'love_count'
names(fb)[names(fb) == 'haha.summary.total_count'] <- 'haha_count'
names(fb)[names(fb) == 'wow.summary.total_count'] <- 'wow_count'
names(fb)[names(fb) == 'sad.summary.total_count'] <- 'sad_count'
names(fb)[names(fb) == 'angry.summary.total_count'] <- 'angry_count'

#Change variable class
class(fb$like_count)
fb$like_count <- as.numeric(fb$like_count)

class(fb$comment_count)
fb$comment_count <- as.numeric(fb$comment_count)

#Keep only date not time
class(fb$created_time)
fb$created_time <- as.character(fb$created_time)
fb$created_time <- substr(fb$created_time, 0, 10)


class(fb$message)
fb$message <- as.character(fb$message)

#Check for empty cells
sum(is.na(fb$message))
fb <- subset(fb, !is.na(message))

#Drop rows with very short comments
fb = fb[(which(nchar(fb$message) >= 10)),]

#Drop doubles
sum(duplicated(fb$message)) 
z <- duplicated(fb$message)
which(z==TRUE) 
length(unique(fb$message))
fb <- fb[!duplicated(fb$message), ]


#Save as csv file for python sentiment analysis
write.csv(fb, "Fb_data_forpy.csv", fileEncoding = "UTF-8" )

#############################################