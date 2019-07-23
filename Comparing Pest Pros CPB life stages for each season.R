
CPBEy <- log(PestProsWGS84$CPBE+1)
CPBLy <- log(PestProsWGS84$CPBL+1)
CPBAy <- log(PestProsWGS84$CPBA+1)
CPB2004 <- PestProsWGS84 %>%
  filter(Season == 2004) %>% {
  ggplot(PestProsWGS84, aes(x = Julian, y = CPBEy, color = CPBE_Rating)) +
  geom_jitter(position=position_jitter(0.1), alpha=0.6) +
  labs(title = "Colorado Potato Beetle Egg Observed Throughout the Season: 2004 - 2018", x = "Julian Day", y = "CPBE", col = "CPBE Rating") +
  guides(color = guide_legend(reverse=T)) +
  scale_x_continuous(limits = c(100, 280), breaks = seq(100,280,by=10)) +
  scale_y_continuous(breaks = seq(0, 7, by = 1)) +
  theme(plot.title = element_text(size = 12)) }


  unique(PestProsWGS84$CPBE_Rating)
#could combine multiple histograms or density curves - compare two seasons in each graph
#easiest way to do this will likely be to create a long (instead of existing wide) data set to group CPBA, CPBE, and CPBL
data.frame(PestProsWGS84)
PestProsCPBCompare <- cbind(CPB_Observation = (CPBE, CPBL, CPBA), CPB_Rating = (CPBE_Rating, CPBL_Rating, CPBA_Rating))
  
    
  
  
  
  
PestProsWGS84 %>% 
filter(Season == 2004) %>%
  ggplot(PestProsWGS84, aes(x = Julian, y = CPBEy)) +
  geom_histogram(binwidth = 5)

plot(CPB2004)   
