RBaseData <- read.csv("Z:/Pest Pros/RBaseData.csv")
data.frame(RBaseData)
data.frame(stringAsFactors=FALSE)
class(RBaseData$Season)
class(RBaseData$Grower)
unique(RBaseData$Grower)
unique(ordered(RBaseData$Grower))
RBaseData$Grower[RBaseData$Grower %in% c('Steve Bartsch')] <- 'Bartsch Farms'   #Eliminating duplicates of different spellings/standardization
unique(ordered(RBaseData$Grower))

quantile(RBaseData$EB %in% RBaseData$Season[2004])
range(RBaseData$EB %in% RBaseData$Season=="2012")

library(tidyverse)
library(ggplot2)
Heartland2004 <- RBaseData %>% #Filtering then arranging
  filter(Season == 2004, Grower == "Heartland Farms") %>%
  arrange(desc(Season))
Heartland2004
season_04 <- RBaseData %>% #creating dataframe for each season
  filter(Season == 2004) %>%
  arrange(desc(Season))

season_05 <- RBaseData %>%
  filter(Season == 2005) %>%
  arrange(desc(Season))

season_06 <- RBaseData %>%
  filter(Season == 2006) %>%
  arrange(desc(Season))

season_07 <- RBaseData %>%
  filter(Season == 2007) %>%
  arrange(desc(Season))

season_08 <- RBaseData %>%
  filter(Season == 2008) %>%
  arrange(desc(Season))

season_09 <- RBaseData %>%
  filter(Season == 2009) %>%
  arrange(desc(Season))

season_10 <- RBaseData %>%
  filter(Season == 2010) %>%
  arrange(desc(Season))

season_11 <- RBaseData %>%
  filter(Season == 2011) %>%
  arrange(desc(Season))

season_12 <- RBaseData %>%
  filter(Season == 2012) %>%
  arrange(desc(Season))

season_13 <- RBaseData %>%
  filter(Season == 2013) %>%
  arrange(desc(Season))

season_14 <- RBaseData %>%
  filter(Season == 2014) %>%
  arrange(desc(Season))

season_15 <- RBaseData %>%
  filter(Season == 2015) %>%
  arrange(desc(Season))

season_16 <- RBaseData %>%
  filter(Season == 2016) %>%
  arrange(desc(Season))

season_17 <- RBaseData %>%
  filter(Season == 2017) %>%
  arrange(desc(Season))

season_18 <- RBaseData %>%
  filter(Season == 2018) %>%
  arrange(desc(Season))

season_18


coordinates <- cbind(RBaseData$Centroid.Lat, RBaseData$Centroid.Long)  #option for cbind of Centroid.Long and Centroid.Lat (not necessary for computation)
latitude <- RBaseData$Centroid.Lat
longitude <- RBaseData$Centroid.Long

coordinates

library(sp)  

pts <- SpatialPoints(coordinates)
pts

class(pts)

showDefault(pts)


crdref <- CRS("+init=epsg:3701")  #defining the proj4string for the data frame, or rather spatial object, that I am creating

crdref

pts <- SpatialPoints(coordinates, proj4string=crdref)

pts



