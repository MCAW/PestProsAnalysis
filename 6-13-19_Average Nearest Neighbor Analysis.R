#load the relevant packages:
library(sp)
library(raster)
library(sf)
library(ggmap)
library(spatstat)
library(devtools)

##Define the coordinates in your data set:
data.frame(PestProsWGS84)
coordinates <- cbind(PestProsWGS84[1:2])
coordinates

#Define the coordinate reference system for your data set:
crs <- CRS("+proj=longlat + datum=WGS84")

#Create a spatial points onject from your new coordinate matrix (created above).
#The following keeps the data associated with the coordinates.
pts <- SpatialPointsDataFrame(coords = coordinates,
                              data = PestProsWGS84,
                              proj4string = crs)

#check the class to make sure conversion was successful:
class(pts)
showDefault(pts)

#Define your ranges for the PPP object:
xrange <- range(pts$Centroid.Long)
yrange <- range(pts$Centroid.Lat)

#create a ppp object with associated marks (or descriptive data);
PPWGS84ppp <- ppp(PestProsWGS84[,1], PestProsWGS84[,2], xrange, yrange)

#Define marks for your PPP object:
marks(PPWGS84ppp) <- data.frame(Season = factor(pts$Season), EB = factor(pts$EB_Rating), pts$Julian)
marks(PPWGS84ppp)















