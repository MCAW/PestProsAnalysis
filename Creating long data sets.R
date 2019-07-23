library(reshape2)
library(tidyr)
library(tidyverse)

data.frame(PestProsWGS84)
PestProsCPBLongData <- PestProsWGS84 %>%
  gather('CPBE', 'CPBA', 'CPBL', key = "CPB_lifestage", value = "CPB_Intensity")

PestProsCPBLongData2 <- PestProsCPBLongData %>%
  gather('CPBL_Rating', 'CPBA_Rating', 'CPBE_Rating', key = "CPB_Rating", value = "Severity")

