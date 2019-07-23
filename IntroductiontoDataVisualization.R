data.frame(RBaseData)
library(ggplot2)
ggplot(RBaseData, aes (x = CPBA, y = LB)) +
  geom_point()
#apply a linear model:
ggplot(RBaseData, aes (x = CPBA, y = LB)) +
  geom_point(alpha = 0.6) +
  stat_smooth(method = "lm", col = "red", se = FALSE)

#the default alpha is usually 1 (scale 0-1). THe alpha
#can be set to a constant value or mapped via scale.
#the scale_alpha_continuous scale can be used to map numbers to a range of legal alpha values
##alpha is the value to use for confidence intervals

#a log transformation of both variables allows for a better fit
ggplot(RBaseData, aes (x = CPBA, y = LB)) +
  geom_point(alpha = 0.6) +
  coord_fixed() +
  scale_x_log10() +
  scale_y_log10() +
  stat_smooth(method = "lm",
              col = "#C42126", #specifying the color
              se = FALSE, size = 1)
#When you are trying to plot and R treats a variable as continuous, but
#it needs to be a factor, you can wrap factor around it to get around this
#using i.e. aes = (x = (factor(CPB), y = LB))

#Grammar of Graphics:
#two key principles:
#1. graphics = distinct layers of grammatical elements
#2. meaningful plots through aesthetic mapping

#Essential Grammatical elements:
#1. Data: The dataset being plotted
#2. Aesthetics: The scale onto which we MAP our data.
#3. Geometries: The visual elements used for our data (i.e. the actual shape it will take)
##The following are optional elements of graphical displays:
#4. Facets: Plotting small multiples.
#5. Statistics: Representations of our data to aid understanding.
#6. Coordinates: The space on which the data will be plotted.
#7. All non-data ink.

#Examples of Essential Grammatical Elements:
#1. Data: Variables of interest
#2. Aesthetics: x-axis, y-axis, color, fill, size, labels, alpha, shape, line width/type
#3. Geometries: point, line, histogram, bar, boxplot
#4. Facets: columns, rows
#5. Statistics: binning, smoothing, descriptive, inferential
#6. Coordinates: cartesian, fixed, polar, limits
#7. Themes: non-data ink

#Grammar of graphics are the building blocks to create solid, creative, & meaningful visualizations
 

#Objects and Layers:

#add color to your plot:
#plot(iris$Sepal.length, iris$Sepal.Width)
#point(iris$Petal.Length, iris$Petal.Width, col = "red")
#problems of doing this without ggplot:
#1. plot doesn't get redrawn
#2. plot is drawn as an image
#3. no unified framework for plotting

#Plotting functionality in ggplot2:
#ggplot(dataframe, aes(x = y, = ))
#to specify we want points, we add : +geom_point()  (*defines the geometry, or points)

#if you save your ggplot as a defined object, you can recycle it for later alterations in configurations

p <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width))
p + geom_point()
p + geom_jitter()

#assigning multiple layers to an object

#An example of adding individual colored linear models for each category in a scatter plot:
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point() + # Copy from Plot 2
  geom_smooth(method = lm, se = FALSE) + # Copy from Plot 2
  geom_smooth(method = lm, se = FALSE, linetype = 2)

#proper data format:
#in ggplot you can add multiple geom_point() or subsets of data points:
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point() +
  geom_point(aes(x - Petal.Length, y = Petal.Width), col = "red")
#the last line specifies a new susbet and color codes it to red to discern it from the previous
#the above is INCORRECT syntax because there is no legend!!! It is possible. below is correct methodology

#with ggplot2:
#plotting space is adjusted
#ggplot2 produces an object that can be manipulated

#in the data set:
#we can rearrange the data; what we really want to compare is width not specifically sepal or petal
#we wanted to use color to distinguish parts

#the previous versions were wide formats
#we can rearrange the data so "parts" is a distinguishing column and then a single measure column

##what is preferable is to use tidy data
#gives us access to all variables in our data set
species -> part -> measure -> value

#the advantage is we can use one command instead of 3, and take advantage of small multiples

#An example of using tidy data to plot variables:

# Consider the structure of iris, iris.wide and iris.tidy (in that order)
str(iris)     #str allows us to briefly view the data.frame of the defined set
str(iris.wide)
str(iris.tidy)

# Think about which dataset you would use to get the plot shown right
# Fill in the ___ to produce the plot given to the right
ggplot(iris.tidy, aes(x = Species, y = Value, col = Part)) +
  geom_jitter() +
  facet_grid(. ~ Measure)
#the plot that is generated from above is from the iris.tidy data:
> str(iris.tidy)
'data.frame':	600 obs. of  4 variables:
  $ Species: Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
$ Part   : chr  "Sepal" "Sepal" "Sepal" "Sepal" ...
$ Measure: chr  "Length" "Length" "Length" "Length" ...
$ Value  : num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...

#the plot produced has "Value" on the Y axis, Species on the x-axis, color coded for Part (sepal or petal),
#and produces two different "grids" that separate length in one grid and width in another

#How to convert a data set into a tidy data set:
# Load the tidyr package
library(tidyr)

# Fill in the ___ to produce to the correct iris.tidy dataset
iris.tidy <- iris %>%
  gather(key, Value, -Species) %>%
  separate(key, c("Part", "Measure"), "\\.")

#The above is based on the below table (iris):
> head(iris)
Sepal.Length Sepal.Width Petal.Length Petal.Width Species
1          5.1         3.5          1.4         0.2  setosa
2          4.9         3.0          1.4         0.2  setosa
3          4.7         3.2          1.3         0.2  setosa
4          4.6         3.1          1.5         0.2  setosa
5          5.0         3.6          1.4         0.2  setosa
6          5.4         3.9          1.7         0.4  setosa

#Using a wide data set:
# The 3 data frames (iris, iris.wide and iris.tidy) are available in your environment
# Execute head() on iris, iris.wide and iris.tidy (in that order)
head(iris)
head(iris.wide)
head(iris.tidy)
# Think about which dataset you would use to get the plot shown right
# Fill in the ___ to produce the plot given to the right
ggplot(iris.wide, aes(x = Length, y = Width, col= Part)) + 
  geom_jitter() +
  facet_grid(. ~ Species)

#Producing a wide data set:
# Load the tidyr package
library(tidyr)

# Add column with unique ids (don't need to change)
iris$Flower <- 1:nrow(iris)

# Fill in the ___ to produce to the correct iris.wide dataset
iris.wide <- iris %>%
  gather(key, value, -Species, -Flower) %>%
  separate(key, c("Part", "Measure"), "\\.") %>%
  spread(Measure, value)

#Visible Aesthetics with ggplot:
#Aesthetics are not just visual, but also a conduit onto which variables can be mapped
#i.e., type = color, property = red; or type = shape, property = 4
#type - color, variable = species (mapping species onto color)

#Mapping:
#attributes are raw color, for example
#this is why data organization is so important

#i.e.:
#ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width,
col = Species)) +
  geom_point()
#in the above, data frame column mapped onto visible aesthetic

#Aesthetics are defined in the aes() function
#Attributes are defined in the geom_() functions
#you can also call aesthetics in the geom_ layer, like the following:
ggplot(iris) +
  geom_point(aes(x = Sepal.Length, y = Sepal.Width,
                 col = Species))
#BUT we typically only do that when we combine data sets

#Examples of typical aesthetics:
#x: x axis position
#y: y axis position
#colour: colour of dots, outlines of other shapes
#fill: fill colour
#size: diameter of points, thickness of lines
#alpha: transparency
#linetype: line dash pattern
#labels: text on a plot or axes
#shape: shape of points

#practicing aesthetics:
# Map cyl to labels
ggplot(mtcars, aes(x = wt, y = mpg, label = cyl)) +
  geom_text()
#the geom_text function allows text or labels to be mapped onto the plot instead of markers

#Note: In this chapter you saw aesthetics and attributes. Variables
#in a data frame are mapped to aesthetics in aes(). (e.g. aes(col = cyl)) within ggplot(). 
#Visual elements are set by attributes in specific geom layers (geom_point(col = "red")). 
#Don't confuse these two things.

#Two different variables defined by shape and size:
ggplot(mtcars, aes(x = mpg, y = qsec, col = factor(cyl), size = (hp/wt))) +
  geom_point(shape = factor("am"))

##Note: label and shape aesthetics are only applicable to categorical data


#modifying positions with ggplot2:

#the first we have encountered is position identity (default)
#adding position jitter allows you to see data that is otherwise hidden due to overlap
#added within the geom_ function

#scale functions:
#scale_x_continuous
#scale_y...
#scale_color_discrete
#scale_fill
#scale_color...
#scale_shape...
#scale_linetype...

#Different methods of arranging bar graphs:
# The base layer, cyl.am, is available for you
# Add geom (position = "stack" by default)
cyl.am + 
  geom_bar(position = "stack")

# Fill - show proportion
cyl.am + 
  geom_bar(position = "fill")  

# Dodging - principles of similarity and proximity
cyl.am +
  geom_bar(position = "dodge") 

# Clean up the axes with scale_ functions
val = c("#E41A1C", "#377EB8")
lab = c("Manual", "Automatic")
cyl.am +
  geom_bar(position = "dodge") +
  scale_x_discrete("Cylinders") + 
  scale_y_continuous("Number") +
  scale_fill_manual("Transmission", 
                    values = val,
                    labels = lab) 


#Aesthetics: Best Practices
#How do we know which aesthetic to choose?

#our first function is NOT to be beautiful plots, it should firstly be effectively/represented data

#overly-complex figures are also dangerous

#Description of Aesthetics:
#x: x axis position
#y: y-axis position
#colour: colour of dots, outlines of other shapes
#fill: fill colour
#size: diameter of points, thickness of lines
#alpha: transparency
#linetype: line dash pattern
#labels: text on a plot or axes
#shape: shape

#Aesthetics: continuous variables--
#color is not the best aesthetic for continuous scales as it can be misinterpreted

#Guide: continuous variables
#if your y axes are unaligned (i.e. in the facet wrap) it can be confusing

#more distinguishable shapes and colors are always more desirable beacuse
#it makes your data easier to read

#using position = "jitter" and the call of alpha = 0.5 inside of geom_point()
#helps to clarify large data sets or data that is overlapping


#scatter plots:
#there are 37 geometries available, so it is up to us to decide which is best
#common plot types that I must master:
#1. scatter plots (point, jitter, abline)
#2. bar plots (histogram, bar, errorbar)
#3. line plots (line)

#scatter plots:
#each geom has specific aesthetic mappings;
#some of these are essential, some are optional
#i.e. geom_point() has essentials of x and y
#optional for geom: alpha, colour, fill, shape, and size
#the ability to do this inside of aes() inside geom_() is very important!
#that is because it allows us to format each layer independently

#layering geom_:
#let's say you want to plot the means of data on top of the raw data with geom_point
#in the first portion of your function, use aes() to specify x and y + geom_point()
#in your second layer, which is just the means, you only need to specify the data set. The x and y are inherited so no need to use aes().
#in this second layer, also specify the shape and/or size to differentiate.
#in other words, it inherets the aesthetics from the parent geom_ function

#Crosshairs:
#you can use these to display where the means are for x and y variables:
#uses the command geom_vline(for aes(xintercept = ))
#or the comman geom_hline(for aes(yintercept = ))
#depending on if you want to display the x or the y mean
#this is in addition to and not a part of geom_point()

#ggplot2 can also calculate statistics
#displaying only the mean can be misleading

#geom_jitter:

#helps with visual communication; this in combination with shape or alpha

#notice that jitter can be 1. an argument in geom_point(position = "jitter"),
#2 a geom function in itself, geom_jitter(), and 3. a position function position_jitter(0.1).

#jitter and alpha blending serves as a great solution to overplotting


#Barplots and their most useful applications:
#starting with histograms:
ggplot(iris, aes(x = Sepal.Width)) +
  geom_histogram()
#this will display count on the y-axis
#there are many ways to do binning
#x-axis labels between the bars
#binning argument will defaul to take the range/30, but we can change that
#we use 'binwidth = x' to adjust this

#there are many ways to choose the binning statistic
#there is no space between the bars in a histogram; so that is why the x axis labels fall between bars
##counting how many are in each bin
#we will manually assign a y column to tell ggplot that that is part of an internal data frame

#Bar plot:
#geom_bar
#you can call the following: geom_bar(stat = "bin") explicitly


##Creating your own color palette for categorical variables when the default does not have enough colors for the scale:
# Final plot of last exercise
ggplot(Vocab, aes(x = education, fill = vocabulary)) +
  geom_bar(position = "fill") +
  scale_fill_brewer()

# Definition of a set of blue colors
blues <- brewer.pal(9, "Blues")

# Make a color range using colorRampPalette() and the set of blues
blue_range <- colorRampPalette(blues)

# Use blue_range to adjust the color of the bars, use scale_fill_manual()
ggplot(Vocab, aes(x = education, fill = vocabulary)) +
  geom_bar(position = "fill") +
  scale_fill_manual(values = blue_range(11))

#Line Plots (in the context of time series):

#commonly use geom_line in ggplot
#you can color segments of a line (this would be really useful for analyzing season!)
ggplot(beaver, aes(x = time, y = temp, col = factor(active))) +
  geom_line()

#let's say we want to compare many groups, which is a little more complicated:
#line type will help us to distinguish in this case
#line width would be too messy and difficult to differntiate
#color is the best, since it is immediately apparent which group is which
#can use geom_fill which defaults to position = stack
#geom_fill is filled area plot; you can also convert this to position = fill,
#which defaults everything to proportions of a whole

#the difficulty with a fill plot is that the values that fall in the middle proportion are hard to discern

#geom_ribbon:
#we set the alpha in the example so we could see the overlap


#qplot: A quick and dirty tool
#looking at the same code in two different forms:
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point()
#VS.
qplot(Sepal.Length, Sepal.Width, data = iris)
#qplot is pretty similar to base package format

#you can also map variables to shape with qplot:
qplot(Sepal.Length, Sepal.Width, data = iris, shape = Species)
#we can also do size and color (the most straightforward)

#we can also specify position = "jitter"

#we run into issues with qplot when trying to call alpha; to prevent that we need to use the I function
#it forces R to recognize it as an attribute, and not a variable for the aesthetic
qplot(Sepal.Length, Sepal.Width, data = iris, col = Species,
      position = "jitter", alpha = I(0.5))
#within the jitter function, you can adjust the level of jitter manually:
posn.j <- position_jitter(0.1)
qplot(Species, Value, data = iris.tidy, col = Part,
      position = posn.j)
#VS below ggplot:
ggplot(iris.tidy, aes(x = Species, y = Value, col = Part)) +
  geom_point(position = posn.j)

#Still, ggplot will remain the most flexible plotting tool we have

#qplot is fine for plots of only a couple of variables

#you can use geom_point() or geom_dotplot() to generate a scatter,
#but the second is preferred for coding clarity

#Wrap up:
#two main points on making good plots:
#1 grammatical elements,
#2 aesthetics

#combine grammatical elements just like you arrange sentences
#aesthetic mapping: how to map variables onto aesthetics

#a tidy set for CPB would be very useful!!

#jittering removes overplotting, but can also use alpha


##GGPLOT COURSE 2:

#examining stats, coordinates, facets, and themes

#statistics layer:
  #there are two categories of function:
  #1. called from within a geom,
  #2. called independently
##we have used stat_bin, which counts numbers of observations in a group

#stat_smooth
#accessed with geom_smooth
#the standard error is shown as a ribbon behind our smoothed line with a
#95% confidence interval. We can disable this with se = FALSE inside
#the geom_smooth layer

#when using the default geom_smooth, which is loess, the basic statistical method at play
#is that the mean is calculated along a sliding window on the line so that a computation can be made.
#therefore, smaller windows, or less data, are more noisy

#another method we can use besides loesss is geom_smooth(method = "lm")
#here we can also eliminate the shading with se = FALSE
#with a LM model, it is not at all predictive because by design it is only captured within
#the range of our data set
#if we want to make lm predictive, we set the argument as follows:
geom_smooth(method = "lm", fullrange = TRUE)

#you also notice that the error shading increases as more forecasting is used

##FACTORS: similar to categorical; they take on a finite number of values

#you need to specify any call to col = "" as a factor variable if you want to use it as a grouping
#variable for linear models!!. I.e. col = factor(year)

#tip on mapping with colors:
#when mapping onto color you can sometimes treat a continuous scale, like year,
#as an ordinal variable, but only if it is a regular series. The better
#alternative is to leave it as a continuous variable and use the group aesthetic
#as a factor to make sure your plot is drawn correctly

#quantile regression:
#a great tool for a more detailed overview of a large data set:
  #example:
  # Use stat_quantile instead of stat_smooth
  ggplot(Vocab, aes(x = education, y = vocabulary, col = year, group = factor(year))) +
  stat_quantile(alpha = 0.6, size = 2) +
  scale_color_gradientn(colors = brewer.pal(9,"YlOrRd"))

# Set quantile to 0.5
ggplot(Vocab, aes(x = education, y = vocabulary, col = year, group = factor(year))) +
  stat_quantile(alpha = 0.6, size = 2, quantiles = 0.5) +
  scale_color_gradientn(colors = brewer.pal(9,"YlOrRd"))


#plotting a summary statistic on top of a jitter plot
# Plot 1: Jittering only
p <- ggplot(Vocab, aes(x = education, y = vocabulary)) +
  geom_jitter(alpha = 0.2)

# Plot 2: Add stat_sum
p +
  stat_sum() # sum statistic

# Plot 3: Set size range
p +
  stat_sum() + # sum statistic
  scale_size(range = c(1, 10)) # set size scale

#statistics outside geoms:
#when you are dealing with the distribution of continuous data...
#call some statistics: focus on mean, sd, and 95% confidence interval
#to use the stats (mean and sd) in ggplot, use mean_sdl
#will automatically feed the results through a geom
#by default, the stats summary function uses geom_pointrange() by default
#if you want a more traditional error bar structure:
#(example) ggplot(iris, aes(X = Species, y = Sepal.Length)) +
stat_summary(fun.y = mean, geom = "point") +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1),
               geom = "errorbar", width = 0.1)
##as in the above, we can specify the error bar structure and the size or width

#other useful stat functions:
#stat_summary() summarizes values at distinct x values
#stat_function() computes y values from a function of x values
#stat_qq() performs calculations for a quantile-quantile plot

#a way of displaying normal distribution and density of that distribution:
library(MASS)
mam.new <- data.frame(body = log10(mammals$body))
ggplot(mam.new, aes(x = body)) +
  geom_histogram(aes( y = ..density...)) +
  geom_rug() +
  stat_function(fun = dnorm, colour = "red",
                arg = list(mean = mean(mam.new$body),
                           sd = sd(mam.new$body)))
##can also use a qqplot: draw a line intersecting the quartiles
#however, there is no function for qqplot in ggplot so we have to make manual calculations:
mam.new$slope <- diff(quantile(mam.new$body, c(0.25, 0.75))) /
  diff(qnorm(c(0.25, 0.75)))

mam.new$int <- quantile(man.new$body, 0.25) -
  mam.new$slope * qnorm(0.25)

ggplot(mam.new, aes(sample = body)) +
  stat_qq() +
  geom_abline(aes(slope = slope, intercept = int), col = "red")

#the closer our data matches a qqline, the more it conforms to a normal distribution
#Confirmation of distribution hypotheses...

#coordinates
#controls plot dimensions
#coord_ is the most common function
#coord_cartesian() controls the x, y plane of your plot (the most common of coord_)



#why should I use log10 for my charts and graphs?
#the two main reasons: to respond to skewness towards large values, i.e. cases in which
#one or a few pints are much larger than the bulk of the data
#the second is to show the percent change or multiplicative factors

#using logarithmic scales in line charts:
#linear scales will show the absolute number of x over time while the log scale
#shows the rate of change of x over time
#you can use other log scales besides log10 to adjust your data as needed; log2 is another useful one

#Zooming in on a particular part of a plot:
scale_x_continuous(limits = ...)
xlim()
coord_cartesian(xlim = ...)

#when you zoom in, you are warned that stat_smooth has eliminated rows
#parts of the original data set are filtered

#you can also call xlim on its own
#zooming in allows us to look clearly, but changing x and y limits can lead to unexpected consequences

#can also change the aspect ratio with coord_
#height-to-width ratio
#inadvertently or purposely misleading
#typically you should use a 1:1 when the units on x and y are the same

#if you extend a plot, or stretch it out, you may see different trends



#HOW TO REPRESENT YEARLY CYCLES, OR OTHER DATA, WITH A PIE CHART:
# Create a stacked bar plot: wide.bar
wide.bar <- ggplot(mtcars, aes(x = 1, fill = cyl)) +
  geom_bar()

# Convert wide.bar to pie chart
wide.bar +
  coord_polar(theta = "y")

# Create stacked bar plot: thin.bar
thin.bar <- ggplot(mtcars, aes(x = 1, fill = cyl)) +
  geom_bar(width = 0.1) +
  scale_x_continuous(limits = c(0.5,1.5))

# Convert thin.bar to "ring" type pie chart
thin.bar + 
  coord_polar(theta = "y")

#Facets:
#straight-forward and useful
#we can split up a large complex plot to represent it in smaller parts
#facet_grid is a common one
#the primary use of facets is to add another variable to our plots 
#facet_grid takes the format: facet_grid(rows~columns)
#if you only want to specify a column, use facet_grid(. ~ Species) for example

#this is all to aid in visual perception

#using facet_grid splits up data of a categorical factor variable
#if you have a different variable you can or would like to specify for both
#row and column, you can have a different variable represented by both
#in the facet_grid setting



#Using facet_grid, but wanting to eliminate empty values:
# Basic scatter plot
p <- ggplot(mamsleep, aes(x = time, y = name, col = sleep)) +
  geom_point()

# Execute to display plot
p

# Facet rows accoding to vore
p +
  facet_grid(vore ~ .)

# Specify scale and space arguments to free up rows
p +
  facet_grid(vore ~ ., scale = "free_y", space = "free_y")


#Themes layer:
#the non-data ink
#visual elements not part of data
#three types: text, line, and rectangle
#element_text(), element_line(), or element_rectangle() are our methods of calling
#them for formatting
#these are all arguments of the theme argument, which are added as a layer of a ggplot
#headers for individual graphs within a facet are called strip.text.y or x, for example

#lines include tick marks, the axes, and grid lines

#you can access the rect for specific background formatting
#theme( rect = element_rect())

#there are elements or levels of inheritance in the themes layer
#element_blank is used to remove features from the theme (theme(element_blank())
#specifying colors for specific features of a graph (color):
# Extend z with theme() function and 3 args
z + 
  theme(panel.grid = element_blank(),
        axis.line = element_line(color = "red"),
        axis.ticks = element_line(color = "red"))

#how to rearrange the legend:
# Move legend by position
z +
  theme(legend.position = c(0.85, 0.85))

# Change direction
z +
  theme(legend.direction= "horizontal")

# Change location by name
z +
  theme(legend.position = "bottom")

# Remove legend entirely
z +
  theme(legend.position = "none")


#How to adjust margins:
# Increase spacing between facets
library(grid)
z +
  theme(panel.spacing.x = unit(2, "cm"))


# Adjust the plot margin
library(grid)
z +
  theme(panel.spacing.x = unit(2, "cm"),
        plot.margin = unit(c(1,2,1,1), "cm"))
#without the correct margin space, titles can fall off. The spacing usually requiress some experimentation

#Recycling themes:
#want to keep your plots consistent within the same presentation, for example

#save your layer as an object, which means you can reuse it on any other plot
#i.e. specify your themes, then save as:
iris_Theme <- theme(element_blank()...
#you can then add a theme directly to a data set without having to rewrite the theme over and over
#if you need to modify a saved theme, save it under a new name


#there is also a ggthemes package

#theme_tufte() removes all non-data ink and sets it to a serif typeface

#can also use the theme update function
#it updates the default theme to hold our additions, and saves the old theme as "original"

#having a default theme:
theme_set()
#this will automatically set a default, for example if you have a custom one you want to apply

#other available themes that you can call:
theme_gray()
theme_bw()
theme_classic()


#How to create a custom theme:
# Original plot
z2

# Load ggthemes
library(ggthemes)

# Apply theme_tufte(), plot additional modifications
custom_theme <-theme_tufte() +
  theme(legend.position = c(0.9, 0.9),
        legend.title = element_text(face = "italic",
                                    size = 12))

# Draw the customized plot
z2 + custom_theme


#Discussing Best Practices: Bar Plots
#what is the best way to graphically represent our data?
#two common types of bar plots: absolute values and distribution

#one of the downfalls is: what is the sample size? Also, implication that it is normally distributed....
#but also showing there is data where the bars do not reach (with the sd bars)

#an alternative with individual data points:
d + geom_point(alpha = 0.6, position = position_jitter(width = 0.2))
#error bars with points are a much cleaner display of the data


#example where we were creating a bar plot; using geom_col as a shortcut
In this geom_bar(), set the attribute stat to "identity" and the attribute fill to "skyblue".
Plot 2: geom_col() is a shortcut for geom_bar(stat = "identity"), for when your data already has counts.
m + geom_bar(stat = "identity", fill = "skyblue") VERSUS
m + geom_col(fill = "skyblue")

#Pie Charts
#simply a stacked bar chart plotted into a circle
#it's a parts of a whole question
#circle is a perfect symbol of a whole

#the major disadvantage is that people use visual cues to decipher the data
#some use angles, some use area, some use length. None of them are ideal, but we can dictate what they choose
#better to only have one way of reading a plot (keep it straightforward)

#perhaps the only time pie charts are useful are with large data sets in no more than three groups

#an alternative is a stacked bar chart, but horizontal bars not vertical
#also known as parallel plots

#a package for creating parallel coordinates plots: GGally
library(GGally)

#when you want to eliminate specific columns from an analysis (in this case for parallel coordinates comparison):
am is variable 9 in the mtcars data frame. Assign this number to group_by_am. 
The object my_names_am will contain a numeric vector from 1 - 11
excluding the column with am. These will be our parallel axes.
# All columns except am
group_by_am <- 9
my_names_am <- (1:11)[-group_by_am]


#Best Practices: Heat Maps
#it's difficult to map a continuous varirable onto a heat map because our perception of color changes depending
#on the neighboring colors
#if the data is organized in a way that it displays trends, it can be useful. 
#once you get over the "wow" factor, you realize there is probably a better way to represent data

#The best alternative is to map variables on a consistent and identical x-axis (stack them all in the same column)
#useful for exploratory data analysis but may not be something you want to publish

#Example of creating a heat map:
# Create color palette
myColors <- brewer.pal(9, "Reds")

# Build the heat map from scratch
ggplot(barley, aes(x = year, y = variety, fill = yield)) +
  geom_tile() + # Geom layer
  facet_wrap( ~ site, ncol = 1) + # Facet layer
  scale_fill_gradientn(colors = myColors) # Adjust colors

#easiest way to plot ordinal variables will be to add a column with associated labels


#Example for exploring data trends with initial histograms and then coloring a histogram based on a factor:
# Explore the dataset with summary and str
summary(adult)
str(adult)


# Age histogram
ggplot(adult, aes(x = SRAGE_P)) +
  geom_histogram()


# BMI value histogram
ggplot(adult, aes(x = BMI_P)) +
  geom_histogram()


# Age colored by BMI, binwidth = 1
ggplot(adult, aes(x = SRAGE_P, fill = factor(RBMI))) +
  geom_histogram(binwidth = 1)

#specifying binwidth: the smaller your bin value, the more detail. For example, with the default
#bin of 30, that is your unit at which another bin, or bar, will be displayed. Having more bins displays more detail.

#Specifying a bin range and width (example):
hist(~tl,data=ChinookArg,xlab="Total Length (cm)",breaks=seq(15,125,5))
#the above specifies that we want to start at 15 on the x-axis, end at 125 on the x-axis, and use intervals of 5
#to specify the width of our bins
#BUT: THERE IS A SHORTCUT TO THE ABOVE!
#it can be tedious to find the minimum and maximum values of your data; by using the following, all you need is to specify the width:
hist(~tl,data=ChinnokArg,xlab="Total Length (cm)",w=5)
#the above also works when multiple histograms are constructed, such as when you have a facet wrap

ggplot(adult, aes(x =SRAGE_P, fill = BMI_P)) + geom_histogram()

#Mosaic Plots and Chi-Squared Test Example:
#drew a histogram with plot area = 1, with each bar represented as a proportion.
#the bar widths in this example also vary depending on their proportion to the whole of total samples
#the x-axis also changed from age to total number of samples
#what we have created is a giant contingency table, derived from two categorical variables, BMI category and age
#we want to know if the proportion of a variable within another (Categorical) variable, stray from the null model
#of equal proportions
#this is what a Chi-squared test does, and mosaic plots are a way of visualizing this

#in chi-squared tests, we compare the expected distribution with residuals.
#the higher the residual, the more overrepresented a segment is
#you can then plot according to residuals to display where overrepresentation and underrepresentation is taking place


##DATA VISUALIZATION: GGPLOT2 COURSE 3

#Introduction:
#An example of creating a scatter plot with an added statistical layer:
# Create movies_small
library(ggplot2movies)
set.seed(123)
movies_small <- movies[sample(nrow(movies), 1000), ]
movies_small$rating <- factor(round(movies_small$rating))

# Explore movies_small with str()
str(movies_small)

# Build a scatter plot with mean and 95% CI
ggplot(movies_small, aes(x = rating, y = votes)) +
  geom_point() +
  stat_summary(fun.data = "mean_cl_normal",
               geom = "crossbar",
               width = 0.2,
               col = "red") +
  scale_y_log10()

#this creates a geom_point() with specified categories, and an overlayment of statistical summary with red boxes (displaying mean
#in crossbar)

#An example of log transformation with geom_point() and specification of x and y scales
# Reproduce the plot
ggplot(diamonds, aes(x = carat, y = price, col = color)) +
  geom_point(alpha = 0.5, size = 0.5, shape = 16) +
  scale_x_log10(expression(log[10](Carat)), limits = c(0.1, 10)) +
  scale_y_log10(expression(log[10](Price)), limits = c(100, 100000)) +
  scale_color_brewer(palette = "YlOrRd") +
  coord_equal() +
  theme_classic()

#The following runs the same plot as above, but replacing stat_smooth() for geom_point()
# Add smooth layer and facet the plot
ggplot(diamonds, aes(x = carat, y = price, col = color)) +
  stat_smooth(method = "lm") +
  scale_x_log10(expression(log[10](Carat)), limits = c(0.1,10)) +
  scale_y_log10(expression(log[10](Price)), limits = c(100,100000)) +
  scale_color_brewer(palette = "YlOrRd") +
  coord_equal() +
  theme_classic()

#BoxPlots:
#closer examination of box plots and density plots

#Investigation of Tukey plots:
#this provides more robust data than just the mean and standard deviation because the mean and sd are not robust;
#meaning, if we have extreme values in a category, those statistical values will shift as a result
#a tukey plot takes advantage of the "five-number summary", which more accurately captures the statistics
#of data that is not necessarily normally distributed:
#minimum, Q1, Q2, Q3, and maximum
  #median is represented by Q2, and the distance from Q1 to Q3 is the interquartile range (IQR)

#An extreme value:
  #defined as falling outside the range 1.5 times the IQR, either below Q1 or above Q3
#1.5 times the IQR (in both directions) is known as "the fence"; just know that this is one definition of an
#extreme value. The fence can be adjusted, and the default may vary depending on the software

#when using a tukey, no matter how far out of the fence a data point is, it will only be represented as a dot,
#and it will not stretch the whisker out, thus skewing the data


#Converting continuous variables into ordinal variables:
#If you only have continuous variables, you can convert them into ordinal variables using any of the following functions:
#cut_interval(x, n) makes n groups from vector x with equal range.
#cut_number(x, n) makes n groups from vector x with (approximately) equal numbers of observations.
#cut_width(x, width) makes groups of width width from vector x.
#This is useful when you want to summarize a complex scatter plot like the one shown in the viewer.
#By applying these functions to the carat variable and mapping that onto the group aesthetic, you can convert 
#the scatter plot in the viewer into a series of box plots on the fly.

#An example of converting continuous variables into ordinal variables:
# Plot object p
p <- ggplot(diamonds, aes(x = carat, y = price))

# Use cut_interval
p + geom_boxplot(aes(group = cut_interval(carat, n= 10)))

# Use cut_number
p + geom_boxplot(aes(group = cut_number(carat, n = 10)))

# Use cut_width
p + geom_boxplot(aes(group = cut_width(carat, width = 0.25)))


#the difference between methods of computing quartiles is not as pronounced when the sample size is large


#Density Plots:
#an excellent way of examining the distribution of univariate data
#commonly seen in statistics as "Probability Density Function"
  #different ways of displaying this are thru standard normal curve, t-test, chi-squared, and f-distributions

Introducing the Kernel Density Estimate (KDE)
#"A sum of 'bumps' placed at the observations. The kernel fxn determines the shape of the bumps while the
#window width, h, determines their width"

#in an example dataset:
#the KDE computes a normal distribution for each observation, or the bumps referred to in the definition
#to in turn obtain the TRUE density curve, we simply add up all of the y values for each bump along the x-axis
#many overlapping lines will result in a higher value, ergo a higher density
#we then have an Empirical Probability Density Function; it does the samw thing as a Probability Density Fxn

#Remember that in a normal distribution, the area under the curve equals 1.
#intervals represent the probability of finding values in that specific range
#Note that this is how we determine the mode of our data, or how many modes we have

#Mode: the value at which probability density function has maximum value

#Bandwidth (AKA, h)
#generally you can use the default, but if you want to see more subtle differences in your density plot, you can decrease it

#example of reducing bandwidth:
#when we reduce the bandwidth, our bumps are not as wide, so as they become more narrow, they affect the smoothness of our density curvev
#what results is a density curve with more features, since there is not as much overlapping of bumps
#what results is higher peaks
#it is valuable to know what the default bandwidth is, and if it should be adjusted. 

#difference between geom_density and KDE:
#geom_density cuts off our minimum and maximum values of our distribution



