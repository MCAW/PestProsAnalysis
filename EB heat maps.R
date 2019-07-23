#Creating heat maps based on EB pressure:

#load relevant packages:
library(sp)
library(raster)
library(sf)
library(ggmap)
library(spatstat)
library(devtools)
library(tidyr)
library(ggplot2)
library(dplyr)
library(rgdal)

#Start by comparing location of first find (unique value being field):

data.frame(RBaseData.v2)

#I am going to filter by year first, then by field (2004 as an example)
RB2004 <- RBaseData.v2 %>%
  filter(Season == 2004)

#first find EB 2004 data frame:  
firstfindEB2004 <- RBaseData.v2 %>%
  filter(Season == 2004) %>%
  filter(EB == !0) %>%
  group_by(FieldName) %>%
  slice(1) %>%
  arrange(Julian)

#first find EB 2005 data frame:  
firstfindEB2005 <- RBaseData.v2 %>%
  filter(Season == 2005) %>%
  filter(EB == !0) %>%
  group_by(FieldName) %>%
  slice(1) %>%
  arrange(Julian)

#load a base map (google maps in this case). Hancock @ zoom 9 is a good center for WI
ggmap::register_google(key = "AIzaSyAbb5eD1MGNmf6YRDT4n1S5BMtwVKPTni0")
myMap <- get_map(location = ("Plover, Wisconsin"),
                 source = "google",
                 maptype = "satellite", crop = FALSE,
                 zoom = 9)
plot(myMap)

#coordinates for 2004 data set (example)
coordinates <- cbind(firstfindEB2004$Centroid.Long, firstfindEB2004$Centroid.Lat)

#define the CRS:
crdref <- CRS("+init=epsg:3701") #this is the CRS for PestProsData out of ARC


pts <- SpatialPointsDataFrame(coords = coordinates,
                              data = firstfindEB2004,  #specifying to include ONLY the column with the EB data
                              proj4string = crdref)

#transformation for google maps:
pts = spTransform(pts, CRS("+init=epsg:3857"))

plot(pts, pch = 20, col = "red")

ggmap(myMap) +
  geom_point(aes(x = Centroid.Long, y = Centroid.Lat), data = firstfindEB2004, size = 10)


#Trying to convert UTM coordinates to DDM for Google Maps:
sputm <- SpatialPoints(RBaseData.v2[,8:9], proj4string=CRS("+init=epsg:3701"))
spgeo <- spTransform(sputm, CRS("+proj=longlat + datum=WGS84"))
spgeo

#This works!!!
PestProsWGS84 <- cbind((as.data.frame(spgeo)), RBaseData.v2)
#removing old columns
PestProsWGS84 <- PestProsWGS84[,-10]
PestProsWGS84 <- PestProsWGS84[,-10]
#had to do it twice to remove lat and long because pairing the columns with the "-" sign wasn't working

#Trying to map Lat/Long as spatial points with new WGS84 format:

#I am going to filter by year first, then by field (2004 as an example)
RB2004 <- PestProsWGS84 %>%
  filter(Season == 2004)

#first find EB 2004 data frame:  
firstfindEB2004 <- PestProsWGS84 %>%
  filter(Season == 2004) %>%
  filter(EB == !0) %>%
  group_by(FieldName) %>%
  slice(1) %>%
  arrange(Julian)

#first find EB 2005 data frame:  
firstfindEB2005 <- PestProsWGS84 %>%
  filter(Season == 2005) %>%
  filter(EB == !0) %>%
  group_by(FieldName) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2006 <- PestProsWGS84 %>%
  filter(Season == 2006) %>%
  filter(EB == !0) %>%
  group_by(FieldName) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2007 <- PestProsWGS84 %>%
  filter(Season == 2007) %>%
  filter(EB == !0) %>%
  group_by(FieldName) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2008 <- PestProsWGS84 %>%
  filter(Season == 2008) %>%
  filter(EB == !0) %>%
  group_by(FieldName) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2009 <- PestProsWGS84 %>%
  filter(Season == 2009) %>%
  filter(EB == !0) %>%
  group_by(FieldName) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2010 <- PestProsWGS84 %>%
  filter(Season == 2010) %>%
  filter(EB == !0) %>%
  group_by(FieldName) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2011 <- PestProsWGS84 %>%
  filter(Season == 2011) %>%
  filter(EB == !0) %>%
  group_by(FieldName) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2012 <- PestProsWGS84 %>%
  filter(Season == 2012) %>%
  filter(EB == !0) %>%
  group_by(FieldName) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2013 <- PestProsWGS84 %>%
  filter(Season == 2013) %>%
  filter(EB == !0) %>%
  group_by(FieldName) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2014 <- PestProsWGS84 %>%
  filter(Season == 2014) %>%
  filter(EB == !0) %>%
  group_by(FieldName) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2015 <- PestProsWGS84 %>%
  filter(Season == 2015) %>%
  filter(EB == !0) %>%
  group_by(FieldName) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2016 <- PestProsWGS84 %>%
  filter(Season == 2016) %>%
  filter(EB == !0) %>%
  group_by(FieldName) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2017 <- PestProsWGS84 %>%
  filter(Season == 2017) %>%
  filter(EB == !0) %>%
  group_by(FieldName) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2018 <- PestProsWGS84 %>%
  filter(Season == 2018) %>%
  filter(EB == !0) %>%
  group_by(FieldName) %>%
  slice(1) %>%
  arrange(Julian)

EBFirstfinds_Allseason <- rbind(firstfindEB2004, firstfindEB2005, firstfindEB2006, firstfindEB2007, firstfindEB2008, firstfindEB2009, firstfindEB2010, firstfindEB2011,
     firstfindEB2012, firstfindEB2013, firstfindEB2014, firstfindEB2015, firstfindEB2016, firstfindEB2017, firstfindEB2018)


#coordinates for 2004 data set (example)
coordinates_allfirstfindEB <- cbind(EBFirstfinds_Allseason[,1], EBFirstfinds_Allseason[,2])


#creating a spatial points data frame
pts04 <- SpatialPointsDataFrame(coords = coordinates04,
                              data = firstfindEB2004[,12],  #specifying to include ONLY the column with the Julian date
                              proj4string = CRS("+proj=longlat + datum=WGS84"))
plot(pts04, pch = 20, col = "red")


#Map of first finds by field in 2004:
ggmap(myMap) +
  geom_jitter(data = EBFirstfinds_Allseason %>%
               filter(Season == 2004), 
             aes(x = Centroid.Long, y = Centroid.Lat, color = as.numeric(Julian), alpha = 0.5)) +
  scale_colour_gradient(low = "yellow", high = "red", limits = c(x = 130, y = 250), breaks = seq(130, 250, by = 20)) +
  labs(title = "First Report of Early Blight by Field: 2004", x = "Longitude (DD)", y = "Latitude (DD)", col = "Julian Day") +
  scale_alpha(guide = 'none') +
  theme(plot.title = element_text(size = 12, hjust = 0.5))

#Look at the first find throughout all seasons and the distribution:
#first find EB 2004 data frame:  
firstfindEB2004 <- PestProsWGS84 %>%
  filter(Season == 2004) %>%
  filter(EB == !0) %>%
  slice(1) %>%
  arrange(Julian)

#first find EB 2005 data frame:  
firstfindEB2004 <- PestProsWGS84 %>%
  filter(Season == 2004) %>%
  filter(EB == !0) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2005 <- PestProsWGS84 %>%
  filter(Season == 2005) %>%
  filter(EB == !0) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2006 <- PestProsWGS84 %>%
  filter(Season == 2006) %>%
  filter(EB == !0) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2007 <- PestProsWGS84 %>%
  filter(Season == 2007) %>%
  filter(EB == !0) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2008 <- PestProsWGS84 %>%
  filter(Season == 2008) %>%
  filter(EB == !0) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2009 <- PestProsWGS84 %>%
  filter(Season == 2009) %>%
  filter(EB == !0) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2010 <- PestProsWGS84 %>%
  filter(Season == 2010) %>%
  filter(EB == !0) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2011 <- PestProsWGS84 %>%
  filter(Season == 2011) %>%
  filter(EB == !0) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2012 <- PestProsWGS84 %>%
  filter(Season == 2012) %>%
  filter(EB == !0) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2013 <- PestProsWGS84 %>%
  filter(Season == 2013) %>%
  filter(EB == !0) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2014 <- PestProsWGS84 %>%
  filter(Season == 2014) %>%
  filter(EB == !0) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2015 <- PestProsWGS84 %>%
  filter(Season == 2015) %>%
  filter(EB == !0) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2016 <- PestProsWGS84 %>%
  filter(Season == 2016) %>%
  filter(EB == !0) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2017 <- PestProsWGS84 %>%
  filter(Season == 2017) %>%
  filter(EB == !0) %>%
  slice(1) %>%
  arrange(Julian)

firstfindEB2018 <- PestProsWGS84 %>%
  filter(Season == 2018) %>%
  filter(EB == !0) %>%
  slice(1) %>%
  arrange(Julian)

EBFirstfinds_Allseason <- rbind(firstfindEB2004, firstfindEB2005, firstfindEB2006, firstfindEB2007, firstfindEB2008, firstfindEB2009, firstfindEB2010, firstfindEB2011,
                                firstfindEB2012, firstfindEB2013, firstfindEB2014, firstfindEB2015, firstfindEB2016, firstfindEB2017, firstfindEB2018)
#Map of the first find in each season
#---Defining new map because zoom is too far out:
myMap <- get_map(location = ("Hancock, Wisconsin"),
                 source = "google",
                 maptype = "satellite", crop = FALSE,
                 zoom = 9)
#define the bounding box for your points:
bbox <- make_bbox(EBFirstfinds_Allseason$Centroid.Long, EBFirstfinds_Allseason$Centroid.Lat, f = 0.25)
EBfirstmap <- get_map(bbox)
EBfirstfindallseasonmap <- ggmap(EBfirstmap) +
  geom_jitter(data = EBFirstfinds_Allseason, aes(x = Centroid.Long, y = Centroid.Lat, color = (as.factor(Season)), alpha = 0.2), size = 3)+
  geom_point(color = "black", shape = 1) +
  labs(title = "First Report of Early Blight by Season: 2004 - 2018", x = "Longitude (DD)", y = "Latitude (DD)", color = "Season") +
  scale_alpha(guide = 'none') +
  theme(plot.title = element_text(size = 12, hjust = 0.5))



#Make a density plot for all years:
ggmap(myMap) +
  stat_density2d(
    data = EBFirstfinds_Allseason, aes(x = Centroid.Long, y = Centroid.Lat, fill = ..level.., alpha = 0.25),
    size = 0.2, bins = 50, geom = "polygon"
  )






bboxrough_x <- c(482604.066100, 615413.940600)
bboxrough_y <- c(285201.847200, 493965.769800)
cbind(bboxrough_x, bboxrough_y)
bboxrough <- SpatialPoints(cbind(bboxrough_x, bboxrough_y), proj4string=CRS("+init=epsg:3701"))
bbox_myMap <- spTransform(bboxrough, CRS("+proj=longlat + datum=WGS84"))

bbox_myMap
as.data.frame(bbox_myMap)

#bbox for my_Map (Pest Pros field extent):  
myLocation <- c(-90.45909, 43.03858, -88.79123, 44.91272)

#writing a csv for new data set:
write.csv(PestProsWGS84, "C:\\Users\\mcapp\\OneDrive\\Documents\\R\\PestProsAnalysis\\Data\\PestProsWGS84.csv")
