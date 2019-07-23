library(tidyverse)

df = RBaseData                #specifying the data frame


##EARLY BLIGHT SUMMARY

EBsummary = df%>%              #creates a tibble
  group_by(Grower, Season) %>%
  summarise(meanEB = mean(EB),
            minEB = min(EB),
            maxEB = max(EB))
y <- ggplot(data = EBsummary, mapping = aes(x = Season, y = meanEB))

y + geom_smooth(method = lm)

z <- ggplot(RBaseData, aes (x = Season, y = EB, xlab ="Season", ylab ="EB")) +
  ggtitle("Early Blight Over Time")

z
 z + geom_smooth()



eb.summary                      #displaying the new data frame that was created in the last step   

eb.byYear = df %>%              #creating a new data frame where the data is grouped by season
  group_by(Grower, Season) %>%
  summarise(meanEB = mean(EB)) %>%
  spread(key = Season, value = meanEB)      
write.csv(eb.byYear, "eb_by_year.csv")  #creating a csv out of the newly created data frame

median.EB.byYear = df %>%
  group_by(Grower, Season) %>%
  summarise(medEB = median(EB)%>%
              case_when(Season = 2004)

##LB Summary:
LBsummary = df%>%              #creates a tibble
  group_by(Grower, Season) %>%
  summarise(meanLB = mean(LB),
            minEB = min(LB),
            maxEB = max(LB))

w <- ggplot(RBaseData, aes (x = Season, y = LB, xlab ="Season", ylab ="LB")) +
  ggtitle("Late Blight Over Time")          
            
            
##CPBA Summary:            
median.cpba.byYear = df %>%
  group_by(Season) %>%
  summarise(medCPBA = median(RBaseData$CPBA))

median.cpba.byYear%>%
  ggplot(aes(x = season, y = medCPBA)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ Grower)





median.cpbl.byYear = df %>%
  group_by(Season) %>%
  summarise(medCPBL = median(RBaseData$CPBL))

RBaseDatasummary = df %>%
  group_by(Season) %>%
  summarise(medEB = median(RBaseData$EB))

df2 %>%                                  #created plots by grower to show the avg. EB by season
  ggplot(aes(x = Season, y = meanEB)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ Grower)
dfEBmean %>%
  ggplot(aes*x = Season, )


eb.summary

eb.summary %>%                                 
  ggplot(aes(x = "JulianDay", y = meanEB)) +   #! This did not work--only get one column?
  geom_bar(stat = "identity") +
  facet_wrap(~Grower)

names(RBaseData)[11] <- "JulianDay"  #renamed a column

names(RBaseData)[12] <- "EB"  #renamed a column
EB

data.frame(RBaseData)
cor(JulianDay, EB)

scatter.smooth(x=RBaseData$JulianDay, y=RBaseData$EB, main="EB ~ JulianDay") #created a scatter plot for Day x EB


df = RBaseData

eb.summary = df %>%
  group_by(Grower, Season, JulianDay, EB) %>%
  summarise(meanEB = mean(EB),
            minEB = min(EB),
            maxEB = max(EB))

RBaseData %>%             #filter for a single year
  filter(Season == 2004)

RBaseData %>%             #filter for more than 1 variable
  filter(Season == 2004, Grower == "Heartland Farms")


RBaseData %>%    #arrange sorts a table based on a variable
  arrange(Season)

RBaseData %>%  #sorting in descending order
  arrange(desc(Season))

RBaseData %>% #Filtering then arranging
  filter(Season == 2004, Grower == "Heartland Farms") %>%
  arrange(desc(Season))

RBaseData %>% #mutate or change a variable
  mutate(EB = EB + 1)

RBaseData %>% #use mutate to add a variable
  mutate(EB.MAD = mad(EB))

data.frame(RBaseData)
select(Season, Grower)




CPBE

A <- ggplot(RBaseData, aes(x = RBaseData$Season, y = RBaseData$EB)) +
  geom_violin() +
  facet_wrap( ~ "Grower")










ggplot(RBaseData, aes(x = RBaseData$Season, y = RBaseData$CPBE, xlab = "Season", ylab = "CPBE") +
  ggtitle("CPBE Over Time") +
  geom_smooth()

  
