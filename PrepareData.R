
library(XML)
library(xml2)
library(dplyr)

data <- xmlParse("exported_feed.xml")
xml_data <- xmlToList(data)

# 1st Approach
# temp <- as.list(xml_data[['group']][['record']][['metadata']])
# temp <- xml_data$group$record$metadata


# 2nd Apprach
content_path <- "//temperature[@type='hourly']/value"

df <- data.frame(name = sapply(data["//meta/@name"], as.character),
                 content = sapply(data["//meta/@content"], as.character.default))

# 3rd approach
data2 <- read_xml("exported_feed.xml")
meta <- data2 %>% xml_find_all("//meta")

df2 <- data.frame(name = sapply(meta %>% xml_attr("name"), as.character),
                  content = sapply(meta %>% xml_attr("content"), as.character))


