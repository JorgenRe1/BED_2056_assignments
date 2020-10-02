timeTableUrl <- "http://timeplan.uit.no/emne_timeplan.php?sem=20h&module%5B%5D=BED-2056-1&View=list"

library('xml2')
library('rvest')


# Get website html
webpage <- read_html(timeTableUrl)
# Get course title nodes
dates <- webpage %>% html_nodes(".table-primary td:first-child") %>%
  # html text removes <br>. So instead remove tags one by one
  gsub(pattern = '<td>', replacement = "") %>%
  gsub(pattern = '</td>', replacement = "") %>%
  # Remove the day name from it
  strsplit(., "<br>") %>%
  sapply(., tail, 1)

library("dplyr")

# Create a data frame and make date type
timePlan <- data.frame(date=dates) %>%
  mutate(date = as.Date(date, format="%d.%m.%Y"))
as.Date(timePlan$date, "%d.%m.%Y")

head(timePlan)






