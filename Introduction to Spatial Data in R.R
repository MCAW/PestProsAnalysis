#Creating a circular window with data:

#Plotting a disc:
# Load the spatstat package
library(spatstat)

# Create this many points, in a circle of this radius
n_points <- 300
radius <- 10

# Generate uniform random numbers up to radius-squared
r_squared <- runif(n_points, 0, 100)
angle <- runif(n_points, 0, 2*pi)

# Take the square root of the values to get a uniform spatial distribution
x <- sqrt(r_squared) * cos(angle)
y <- sqrt(r_squared) * sin(angle)

plot(disc(radius)); points(x, y)

#Simulation and Testing with spatstat:
#spatstat is the first place to go for point-analysis
#we will be examining functionality in 2 dimensions, although there is 3D funcitonality in R

#a "point" is any location in 2-D space.
#for data on a flat plane, this is specified by an X,Y coordinate pair where X and Y can be anything
#between plus and minus infinity.
#there might not be anything happening at this point, its just any location in the plane
#An "event" is where something is happening; its one of your data points.
#sometimes you might call an event a "point," and most people will do that, but strictly in the literature,
#Take for example a forest of trees... although trees can exist at any point, the locations where the trees
#actually are are events
#most spatial analyses are confined to a finite study area, and this area is called the "window"
#events happening outside the window are unobserved
#a "spatial point pattern" is the set of observed events in the window
#a "spatial point process" is a stochastic process; it's like a random number generator for points in a window
#much of spatial analysis is spent making inferences about the point process that may have generated a data set
#spatial point processes may be defined over the whole of 2D space, but are only observed in a window
#in a forest, the spatial process would depend on the soil type, nutrient content, the wind direction, sunlight, etc.
#once you have associated data with points, the points are said to have "marks", and you have a "marked point pattern"
#for example, the height and width of a tree are examples of continuous numerical marks, and the species is a
#categorical mark
#spatstat stores spatial point patterns in its ppp objects, which stands for "planar point pattern"
#the ppp object contains the event coordinates, the window (or boundary) and if its a marked point process, the marks
##the pest pros data could be considered a ppp object
#the simplest ppp object needs only x and y coordinate arguments

##Creating a PPP:
R <- ppp(x = runif(100), y=runif(100))
R
Planar point pattern: 100 points
window: rectangle = [0, 1] x [0, 1] units
summary(R)
Planar Point Pattern: 100 points
Average intensity 100 points ...
Coordinates are given to 8 decimal ...
Window: rectangle = [0, 1] x [0, 1]
Window area = 1 square unit
plot(R)
#As seen i the above, you can also plot ppp objects with plot, print them to the console with print,
#or show their summary information with summary to get basic information

#the simplest point process model is "complete spatial randomness" or "CSR" for short.
#it means no part of the window is any more special than any other part of the window, and that the chance of finding
#an event at any location is the same everywhere
#you can perform a quadrat test to test subregions within a window
data.frame(RBaseData)
spa.1 <- as.matrix(RBaseData)
spa.1
coords <- RBaseData[ , c("Centroid.Lat", "Centroid.Long")] #identifying the coordinates in RBaseData
data <- RBaseData[ , 1:6,9:16]  #identifying data associated with coordinates in RBaseData
crs <- CRS("+init=epsg:3701")
spdf <- SpatialPointsDataFrame(coords = coords,
                               data = data,
                               proj4string = crs)

class(spdf)
spplot(spdf, factor("RBaseData$EB"))

coords
data

###PROJ4 for NEWFIELDS MERGED (PEST PROS DATA): EPSG: 3701; name: NAD83(NSRS2007) / WI Transverse Mercator; State-wide application requiring a single system

df <- RBaseData
df

df[c(1:16, 7:8)]   #Reordering columns in RBaseData



gdalsrsinfoNewFieldsMerged2.prj

gdalsrsinfo(NewFieldsMerged2.prj)
library(gdal)
library(rgdal)
rgdalsrsinfo(NewFieldsMerged2.prj)

NewFieldsMerged2




