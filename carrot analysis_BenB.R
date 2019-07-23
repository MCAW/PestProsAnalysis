library(tidyverse)
library(spatstat)


# Load data ----

# read from csv
clust_in =
  read.csv("data/carrot_locs.csv") %>%
  filter(AY == 1) %>% # diseased only
  mutate_if(is.character, as.factor)

# simplify dataset
clust =
  clust_in %>%
  mutate(Loc = NewLocDecFt) %>%
  select(c(Course, Density, Bed, PlotID, Row, Loc))



# Run the simulations ----

# randomization function
genptsppp = function(ppp) {
  require(spatstat)
  xrange = ppp$window$xrange
  yrange = ppp$window$yrange
  ppp$x = sample(1:3, ppp$n, replace = T)
  ppp$y = runif(ppp$n, 0, 22)
  return(ppp)
}

# get list of plot names
plots = levels(clust$PlotID)

# 20 sim a=.10; 40 sim a=.05
nsims = 200

# run simulations
for (p in plots) {
  # initiate data frame
  if (p == plots[1]) {sims = NULL}
  
  # create ppp object of current plot
  plot =
    clust %>%
    filter(PlotID == p) %>%
    ppp(
      x = .$Row,
      y = .$Loc,
      xrange = c(0, 4),
      yrange = c(0, 22)
    )
  
  # echo status
  print(paste0("Running ", nsims, " sims of ", p, " (n = ", plot$n, ")"))
  
  # run simulation envelope
  env =
    envelope(plot,
             Kest,
             verbose = F,
             nsim = nsims,
             simulate = expression(genptsppp(plot))
             )
  
  # bind results to data frame
  sims =
    rbind(sims,
          data.frame(
            plot = p,
            r = env$r,
            obs = env$obs,
            min = env$lo,
            max = env$hi
          ))
}

# Plot the simulations ----
p.sims =
  sims %>%
  ggplot(aes(x = r,
             y = obs,
             ymin = min,
             ymax = max)) +
  geom_ribbon(alpha = .5) +
  geom_line(color = "red") +
  facet_wrap(~plot) +
  scale_x_continuous(labels = c(0, .25, .5, .75, 1)) +
  scale_y_sqrt() +
  labs(title = paste(nsims, "carrot disease clustering simulations"),
       y = "K(r)") +
  theme_bw()
p.sims
ggsave("out/sim results.png", p.sims)

# plot all carrot locs
p.carrots =
  clust %>%
  ggplot(aes(x = Row,
             y = Loc)) +
  geom_point() +
  scale_x_continuous(limits = c(0.5, 3.5)) +
  facet_wrap( ~ PlotID, nrow = 2) +
  labs(title = "Diseased carrot locations by plot",
       y = "Position within row (ft)") +
  theme_bw()
p.carrots
ggsave("out/carrot locs.png", p.carrots)



# Distmaps (new way) ----

# set multi plot margins
par(mfrow = c(2, 10),
    mar = c(1, 1, 2, 1))

for (p in plots) {
  pts = clust %>%
    filter(PlotID == p) %>%
    ppp(
      x = .$Row,
      y = .$Loc,
      xrange = c(0, 4),
      yrange = c(0, 22)
    )
  image = distmap(pts)
  image(image, main = plot, ribbon = FALSE)
  plot(pts, add = TRUE, col = 'white', pch = 20)
}



# Distmaps (old way) ----

# # define WTM coordinate extents for carrot field
# fieldExtent =
#   data.frame(x = c(556040, 556107),
#              y = c(405070, 405119))
# 
# # create ppp object from carrot locations and field extent
# carrot.ppp =
#   carrots %>%
#   ppp(x = .$x,
#       y = .$y,
#       xrange = fieldExtent$x,
#       yrange = fieldExtent$y)
# 
# # generate distmap for whole field
# carrot.distmap = distmap(carrot.ppp)
# png("distmaps/field.png")
# plot(ay.distmap, main = "AY distmap", ribbon = FALSE)
# dev.off()
# 
# # generate distmaps for each plot
# for (plot in levels(carrots$PlotID)) {
#   image =
#     carrots %>%
#     filter(PlotID == plot) %>%
#     ppp(x = .$x, y = .$y,
#         xrange = range(.$x) + c(-1, 1),
#         yrange = range(.$y) + c(-1, 1)) %>%
#     distmap()
#   png(paste0("distmaps/", plot, ".png"))
#   image(image, main = plot)
#   dev.off()
# }

