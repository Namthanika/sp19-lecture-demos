# This is the preprocessing code!
# We formatted the data (originally from data.gov) so that it is easier for you to work with.
# You do not need to read this file unless you want to :)
library(dplyr)

read.csv('Air_Quality_Measures_on_the_National_Environmental_Health_Tracking_Network.csv', stringsAsFactors = FALSE) %>% 
  filter(StateName == 'Washington',
         CountyName %in% c('Clark', 'King', 'Pierce', 'Snohomish', 'Spokane', 'Yakima'),
         MeasureName == 'Percent of days with PM2.5 levels over the National Ambient Air Quality Standard (NAAQS)') %>% 
  arrange(CountyName, ReportYear) %>% 
  select(StateName, CountyName, ReportYear, Value, Unit, MeasureName) %>% 
  write.csv('wa_unhealthy_air.csv', row.names = FALSE)
