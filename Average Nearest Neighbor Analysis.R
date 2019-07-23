#load relevant packages:
library(sp)
library(raster)
library(sf)
library(ggmap)
library(spatstat)
library(devtools)


#Define coordinates from your data set ---

#option 1: produces a matrix with lat and long side by side
coordinates <- cbind(RBaseData.v2$Centroid.Lat, RBaseData.v2$Centroid.Long)

#option 2: define latitude and longitude as it exists within your data frame
latitude <- RBaseData.v2$Centroid.Lat
longitude <- RBaseData.v2$Centroid.Long

#Define the CRS for the pest pros data set:
crdref <- CRS("+init=epsg:3701")


#Create a spatial points onject from your new coordinate matrix (created above). The following keeps the data associated with the coordinates.
pts <- SpatialPointsDataFrame(coords = coordinates,
                              data = RBaseData.v2,
                              proj4string = crdref)

#check the class to make sure conversion was successful:
class(pts)
showDefault(pts)

#check the new CRS object:
crdref

#Define the CRS in conjunction with your spatial points object to associate them:
pts <- SpatialPoints(coordinates, proj4string=crdref)

#check the new object:
pts

#Transform the above coordinate system for compatibility with Google Maps:
SPtrans = spTransform(pts, CRS("+init=epsg:3857"))

#to access the transformed version of the data.frame, you must use the following:
SPtrans

#define the window of you spatial point data frame so you can create a ppp object:
xrange <- range(SPtrans$Centroid.Long)
yrange <- range(SPtrans$Centroid.Lat)

#create a ppp object (with Window)
SPtransppp <- ppp(SPtrans$Centroid.Long, SPtrans$Centroid.Lat, xrange, yrange)

class(SPtransppp)

#Load a base map from ggmap library:
#first, load your API key:
#search for geocoding and geolocating on the google cloud API page to make sure that both API's are enabled
ggmap::register_google(key = "AIzaSyAbb5eD1MGNmf6YRDT4n1S5BMtwVKPTni0")
myMap <- get_map(location = "Wausau, Wisconsin",
                 source = "google",
                 maptype = "terrain", crop = FALSE,
                 zoom = 7)
plot(myMap)




#Average Nearest Neighbor Computation (requires a PPP object) - this is for all years
#Calculate first average nearest neighbor:
mean(nndist(SPtransppp, k=1)) #computes the first nearest neighbor (in km)
mean(nndist(SPtransppp, k=2)) #computes the second nearest neighbor (in km)

ANN <- apply(nndist(SPtransppp, k=1:100),2,FUN=mean)
plot(ANN ~eval(1:100), type="b", main=NULL, las=1)

#K function from ANN:
K1 <- Kest(SPtransppp)
plot(K1, main=NULL, las=1, legendargs=list(cex=0.8, xpd=TRUE, inset=c(1.01, 0) ))



