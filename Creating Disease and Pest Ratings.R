#creating new columns in RBaseData for severity ratings:
data.frame(RBaseData)
RBaseData
#EB Ratings (Based on Randy's parameters)
PestProsWGS84$EB_Rating[PestProsWGS84$EB == 0] = "ABSENT"
PestProsWGS84$EB_Rating[PestProsWGS84$EB > 0 & PestProsWGS84$EB <= 0.5] = "TRACE"
PestProsWGS84$EB_Rating[PestProsWGS84$EB > 0.5 & PestProsWGS84$EB <= 2] = "LOW"
PestProsWGS84$EB_Rating[PestProsWGS84$EB > 2 & PestProsWGS84$EB < 4] = "MEDIUM"
PestProsWGS84$EB_Rating[PestProsWGS84$EB >= 4] = "HIGH"
PestProsWGS84

#LB Ratings
RBaseData$LB_Rating[RBaseData$LB == 0] = "ABSENT"
RBaseData$LB_Rating[RBaseData$LB > 0 & RBaseData$LB <= 0.5] = "TRACE"
RBaseData$LB_Rating[RBaseData$LB > 0.5 & RBaseData$LB <= 2] = "LOW"
RBaseData$LB_Rating[RBaseData$LB > 2 & RBaseData$LB < 4] = "MEDIUM"
RBaseData$LB_Rating[RBaseData$LB >= 4] = "HIGH"
RBaseData
as.character(PestProsWGS84$CPBE)
#CPBE Ratings:
PestProsWGS84$CPBE_Rating[PestProsWGS84$CPBE == 0] = "ABESNT"
PestProsWGS84$CPBE_Rating[PestProsWGS84$CPBE > 0 & PestProsWGS84$CPBE < 0.05] = "TRACE"
PestProsWGS84$CPBE_Rating[PestProsWGS84$CPBE >= 0.05 & PestProsWGS84$CPBE < 0.1] = "LOW"
PestProsWGS84$CPBE_Rating[PestProsWGS84$CPBE >= 0.1 & PestProsWGS84$CPBE < 0.2] = "MEDIUM"
PestProsWGS84$CPBE_Rating[PestProsWGS84$CPBE >= 0.2] = "HIGH"
RBaseData

#CPBL Ratings:
RBaseData$CPBL_Rating[RBaseData$CPBL == 0] = "ABSENT"
RBaseData$CPBL_Rating[RBaseData$CPBL > 0 & RBaseData$CPBL < 5] = "TRACE"
RBaseData$CPBL_Rating[RBaseData$CPBL >= 5 & RBaseData$CPBL < 10] = "LOW"
RBaseData$CPBL_Rating[RBaseData$CPBL >= 10 & RBaseData$CPBL < 20] = "MEDIUM"
RBaseData$CPBL_Rating[RBaseData$CPBL >= 20] = "HIGH"
RBaseData

#CPBA Ratings:
RBaseData$CPBA_Rating[RBaseData$CPBA == 0] = "ABSENT"
RBaseData$CPBA_Rating[RBaseData$CPBA > 0 & RBaseData$CPBA < 1] = "TRACE"
RBaseData$CPBA_Rating[RBaseData$CPBA >= 1 & RBaseData$CPBA < 5] = "LOW"
RBaseData$CPBA_Rating[RBaseData$CPBA >= 5 & RBaseData$CPBA < 10] = "MEDIUM"
RBaseData$CPBA_Rating[RBaseData$CPBA >= 10] = "HIGH"

RBaseData #checking the categorical assignments; it seems the CPBE category has some sporadic counts/values are much higher than specified threshold
unique(RBaseData$CPBA_Rating)
unique(RBaseData$CPBL_Rating)
unique(RBaseData$CPBE_Rating)
unique(RBaseData$CPBE)
range(RBaseData$CPBE)
unique(RBaseData$EB_Rating)
unique(RBaseData$LB_Rating)

write.csv(RBaseData, "C:\\Users\\mcapp\\OneDrive\\Documents\\R\\Output\\RBaseData.v2.csv")
#RBaseData.v2 created with the rating columns under the output in R folder

