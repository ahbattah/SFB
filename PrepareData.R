
library(XML)
library(xml2)
library(dplyr)
library(tidyr)

data <- xmlParse("exported_feed.xml")
xml_data <- xmlToList(data)

# 1st Approach
# temp <- as.list(xml_data[['group']][['record']][['metadata']])
# temp <- xml_data$group$record$metadata


# 2nd Apprach
df <- data.frame(name = sapply(data["//meta/@name"], as.character),
                 content = sapply(data["//meta/@content"], as.character.default))

# 3rd approach
data2 <- read_xml("exported_feed.xml", encoding = "UTF-8")
meta <- data2 %>% xml_find_all("//meta")
df2 <- data.frame(name = sapply(meta %>% xml_attr("name"), as.character),
                  content = sapply(meta %>% xml_attr("content"), as.character))



tst <- function(metav) {
  srvcName <- vector(mode = "character")
  for (variable in metav) {
    if(variable %>% xml_attr("name") == "description") {
      srvcName <- append(srvcName, variable %>% xml_attr("content"))
      print(variable %>% xml_attr("content"))
    }
  }
}



desc <- sapply(meta %>% xml_attr("name"), 
               function(x){if (x == "description") (meta %>% xml_attr("content"))})

