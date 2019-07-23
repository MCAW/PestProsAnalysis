#install the relevant libraries
install.packages("lubridate")
install.packages("ggplot2")
install.packages("data.table")
install.packages("ggrepel")
install.packages("dplyr")
install.packages("tidyverse")

#load the relevant libraries:
library(lubridate)
library(ggplot2)
library(dplyr)
library(data.table)
library(ggrepel)
library(tidyverse)

#look at your data set:
dim(RBaseData)


#create some color variables for graphing later:
col1 = "#011f4b"
col2 = "#6497b1"
col3 = "#b3cde0"
col4 = "#CC0000"

#Transform variables:
#this is where you may decide to subset seasons, growers, etc.
#also a time to filter out any rows with missing data
s04 <- RBaseData %>%
  filter(Season==2004)

s04 #checking to make sure that the data was filtered correctly

#only include complete cases (they should already be complete, but good to double check):
RBaseData[complete.cases(s04), ]

#install ggmap
#visit https://console.cloud.google.com and sign up or sign into a google cloud platform trial
#create a project. In the top nav, you can either select an existing project or create a new one.
#generate an API key. Navigate to the credentials area and select "Create Credentials". take note of your API key. You will need to register it
#with the package later

#install the ggmap R package and set the API key within R by executing the commands below:
if(!requireNamespace("devtools")) install.packages("devtools")
devtools::install_github("dkahle/ggmap", ref = "tidyup", force=TRUE)
1
#checked to see if all of packages were updated (above)
library("ggmap")
ggmap::register_google(key = "AIzaSyAbb5eD1MGNmf6YRDT4n1S5BMtwVKPTni0")

#example of defining your map:
p <- ggmap(get_googlemap(center = c(lon = -122.335167, lat = 47.608013),
                         zoom = 11, scale = 2,
                         maptype = 'terrain',
                         color = 'color'))

#Defining WI map (reference ggmap cheatsheet for more customization):
myLocation <- c(lon = -90.130186, lat = 44.437778)  #this is the center coordinate for WI
myMap <- get_map(location = myLocation,
                 source = "google", maptype = "satellite", crop = FALSE)
plot(myMap)
#plots a centered map of the state of WI

data.frame(season_04)
head(season_04)

season_04plot <- ggplot(season_04, aes(x = season_04$Centroid.Long, y = season_04$Centroid.Lat), colour = col1) +
  geom_point(alpha = 0.25, size = 0.5)

season_04plot

data.frame(RBaseData)

#grouping growers and seasons from RBaseData:
group_by(RBaseData, Grower, Season)
Season_Grower_Group <- group_by(RBaseData, Grower, Season)
Season_Grower_Group[Season_Grower_Group$EB > 1, min(Season_Grower_Group$Julian, "EB")]
