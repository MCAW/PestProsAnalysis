example <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8), nrow = 4, ncol = 2)
#The above is sample code of how to create a matrix; it creates two columns of data where 1-4 are in column 1 and 5-8 are
#in column 2

#Installing R Packages:
intsall.packages("ggplot2")
#Installing multiple R packages at once:
install.packages(c("ggplot2", "devtools", "lme4"))

#Bioconductor (widely used source for Biostats packages) (another source for R packages) uses their own method for installation:
source("https://bioconductor.org/biocLite.R")
#The above makes the following function available:
bioclite()
#Following the above, you call the package you want to install in quotes, i.e.:
biocLite("GenomicFeatures")

#Another option is to install from Github. More specific, and you must note the package name AND the author of package.
#The general workflow is:
install.packages("devtools") #You only run this if you don't already have devtools installed
library(devtools) #rather than installation, this is the function that is necessary to load a package
install_github("author/package") #Here you need to replace "author" and "package" with their GitHub username and pkg name.

#About loading packages:
#The main function of use:
library()
#As an example: think of it like computer program installation. Just because you installed it, it doesn't mean it is running
#To open a package you have already installed:
library(ggplot2)
#DO NOT PUT THE PACKAGE NAME IN QUOTES WHEN YOU ARE LOADING (only at installation).

#Dependencies:
#some packages require other packages to be loaded first before they can run. 
#The package's manual/help pages will help you find that order, if they are picky.

#Load packages in RStudio interface:
#click on "Packages" in lower right quadrant. It litsts out all of the packages/brief description/version #/all of the 
#packages you have installed
#To load a package, just click on the checkbox beside the package name.

#Updating, removing and unloading packages:
#if you want to check which packages are installed:
installed.packages() #do not enter anything between, OR
library() #also with nothing in between

#updating packages:
#you can check with a call to the function:
old.packages()
#following, you can use the code:
update.packages()
#if you only want to update a speciic package, just use once again with the name typed in:
install.packages("packagename")

#Installed/Updated thru Rstudio interface:
#In the bottom right quadrant, you can click on the packages tab/update, which will list all of the packages that are not
#up to date
#be CAREFUL when you update; if you rerun old code, you may lose functionality that was available in the old version.

#Unloading packages:
#sometimes packages do not "play nicely" with one another.
#To unload a given package use the following:
detach() #with the package name included.
#another example:
detach("package:ggplot2", unload=TRUE)
#Unloading in RStudio:
#you can simply unload a package by unchecking the box beside the package name

#Uninstalling in RStudio:
#if you no longer want a package installed, you can simply uninstall using:
remove.packages()
remove.packages("ggplot2")
#To do so in Rstudio, in the packages tab, simply click the "X" in the circle at the end of the row and it will be removed

#How to check your version of R:
#a package you are interested in may require a certain version of R to run.
#when you startup, the first thing that shows up in your console is the version. If you need to check, though:
version
sessionInfo()
#the first above tells you which version of R you are running; the second tells you what version you are running & all
#of the packages you have loaded
#This is a helpful bit to list in a forum if you are asking questions!!

#To see what is included in a package:
help()
help(package = "ggplot2")
#This will show you the package's functions.
#Within RStudio, you can also access the help files through >Packages>click on any package name>it opens the help files

#Using functions (within a package)
#make sure the package is installed and loaded
#if you still have questions beyond help, many packages include "vignettes" that are like extended help files
#vignettes include detailed examples of how to use the functions in plain workds that you can follow along with
browseVignettes()
browseVignettes("ggplot2")
#this function takes you to a webpage where you can explore functionality
#This is extremely helpful for aesthetic information for making plots with ggplot; it lists all of the resources to properly
#format and finish a plot

#Projects
#when you make a project, it creates a folder where all files will be kept, which is helpful for organizing.
#when you reopen a project, RStudio remembers what files were open & restore them to the work environment
#Creating an R project will create a new folder and assign that as the working directory so that all files generated
#will be assigned to the same directory

#Ways to create a project:
#1. from scratch: this will create a new directory for all of your files to go into
#2. from an existing folder: this will link an existing directory with RStudio
#3. from version control: this will "clone" an existing projecy onto your compute

#When you create a new project:
#you will see that RStudio presents a blank environment/new file to work with
#in the "files" quadrant, you can see RStudio made a new directory and generated a single file with ext. .Rproj
#In the upper-right of the window, there is a project toolbar that states the current name of Project & has a drop-down
#with a few options

#Opening a project:
#File>open project or use the project toolbar and select "open project"

#Quitting a project or switching to another:
#File>close project or use the project toolbar and select "close project"
#this will also close the R session. However, when you start up R again, all files that were open and associated with
#this project will open again.
#when you set up your environment, you can also tell it to save your environment (all of your variables and data tables
#will be pre-loaded when you reopen the project)
#When you open a new project, RStudio automatically saves the current project, closes it, and then opens the new project
#in the same window

#if you want multiple projects open at the same time:
#Do the above but select "open project in new session", either in the file menu or the toolbar

#Best Practices:
#when you are setting up a project, it can be good to create a few directories or folders.
#most file structures are set up around having a directory containing the raw data, a directory that you keep scripts/R files in,
#and a directory for the output (like graphs or tables, etc.) in

#What is version control?
#it is a system that records changes that are made to a file or a set of files over time.
#as you make edits, the version control system takes snapshots of your files and the changes, & then saves them
#Similar to "track changes" in Microsoft Words
#Version control SYSTEMS, like Git, are more sophisiticated in that they are much more powerful

#Benefits of version control:
#rather than keeping multiple files that are "different versions" of the same information, version control keeps a single,
#updated version of each file, with a record of all previous versions AND a records of exactly what changed between each
#it keeps track of who, when, and why specific changes were made
#Version control also allows multiple people to work on the same file 

#Git
#Git is a free and open source version control system. It keeps a local copy of your work and revisions, which you can
#then edit offline, and then once you return to the internet service, you can sync or copy the work. Also, multiple people
#can work on a project simultaneously because everyone is working on their own local copy, yet not disturb the common repository

#What is GitHub?
#An online interface for Git. Git can be used locally on your computer to record changes. 

#Git Vocabulary:

#Repository (AKA Repo, envision a file folder): equivalent to the project's folder/directory; all of your cersion controlled files and changes are located
#in a repository. Often known as repo.

#Commit (envision a floppy disk save icon): to commit is to save your edits and changes made. A commit is like a snapshot of your files. Git compares
#them to previous versions of all of your files in the repo to the current version and identifies those that have changed
#since then
#Usually when you commit a file, you accompany that file change with a little note about what you changed and why.
#if you find a file mistake, you revert your files to a previous COMMIT. If you want to see how your file has change
#over time, you compare the commits and look at the messages to see why and who.

#Push (envision uploading to the cloud): updating the repository with your edits. Pushing sends committed changes to the respository, so everyone (for ex.)
#has access

#Pull (envision downloading from the cloud): updating your local version of the repository to the current version, since others may have edited it in the meantime

#Staging: the act of preparing a file for a commit. For example, if since your last commit you have edited three files for different reasons, you don't want to commit all of the changes in one go; you can change just one
#of the files and prepare it for committing. Once you've committed that file, you can stage the second file and commit it. Staging allows you to separate out file changes into separate commits.

#Branch: when the same file has two simultaneous copies. When you are working locally and editing a file, you have created a branch where your edits are not shared with the main repository (yet).
#until you push your changes and merge them back into the main repository, you are working on a branch. Following a branch point, the version history splits into two and tracks the independent changes
#made to both the original file in the repository and that others may be editing, and tracking your changes on your branch, and then merges the files together.

#Merge: independent edits of the same file are incorporated into a single, unified file. If multiple users made an edit to the same sentence that precludes one of these edits from being possible, Git recognizes the
#disparity (conflict) and asks users assistance in picking which edit to keep.

#conflict: when multiple users make changes to the same file and Git is unable to merge edits. You are presented with the option to manually try and merge or keep one over the other.

#clone: making a copy of an existing Git repository. If you are starting on a project in the middle of previous edits made by other users, you would CLONE the repository to get access to and create a local version
#of all the repository's files and all of the tracked changes.

#Fork: A personal copy of a respository that you have taken from another person. If somebody is working on a project that you want to play around with, you can fork their respository and then when you make a change,
#the edits are logged on your respository, not theirs.

#Best Practices when using Git:
#make purposeful, single issue commits
#informative commit messages
#pull and push often

#How to link an existing project with GitHub

#This is an example where you have already started or created a project in GitHub but did not start it in the repository.
#The first step is to open GitBash and navigate to the directory containing your project files:
# type cd ~/dir/name/of/path/to/file (i.e., $ cd ~/OneDrive/Desktop/Temporary_add_to_version_control/)
#After typing this, GitBash should return the name of the file and path. Then enter the following code, in order:
# $ git init
# $ git add .
# These two lines of code initializes the directory as a git repository and adds all of the files in the directory (.) to your local repository. 
#You should see that the files are added to version control
#The next step is to go to GitHub and create a new repository. The name of the repository MUST be the exact same as the R project you are linking. DO NOT initialize a readme file, .gitignore, or license.
#upon creating the repository, you should see a page where you have the option to "...push an existing repository from the command line:
#In Git Bash or Terminal, copy adnd paste the lines of codes underneath that title to link your repository with Github. After doing so, refresh the GitHub page and it should now show your newly created repository.
#When you reopen RStudio and your project, you should see that you have access to GitHub in the upper right quadrant and you can push to GitHub from within RStudio with any future changes (named .gitignore likely)


#working on an existing GitHub repository:
#This is when you have an existing project that others are working on that you are asked to contribute to/you want to link that project with RStudio.
#Follow the same steps as above.
#The only difference here is that you did not create the original repository, but cloned somebody else's.


#R Markdown

#R Markdown is a way of creating fully reproducible documents, in which both text and code can be combined. Functions include:
#bullets, bold, italics, links, or run inline r code
#Benefits or R Markdown include reproducibility, reference, and that it works very well with version control systems
#First, you must install the package: install.packages("rmarkdown")
#After you have installed the package, go to File > New File > R Markdown. In the new window, title and author the new document and select the document type you need.
#When the new document is loaded, you will see a brief explanation and some examples of the uses of RMarkdown

#Template of RMarkdown files:
#There are three main sections of the RMarkdown document; the first is the HEADER at the top, bounded by 3 dashes. This is where you specify details like the title, name of author, date, and the document type. If you
#filled in the initial window when you created a new RMarkdown, these should already be filled in.
#The second main section is TEXT SECTIONS, for example, one section that starts with "##R Markdown". This is the section that render as text when you produce a PDF of this file, & all of the formatting generally applies
#to this section
#Finally, you will see CODE CHUNKS. These are bounded by triple backticks. These pieces of R code ("chunks") can be run right from within your document, and the output of this code will be included when you create the
#document

#"Knitting" documents:
#when you are done with a document in RMarkdown, you are said to "knit" your plain text and code into your final document. To do this, click on the "knit" button along the top source panel.
#it will then prompt you to save the document as an RMD file (do so).
#In my case, I had to install TinyTex first before I could complete a file (a required package to use R Markdown). If you do not have it installed, R will display code/you will not see a finished document in the console
#when viewing your markdown document
#After tinytex package has been installed (if necessary), you can successfully knit your R Markdown and convert it into a finished document.

#Some easy Markdown commands:
#Bolding and italicising text:
#TO bold, you surround it by two asteriks on either side. Similarly, to italicise text, you surround the word with a single asterisk on either side.
#**bold**
#*italics*
#To make section headers:
#put a series of pound signs. The number of them determine what level of heading it is. One hash is the highest or first level and will make the largest text. Two symbols is the next highest, and so on.
#  #header level 1
#  ##header level 2
#  ###header level 3...

#Code chunks in R Markdown:
#To make an R code chunk, you can type the three backticks, followed by the curly brackets surrounding a lower case R, put your code on a new line and end the chunk with three more backticks.
#THere are shortcuts to perform this, as well. namely Ctrl+Alt+I (Windows). Additionally, along the top of the source quadrant, there is the "insert" button, which will also produce an empty code chunk.
#If you aren't reaady to knit your document, but you want to see the output of your code, select the line of code you want to run
#and use Ctrl+enter or hit the "Run" button along the top of your source window.

#Making bulleted lists:
#lists are easily created by preceding each prospective bullet point by a single dash, followed by a space. At the ed of each bullet's line,
#end it with TWO SPACES.


#Types of data science questions

#The main divisions of data science questions:
#1. Descriptive
#2. Exploratory
#3. Inferential
#4. Predictive
#5. Causal
#6. Mechanistic

#Descriptive Analysis
#The goal of descriptive analysis is to DESCRIBE or SUMMARIZE a set of data.
#This is usually the first step with a new set of data.
#Descriptive analysis will generate simple summaries about the samples and their measurements
#common descriptive statistics include: central tendency measurements (mean, median, mode) or measures of variability (range, sd or variance)
#This is NOT for generalizing results or trying to make conclusion. Description of data is separated from making interpretations;
#generalizations and interpretations require additional statistical steps.

#Exploratory analysis:
#the goal of exploratory analysis is to examine or EXPLORE the data and fine RELATIONSHIPS that weren't previously known. 
#this explores how different measures might be related to each other but do not confirm that relationship as causative.
#BUT, REMEMBER: just because you observe a relationship bewteen two variables during this type of analysis, it does not mean that
#this is causation
#exploratory analysis is useful for discovering new connections, but it should not be the final say in answering a question
#it is more useful in formulating hypotheses and driving the design of future studies and data collection

#Inferential analysis:
#the goal of inferential analysis is to use a relatively SMALL SAMPLE of data to INFER or say something about the POPULATION at large.
#it is commonly the goal of statistical modelling, where you have a small amount of information to extrapolate and generalize that info
  #to a larger group.
#Inferential analysis typically involves using the data you have to estimate the value in the population and then give a measure of your
#uncertainty about your estimate
#because inferential analysis usually incolves a subset of data from a larger population, your ability to accurately infer information
#will depend heavily on your sampling scheme. if the data you collect is not representative of the large population, the generalizations
#you make will not be accurate for the population
#(example of a study): not census data, because it functionally samples the entire population (There is no susbet left to infer with).
#a better example is a study in which a subset of the US populatio ws assayed for their life expectancy, given the level of air pollution
#they experienced.

#Predictive analysis:
#the goal is to use CURRENT data to make PREDICTIONS about FUTURE data. Essentially, you are using current and historical data to find
#patterns and predict the likelihood of future outcomes.
#your accuracy in predicitons is dependent on measuring the right variables. If you aren't missing the right variables to predict an outcome,
#your predictions will not be accurate.
#having more data and a simple model generally performs well at predicting the future outcomes
#BUT: just because one variable may predict another, it does not mean that one causes the other; you are just capitalizing on this observed
#relationship to predict the second variable

#Causal analysis:
#The caveat to a lot of the analyses we have looked at so far is that we only see correlations and can't get at the cause of relationships
#the goal of causal analysis is to see what happens to one varirable when we manipulate another variable: CAUSE and EFFECT
#generally, they are fairly complicated to do with observed data alone; there will always be questions as to whether it is a
#correlation driving your conclusions or that the assumptions underlying your analysis are valid.
#Most often, causal analyses are applied to the results of randomized studies that were designed to identify causation
#Causal analysis is often considered the gold standarad in data analysis, and is seen frequently in scientific studies where scientists are
#trying to identify the cause of a phenomenon, but often getting appropriate data for doing a causal analysis is a challenge.
#the data is usually analysed in aggregate and observed relationships are usually average effects
#So, the average may hold true for a certain population, but this causal relationship may not hold true for each individual of the pop.
#Randomized control studies allow for causal analyses.

#Mechanical analysis:
#They are not as common; the goal of mechanistic analysis is to understand the EXACT CHANGES in VARIABLES that lead to EXACT CHANGES
#IN OTHER VARIABLES
#These are exceedingly hard to use to infer much, except in simple situations or those that are nicely modeled by deterministic equations
#It might be clear to see how theyare are most commonly applied to physical or engineering sciences; biological sciences, for example, are
#far too noisy of data sets to use this type of analysis. Often, when these are applied, the only noise in the data is measurement error,
#which can be accounted for.


#Experimental Design:
#Experimental design is organizing an experiment so that you have the correct data (and enough of it) to clearly & effectively answer
#your questions.
#this involves clearly formulating your question in advance of any data collectino, designing the best set-up possible to gether the
#data to you question, identifying problems or sources of error in your design, and ONLY then, collecting the appropriate data.

#Principles of experimental design:
#important terms:
#independent variable (AKA factor): the variable that the experimenter manipulates; it does not depend on other variables being measured.
#often displayed on the x-axis.
#dependent variable: the variable that is expected to change as a result of changes in the independent variable. 
  #often displayed on the Y-axis, so that changes in x the independent variable, effect changes in Y.

#when you are designing an experiment, you have to decide what variables you will meazure, and which you will manipulate to effect changes
#in other measured variables.
#you must also develop a hypothesis.

#sample size: the number of experimental subjects you include in your experiment.
#confounder: an extraneous variable that may effect the relationship between the dependent and independent variables.
#control group: when you have a group if experimental subjects that are NOT manipulated. *(treatment vs control)
  #it is a group of subjects that do not receive the treatment, but still have their dependent variables measured.
#other methods of controlling for confounding effects: blind subjects, or provide a placebo treatment
#blinding: subjects don't know what group they belong to; all participants receive a "treatment"
#randomization: any confounding variables should be distributed between each group roughly equally, to help eliminate/reduce syst. errors
#replication: repeating an experiment with different experimental subjects.
#p-value: the value that tells you the probability that the results of your experiment were observed by chance
#statistically significant: when a p-value is less than 0.05


