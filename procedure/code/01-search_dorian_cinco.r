# search geographic twitter data for Hurricane Dorian
# by Joseph Holler, 2019,2021
# This code requires a twitter developer API token!
# See https://cran.r-project.org/web/packages/rtweet/vignettes/auth.html

# install packages for twitter querying and initialize the library
packages = c("rtweet","here","dplyr","rehydratoR")
setdiff(packages, rownames(installed.packages()))
install.packages(setdiff(packages, rownames(installed.packages())),
                 quietly=TRUE)

library(rtweet)
library(here)
library(dplyr)
library(rehydratoR)
library(tidyverse)

############# SEARCH TWITTER API #############

# reference for search_tweets function:
# https://rtweet.info/reference/search_tweets.html
# don't add any spaces in between variable name and value for your search
# e.g. n=1000 is better than n = 1000
# the first parameter in quotes is the search string
# n=10000 asks for 10,000 tweets
# if you want more than 18,000 tweets, change retryonratelimit to TRUE and
# wait 15 minutes for every batch of 18,000
# include_rts=FALSE excludes retweets.
# token refers to the twitter token you defined above for access to your twitter
# developer account
# geocode is equal to a string with three parts: longitude, latitude, and
# distance with the units mi for miles or km for kilometers

# set up twitter API information with your own information for
# app, consumer_key, and consumer_secret
# this should launch a web browser and ask you to log in to twitter
# for authentication of access_token and access_secret
twitter_token = create_token(
  app = "evankilli.lab",                     #enter your app name in quotes
  consumer_key = "q26rOjeSCYE3XBvNsF7cDOXSN",  		      #enter your consumer key in quotes
  consumer_secret = "Awuh2HBF0axd9RnephymXB4ETmMUQjRDcaPT6vl2W4cAo8gBCF",         #enter your consumer secret in quotes
  access_token = "1288885695789051904-8fIYlqIlk4YqWzUl6HFAHuET5GvCtb",
  access_secret = "rkj1WhXgoqsxkQDNARpAZ9rkWxM5fQsUq4UFa5wNm2aaD"
)

#get tweets for hurricane Dorian, searched on September 11, 2019
cinco <- search_tweets("cinco de mayo", n=50000, include_rts=FALSE, token=twitter_token, geocode="32,-78,1000mi", retryonratelimit=TRUE)


#get tweets without any text filter for the same geographic region in November, searched on November 19, 2019
#the query searches for all verified or unverified tweets, so essentially everything
current2 <- search_tweets("-filter:verified OR filter:verified", n=200000, include_rts=FALSE, token=twitter_token, geocode="32,-78,1000mi", retryonratelimit=TRUE)
current <- readRDS(here("data", "derived", "private", "current.RDS"))

############# LOAD THESE RESULTS - GEOG323 STUDENTS ONLY #############

# Please download the file from here: https://github.com/GIS4DEV/literature/raw/master/dorian/dorian.RData
# into the data\derived\private folder
# then run the following line of code to load the data into your environment

install.packages("tidyverse")
load(here("data","derived","private","dorian.RData"))

# In the following code, you can practice running the queries on dorian3

############# FIND ONLY PRECISE GEOGRAPHIES #############

#reference for lat_lng function: https://rtweet.info/reference/lat_lng.html
#adds a lat and long field to the data frame, picked out of the fields you indicate in the c() list
#sample function: lat_lng(x, coords = c("coords_coords", "bbox_coords"))

# list unique/distinct place types to check if you got them all
unique(cinco$place_type)

# list and count unique place types
# NA results included based on profile locations, not geotagging / geocoding.
# If you have these, it indicates that you exhausted the more precise tweets
# in your search parameters and are including locations based on user profiles
count(cinco, place_type)

# convert GPS coordinates into lat and lng columns
# do not use geo_coords! Lat/Lng will be inverted
cinco = lat_lng(cinco, coords=c("coords_coords"))
current = lat_lng(current, coords=c("coords_coords"))

# select any tweets with lat and lng columns (from GPS) or
# designated place types of your choosing
cinco = subset(cinco,
                place_type == 'city'| place_type == 'neighborhood'|
                  place_type == 'poi' | !is.na(lat))

current = subset(current,
                  place_type == 'city'| place_type == 'neighborhood'|
                    place_type == 'poi' | !is.na(lat))

# convert bounding boxes into centroids for lat and lng columns
cinco = lat_lng(cinco,coords=c("bbox_coords"))
current = lat_lng(current,coords=c("bbox_coords"))

# re-check counts of place types
count(cinco, place_type)

############# SAVE FILTERED TWEET IDS TO DATA/DERIVED/PUBLIC #############

write.table(current$status_id,
            here("data","derived","public","currentids.txt"),
            append=FALSE, quote=FALSE, row.names = FALSE, col.names = FALSE)

write.table(cinco$status_id,
            here("data","derived","public","cincoids.txt"),
            append=FALSE, quote=FALSE, row.names = FALSE, col.names = FALSE)

############# SAVE TWEETs TO DATA/DERIVED/PRIVATE #############

saveRDS(cinco, here("data","derived","private","cinco.RDS"))
saveRDS(current, here("data","derived","private","current.RDS"))
