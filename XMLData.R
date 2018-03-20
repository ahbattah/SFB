library(XML)
library(tidyverse)
library(plyr)


capitalGovernorate_xml <- xmlParse("xml/CapitalGovernorate.xml", encoding = "UTF-8")
as.data.frame(CpitaCapitalGovernorate_xml)

df <- data.frame(
  Title = xpathSApply(capitalGovernorate_xml, "//item//title", xmlValue),
  Service_Name = xpathSApply(capitalGovernorate_xml, "//item//ibmwcm:element[@name = 'Service Name']//ibmwcm:value", xmlValue)
)

nodeset <- getNodeSet(capitalGovernorate_xml, "/rss/channel/item")
var.names <- lapply(nodeset, names)
