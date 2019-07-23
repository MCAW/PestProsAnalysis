#Notes from: Learning R for Geospatial Analysis
#Logical Operators in R:
# ==: Equal to
# >: Greater than
# >=: Greater than or equal to
# <: Less than
# <=: Less than or equal to
# !=: Not equal to
# &: and
# |: or; when at least one of the expressions at either side of this operator is true, TRUE is returned
# !: not (usually in the case of asking when a condition in NOT satisfied)

(1<10) | (10<100)
[1] TRUE

(1<10) | (10>100)
[1] TRUE

#An example with !:
(1 == 1)  & !(2 == 2)
[1] FALSE

#Character values: In R, these are delimited by quotes
#trying to call mathematical operations on characters will result in an error message

#Returned predefined values of an unsuccessful operation may include:
#NaN: not a numnber
#NA: Not available
#NULL: an empty object
#TRUE and FALSE: logical values
#Inf: i.e. typing 1/0

#Recap: the basic object types in R
#everything in R is an object, and objects are assigned to classes
#class() returns the class of an identified or called object; characters must be in quotes
#the three types of values that are most useful for most purposes are numeric, character, and logical

#vectors:
# the most simple data structure, composed of values of the same 'type'; a single value is also a vector of length 1

#viewing a value or object:
print()

#creating a vector:
#can be done with concatenate, or c(x,y,z), or c("EB","grower","season") (not entire groups, here just pretend they are individual values)
#using : will be a simple way of creating a vector of specified length; can be in ascending or descending order

#a logical vector can also be created with the c function; since logical values are not characters, they do not need quotes

#Converting vectors to a different value type:
#hte two most useful ones are
as.numeric()
as.character()

#Factors:
#a factor is a special type of encoding for a vector, where the vector has a defined set of applicable values or levels
#the factor() function can be used to convert a vector into a factor
#when reading a table from a file, character columns are encoded as factors be default
factor(c("cat", "dog", "dog"))
[1] cat dog dog
Levels: cat dog

#Object assignment:
# two different symbols can be used for assignment; "=" or "<-". I use the right one by default because "=" is easy to confuse with "==" (the equality symbol)
#when assigning an object with a name that already exists in memory, the older project is deleted and replaced by the new one
#the ls() function returns a character vector with the names of all the user-defined objects (in a given environment)
#remove objects from memory with the rm("v") function, for example; if you want to remove all objects from memory, use rm(list = ls())

#checking logical vectors for "any" and "all":
any()
all()
#tells you if any or all of the vectors specified are true or not
#you can use mathematical operations on logical vectors, as well, such as sum() to tell you how many of the objects are true
#this is because logical vectors can be read as TRUE = 1, and FALSE = 0
#which() returns the number in list order that is "true" of your vectorized lst

#return the number in a list that is the max or min:
which.min()
which.max()

#return a list of unique values:
unique()

#Check whether a value in one vector is present in another:
1 %in% 10
[1] TRUE
#with %in% we basically ask whether the value(s) of a vector on the left match any of the values of a vector on the right
#the same can be achieved with:
any(1:10 == 1)
[1] TRUE

#Working with character vectors:
paste()
#the above function can be used to combine separate elements into a single character string.
#the sep parameter of this function determines which characters will be used to separate the values (a single space is the default)
paste("There are", "5", "books.")
[1] "There are 5 books."
#you can also use paste with vectors:
paste("Image", 1:5)
[1] "Image 1" "Image 2" "Image 3" "Image 4" "Image 5"
#the paste() function automatically converts numeric values into characters if characters are supplied:
x = 80
paste("There are", x, "books.")
[1] "There are 80 books."

paste0()
#the above function does the same thing as paste() with the default separator being nothing

#Applying operations to multiple vectors:
#when a function is applied to two vectors of the same length, the operation is applied to each consecutive pair
#when the two vectors are unequal: the shorter of the two is recycled (or is rerun in a loop in a sort of way) so that it continues in sequence
#until the longer vector is completely read by the operation
#if the shorter vector is not a multiple of the longer vector (i.e., it is not repeated completely, like the third time it is repeated only the
#first two values of three are used) then you receive a warning message that "longer object length is not a multiple of shorter object length"

#Functions with several parameters:
#one of the most useful examples of this is with seq() using from(), by(), and to()
#from specifies the starting place, to() the end, and by() the size or interval
seq(from = 100, to = 150, by = 10)
[1] 100 120 130 140 150
#it can also be done in reverse order like other vectorization
#from, to, and by can be obmitted if the values are entered in order
seq(100, 150, 10)
# 1 is the default "by" argument, so the following two would return the same end point:
seq(5, 10)
seq(5, 10, 1)

#Creating repetitive vectors:
rep(x = 22, times = 10)
[1] 22 22 22 22 22 22 22 22 22 22
#you can also return a repeating sequence in the same way:
x = c(18, 0, 9)
rep(x, 3)
[1] 18 0 9 18 0 9 18 0 9

#Substrings
#substr() allows us to create a subset of characters within an individual element of a vector, rather than a subset of the vector's elements
#this requires the start and stop values of the vector
x = "subsetting strings"
substr(x, start = 1, stop = 14)
[1] "Subsetting str"
substr(x, 6, 14)
#it is inclusive, meaning it returns the characters within the specified length or location

#Subsetting with numeric vectors of indices:
x = c(5,6,1,2,3,7)
x[3]
[1] 1
#you can also specify a new value in the place of an existing character with the brackets:
x[3] = 300
x
[1] 5 6 300 2 3 7
#you can also use the comma and : within the brackets to specify more than one character you would like to change

#if you want to repeat a called character more than once:
x = c(43,85,10)
x[rep(3,4)]
[1] 10 10 10 10
#recycling also applies to assignments in susbsets

#returning specified conditions from a vector:
x <- 85 87 89 91 93 95 97 99
x[x>85 & x<90]
[1] 87 89
x[x>92 | z<86]
[1] 85 93 95 97 99
#if none of the elements satisfies the required condition, we will get an empty vector as a result or FALSE
numeric(0) or FALSE

#Dealing with NA
#if NA is in a vector or sequence, and we apply a mathematical operation, we may receive an NA
#detect NA with is.na()
#to check which values in a vector are not NA, !is.na(x)
#to return a list of the values that are not NA: x[!is.na(x)]

#perform calculations on vetors with missing values:
mean(x[!is.na(x)])
#you can also use na.rm = TRUE within an operation to specify that you want to skip NA values in the calculation:
mean(x, na.rm = TRUE)


#Working with dates and time series:
#convert character vectors to date with the function as.Date()


#Working with data tables:
#to create a data.frame, apply data.frame() function that includes defined vectors
#in a data frame, all vectors included must have the same length

#retaining character class of columns when specifying a data frame:
df <- data.frame(RBaseData +
                   stringAsFactors = FALSE)

#add rows or columns to a data frame:
rbind()
cbind()
row5 = c(5, "e", "E")
rbind(df, row5)

#Subsetting data.frame objects:
#assign new values within a data.frame by column:
dat$tpcp[dat$tpcp == -9999] = NA

#because data.frames are two dimensional, when you perform an operation you need to specify both row and column
#leaving an empty space instead of a row or column index indicates we are interested in all of the elements of the respective dimension

#Return specific values from a data frame:
df[df$lower %in% c("a","d"), c("lower", "upper")]
#in the above expression, we put in plain language that we want to return the subset of df with the rows being where the values of the lower
#column are either "a" or "d", and the columns are both "lower" and "upper" (return df where lower and upper contain those values)

#calculating new data fields or columns:
df$word[df$sum == 2] = "Two"
#above, we are saying that we want to add a column "word", in which if the column num is equal to two, print the word "Two". If no match
#word column will read <NA>


#Conditional Statements:
x = 3
if(x>2) {print("x is ;arge!")}
[1] "x is large!"
#A conditional statement is composed of the following elements:
#the conditional statement operator (if)
#the condition in parentheses (for exmaple, (x>2))
#code section opening brackets ({)
#the code section to execute when the condition is met
#code section closing brackets (})
#optionally, the else operator (else())
#optionally, the opening bracket ({)
#optionally, the code to execute when the condition is not met
#optionally, section closing brackets (})

#ifelse function:
#need to supply three arguments: a logical vector, a value for TRUE (the yes parameter), and a value for FALSE (the no parameter)
#this is useful when we want to classify the values of a given vector into two categories, according to a condition:
dat$mmxt[1:7]
[1] (series of data)
ifelse(dat$mmxt [1:7] < 10, "cold", "warm")
[1] (returns either cold or warm depending on vector values)

#repeatedly executing code sections with loops
#loops are used when we need a code section to executed repeatedly
#in a for() loop, a code section is executed a predetermined number of times. 
#this number of times is equal to the number of elements in a vector that we supply when we initiate the loop
#the code section is thus executed once for each element in the vector; in each such run of the loop, the assignment of the current
#element in that vector is made to an object that we can then use in the code within the loop
for(i in 1:5) {print (i)}
[1] 1
[1] 2
[1] 3
[1] 4
[1] 5
#a for loop contains the collowing components:

data.frame(RBaseData.v2)

#return the Julian day associated with the first non-zero EB recording each season:
tapply(season_04$EB, season_04$Julian, function(a)head(which(a>0),1))

#reshaping data:
#useful packages include:
reshape2
pplyr::
  #transforming between wide and long data formats:
  #wide tables: consist of columns for each measured variable
  #long tables: a single column holds the variable names, and another holds the measured values
  #in reshape2, variables in columns are called identifier variables (id.vars) and the other type is measure.vars
  
#to convert to long data format:
  #can use the melt() function, which is used to convert wide formats to long formats
  #to use melt:
    #you need to specify that data.frame object to reshape, and
    #the identity of the ID and measure variables (as character vectors)
    #we can specify either the ID or measure variables, and the function will assume that the rest of the columns belong to the other kind
#Example:
  library(reshape2)
  iris_melt = melt(iris, id.vars = "Species")
  head(iris_melt)
#dcast() can also be used to bring data back into a wide format, and also allows you to re-order the columns
  
#ddply() is a function that allows you to create subsets and then bring them together
  #it operates on a data.frame object returning a new data.frame
  #it first splits the table to subsets according to the unique levels in one or more columns
  #the data from each subset is then used to calculate a single value, for each of the new columns in the new data.frame object
  #ddply contains several arguments:
  #the input data.frame
  #the name(s) of the columns, which defines subsets, in parentheses and prededed by . (for example, .(Species)). If there is more than one name,
  #they will be separated by commas
  #the mode of operation; possible methods are: summarize- the new columns for a new, aggregated, table. Or transform- the new columns are appended
  #back to the input table
  #the fourth argument and onward (fifth, sixth, and so on) are the user-specified expressions for calculation of new columns based on values in the
  #original columns
  
#Joining Tables with join()
  #the plyr library contains this function
  #there are many methods to do this in R, but an advantage of doing it with join is that it preserves the original rows in the data.frame object
  #we join to
#parameters of join:
  #x and y, which indicate the names of the two data.frame objects to join,
  #the third parameter is by, which indicates which column(s) to join
  #the other two parameters indicate, by default, that we would like to perform a left join (type="left", retaining all rows of x, as opposed
  #to a "right" join where we retain all rows of y) and retain all records if there are duplicates(match="all"), which is what we would like to do in most cases
  
#when you want to create a table that repeats each specified element of a vector:
  month = c(12, 1:11)
  month
  [1] 1 2 3 4 5 6 7 8 9 10 11
  season = rep(c("winter", "spring", "summer", "fall"), each = 3)
  season
  [1] "winter" "winter" "winter" "spring" "spring" "spring"
  [7] "summer" "summer" "summer" "fall" "fall" "fall"
  seasons = data.frame(month, season)
  seasons
    month  season (following is two columns in which the month is listed on one side, the sesaon and month on another)
    

#Chapter 4: Working with Rasters
#a raster: essentially a matrix with spatial reference information
#a matrix: where the number of elements in all rows is identical
    #parameters of a matrix:
    #data: the vector of values for the matrix (i.e. 1:6)
    #nrow: the number of rows
    #ncol: the number of columns
    #byrow: whether the matrix is filled column by column (FALSE, which is the default value) or row by row (TRUE)
 #calling length() of a matrix returns the number of elements (total, not just n col or n row)
#dim() of a matrix returns the number of rows and columns at the same time
#as.vector() converts a matrix into a vector (the values will always be ordered by column)
  
#an array: used to represent sets of elements having any number of dimensions (including one and two)
    
#a raster: what separates it from the other types of data organization is that it has spatial referencing
    #rgdal and raster packages are the most frequently used packages for working with rasters
#levelplot, which is an operation that is a part of the rasterVis package, displays all of the bands of a given raster using a single color scale
    
#Chapter 5: Working with Points, Lines, and Polygons
    #here, we will refer to them as vector layers
    #the most common packages for vector layers include sp, rgdal, and rgeos
#for me, the most useful class for spatial analysis will likely be SPatialPointsDataFrame

#Points:
    #simplest type of spatial objects sice the geometrical component of a point is just a single (x,y) coordinate.
    #a set of x,y coordinates along with CRS info constitutes a spatial point layer, which can be represented in R with a spatialpoints object
    #when we also have an attribute table where each row corresponds to a single point, the layer can be represented with a SpatialPointsDatarame object
  #Step 1 - Create a character vector (i.e. airports and addresses)
  #Step 2 - load the ggmap package and geocode the addresses using the geocode function
  #step 3 - add or join your attributes
  #step 4 - use the coordinates function of the sp package to specify the columns that hold the coordinates with a formula object of structure
  # ~x_coord+y_coord
  #i.e.: library(sp)
    coordinates(airports) = ~ lon + lat
  #step 5 - specify the CRS
    proj4string(airports) = CRS("proj=longlat +Datum=WGS84")
    
#you can also remove attributes from a spatialdataframe altogether, creating just a spatial* object
    
#Reprojection of vector layers:
    #this is the conversion of a spatial object from one CRS to another.
    #this is done with the spTransform function of the rgdal package
    #first, you define or assign the newProj; then, you use a formula such as the following to reassign the new CRS:
    county = spTransform(county, newProj)
    
#Working with geometrical properties of vector layers:
    coordinates(airports)
    #for example, returns the coordinates instantly of an object
  #to derive more complex geometric properties, we use the rgeos package
    
#Spatial Relations between vector layers
    #this requires the overlay of features from two distinct layers, although, the result can be:
    #a numeric value (the distance from a resort the nearest coastline is 50 meters)
    #a logical value (the house is within )







