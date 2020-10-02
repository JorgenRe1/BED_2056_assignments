# Urls to scrape from datacamp
urls <- list("https://www.datacamp.com/courses/tech:r", "https://datacamp.com/courses/tech:python")

library('xml2')
library('rvest')

scrape_courses <- function(url) {
  # Get website html
  webpage <- read_html(url)
  # Get course title nodes
  courses <- html_nodes(webpage,'.course-block__title')
  # Finally get title of course
  course_names <- html_text(courses)
  # Get programming language from end of url
  language <- sapply(strsplit(url, ":"), tail, 1)
  # Create dataframe
  scraped_courses <- data.frame(tech=course_names, language=language)
}

result <- data.frame()

for (url in urls) {
  result <- rbind(result, scrape_courses(url))
}

head(result)
tail(result)
