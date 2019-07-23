data.frame(RBaseData.v2)

library(RColorBrewer)

as.factor(RBaseData.v2$Season)
class(RBaseData.v2$Season)

cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

#Visual to show where EB counts are concentrated in time:
ggplot(PestProsWGS84, aes(x = Julian, y = EB, color = as.factor(Season))) +
  geom_jitter(position=position_jitter(0.2)) +
  labs(title = "Early Blight Occurrence Throughout the Season: 2004 - 2018", x = "Julian Day", y = "Early Blight Rating", col = "Season") +
  guides(color = guide_legend(reverse=T)) +
  scale_x_continuous(breaks = seq(0, 365, by = 20)) +
  scale_y_continuous(breaks = seq(0, 10, by = 0.5))

#Visual to show where LB counts are concentrated in time:
ggplot(PestProsWGS84, aes(x = Julian, y = LB, color = as.factor(Season))) +
  geom_jitter(position=position_jitter(0.2), alpha=0.6) +
  labs(title = "Late Blight Occurrence Throughout the Season: 2004 - 2018", x = "Julian Day", y = "Late Blight Rating", col = "Season") +
  guides(color = guide_legend(reverse=T)) +
  scale_x_continuous(breaks = seq(0, 365, by = 20)) +
  scale_y_continuous(breaks = seq(0, 10, by = 0.5)) 

MaxCPBESeason <- PestProsWGS84 %>%
  group_by(Season) %>%
  filter(Season, Julian, CPBE) %>%
  slice(which.max(CPBE))


#Visual to show where CPBE counts are concentrated in time:
CPBEy <- log(PestProsWGS84$CPBE+1)
CPBEPlot1 <- ggplot(PestProsWGS84, aes(x = Julian, y = CPBEy, color = as.factor(Season))) +
  geom_jitter(position=position_jitter(0.1), alpha=0.6) +
  labs(title = "Colorado Potato Beetle Egg Masses Observed Throughout the Season: 2004 - 2018", x = "Julian Day", y = "CPBE", col = "Season") +
  guides(color = guide_legend(reverse=T)) +
  scale_x_continuous(limits = c(100, 280), breaks = seq(100,280,by=10)) +
  scale_y_continuous(breaks = seq(0, 7, by = 1)) +
  theme(plot.title = element_text(size = 12))
  
MaxCPBEBarPlot <- ggplot(MaxCPBESeason, aes(Julian, CPBE, color = as.factor(Season))) + geom_col()
MaxCPBEBarPlot

#Similar graph type as above with gradient color:
ggplot(RBaseData.v2, aes(x = Julian, y = EB, color = Season)) +
  geom_jitter(position=position_jitter(0.2)) +
  labs(title = "Early Blight Occurrence Throughout the Season: 2004 - 2018", x = "Julian Day", y = "Early Blight Rating", col = "Season") +
  guides(color = guide_legend(reverse=T)) +
  scale_x_continuous(breaks = seq(0, 365, by = 20)) +
  scale_y_continuous(breaks = seq(0, 10, by = 0.5))


#Visual to show where CPBL counts are concentrated in time:
CPBLy <- log(PestProsWGS84$CPBL+1)
CPBLPlot1 <- ggplot(PestProsWGS84, aes(x = Julian, y = CPBLy, color = as.factor(Season))) +
  geom_jitter(position=position_jitter(0.1), alpha=0.6) +
  labs(title = "Colorado Potato Beetle Larvae Observed Throughout the Season: 2004 - 2018", x = "Julian Day", y = "CPBL", col = "Season") +
  guides(color = guide_legend(reverse=T)) +
  scale_x_continuous(limits = c(100, 280), breaks = seq(100,280,by=10)) +
  scale_y_continuous(breaks = seq(0, 10, by = 1)) +
  theme(plot.title = element_text(size = 12, hjust = 0.5))
CPBLPlot1

#Visual to show where CPBA counts are concentrated in time:
CPBAy <- log(PestProsWGS84$CPBA+1)
CPBAPlot1 <- ggplot(PestProsWGS84, aes(x = Julian, y = CPBAy, color = as.factor(Season))) +
  geom_jitter(position=position_jitter(0.1), alpha=0.6) +
  labs(title = "Colorado Potato Beetle Adults Observed Throughout the Season: 2004 - 2018", x = "Julian Day", y = "CPBA", col = "Season") +
  guides(color = guide_legend(reverse=T)) +
  scale_x_continuous(limits = c(100, 280), breaks = seq(100,280,by=10)) +
  scale_y_continuous(breaks = seq(0, 6, by = 0.5)) +
  theme(plot.title = element_text(size = 14, hjust = 0.5, face = "bold")) #hjust centers the ggplot title
CPBAPlot1

#Visual to show how CPB life stages compare in each growing season:

CPBStages <- PestProsWGS84 %>%
  filter(Season == 2004) %>%
  ggplot() +
  stat_smooth(data = PestProsWGS84, aes(x = Julian, y = CPBEy, color = "CPBE"), method = "lm", formula = y ~poly(x, 330), se = FALSE) + coord_cartesian(ylim = c(0, 5)) +
  scale_x_continuous(limits = c(100, 330), breaks = seq(100,330,by=20))
 ##Could draw a mean (for 2004 - 2018) for each year or for each life stage 

#Pest Pros EB (All seasons) Using Severity Ratings:
ggplot(data = PestProsWGS84, aes(x = Julian, y = EB, color = EB_Rating)) +
  geom_jitter(alpha = 0.5, size = 2) +
  labs(x = "Julian Day", y = "Early Blight Rating (0-10)", col = "EB Rating Scale") +
  ggtitle("Early Blight Severity Rating Throughout the Season: 2004-2018")
  
#Pest Pros EB (All seasons) - All seasons combined, no faceting
ggplot(data = PestProsWGS84, aes(x = Julian, y = EB, color = EB_Rating)) +
  geom_jitter(alpha = 0.5, size = 2) +
  labs(x = "Julian Day", y = "Early Blight Rating (0-10)", col = "EB Rating Scale") +
  ggtitle("Early Blight Ratings Throughout the Growing Season: 2004 - 2018") +
  scale_y_continuous(breaks = seq(0, 10, by = 0.5)) +
  scale_x_continuous(limits = c(100, 280), breaks = seq(100,280,by=10))

#Pest Pros EB (All Seasons) - All seasons combined with facet grid (seasons side by side)
#it is a nice idea but the Julian days are too condensed on the x axis
ggplot(data = PestProsWGS84, aes(x = Julian, y = EB, color = EB_Rating)) +
  geom_jitter(alpha = 0.5, size = 2) +
  labs(x = "Julian Day", y = "Early Blight Rating (0-10)", col = "EB Rating Scale") +
  ggtitle("Early Blight Ratings Throughout the Growing Season: 2004 - 2018") +
  scale_y_continuous(breaks = seq(0, 10, by = 0.5)) +
  scale_x_continuous(limits = c(100, 280), breaks = seq(100,280,by=20)) +
  facet_grid(~ Season)

#Pest Pros Box Plots:
#Early Blight:
ggplot(PestProsWGS84, aes(x = as.factor(Season), y = EB, fill = as.factor(Season))) +
  scale_color_manual(values = getPalette(n.cols)) +
  geom_boxplot(varwidth = TRUE, lwd = 0.5) +
  geom_jitter(width = 0.2, alpha = 0.01) +
  guides(fill=guide_legend(title="Season")) +
  coord_flip() +
  labs(x = "Growing Season", y = "Early Blight Rating (0-10)") +
  ggtitle("Early Blight Ratings Throughout the Growing Season: 2004 - 2018") +
  scale_y_continuous(limits = c(-1, 10), breaks = seq(-1, 10, by = 1))








#Pest Pros Density Plots:
#Early Blight:

ggplot() +
  geom_density(data = PestProsWGS84, aes(x = EB, group = as.factor(Season), fill = as.factor(Season)), alpha = 0.4, adjust = 2) +
  labs(x = "Early Blight Rating (0-10)", y = "Density", col = "Season") +
  ggtitle("Early Blight Rating Density By Growing Season: 2004 - 2018") +
  scale_x_continuous(breaks = c(0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0)) +
  guides(fill=guide_legend(title="Season"))



#Density Plot of early blight with custom color fill:

n.cols <- 15
getPalette = colorRampPalette(brewer.pal(11, "Spectral"))


ggplot() +
  geom_density(data = PestProsWGS84, aes(x = EB, group = as.factor(Season), fill = as.factor(Season)), alpha = 0.4, adjust = 2) +
  labs(x = "Early Blight Rating (0-10)", y = "Density", col = "Season") +
  ggtitle("Early Blight Rating Density By Growing Season: 2004 - 2018") +
  scale_x_continuous(breaks = c(0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0)) +
  guides(fill=guide_legend(title="Season")) +
  scale_fill_manual(values = getPalette(n.cols))


#dot plot of early blight with smoothed line:
EBdotandsmooth <- ggplot(PestProsWGS84, aes(x = Julian, y = EB)) +
  geom_smooth(method="loess", se=F, col) + xlim(c(130, 350)) + ylim(c(0, 9))

EBdotandsmooth


#Example of working with ridgeline plots: (i.e. EB each season)
library(ggridges)

ggplot(PestProsWGS84, aes(x = Julian, y = PestProsWGS84$EB)) +
  geom_density_ridges(y = PestProsWGS84$EB_Rating) +
  theme_ridges() +
  theme(legend.position = "none")





