library(XML)
library(tidyverse)
library(plyr)


ministry_xml <- xmlParse("xml/eGovernmentAuthority.xml", encoding = "UTF-8")

col_names <- c("Title", "Service_Name_EN", "Service_Name_AR", "Entity_ID_EN",
               "Entity_ID_AR", "Lifecycle_ID_EN", "Lifecycle_ID_AR", "Individual",
               "Online", "Service_Link_EN", "Service_Link_AR", "Keywords_EN",
               "Keywords_AR", "Email", "Website_URL")


services <- data.frame(matrix(ncol = 15, nrow = 0))
services <- setNames(services, col_names)

df <- data.frame(
  Title = xpathSApply(ministry_xml, "//item//title", xmlValue),
  Service_Name_EN = xpathSApply(ministry_xml, "//item//ibmwcm:element[@name = 'Service Name']//ibmwcm:value", xmlValue),
  Service_Name_AR = xpathSApply(ministry_xml, "//item//ibmwcm:element[@name = 'Service Name_ar']//ibmwcm:value", xmlValue),
  Entity_ID_EN = xpathSApply(ministry_xml, "//item//ibmwcm:element[@name = 'Entities ID']//ibmwcm:value", xmlValue),
  Entity_ID_AR = xpathSApply(ministry_xml, "//item//ibmwcm:element[@name = 'Entities ID_ar']//ibmwcm:value", xmlValue),
  Lifecycle_ID_EN = xpathSApply(ministry_xml, "//item//ibmwcm:element[@name = 'Life Cycle ID']//ibmwcm:value", xmlValue),
  Lifecycle_ID_AR = xpathSApply(ministry_xml, "//item//ibmwcm:element[@name = 'Life Cycle ID_ar']//ibmwcm:value", xmlValue),
  Individual = xpathSApply(ministry_xml, "//item//ibmwcm:element[@name = 'is Individuals']//ibmwcm:value", xmlValue),
  Online = xpathSApply(ministry_xml, "//item//ibmwcm:element[@name = 'is Online']//ibmwcm:value", xmlValue),
  Service_Link_EN = xpathSApply(ministry_xml, "//item//ibmwcm:element[@name = 'Service Link']//ibmwcm:value", xmlValue),
  Service_Link_AR = xpathSApply(ministry_xml, "//item//ibmwcm:element[@name = 'ServiceLink_ar']//ibmwcm:value", xmlValue),
  Keywords_EN = xpathSApply(ministry_xml, "//item//ibmwcm:element[@name = 'Keywords']//ibmwcm:value", xmlValue),
  Keywords_AR = xpathSApply(ministry_xml, "//item//ibmwcm:element[@name = 'Keywords_ar']//ibmwcm:value", xmlValue),
  Email = ifelse(
    length(xpathApply(ministry_xml, "//item//ibmwcm:element[@name = 'Email ID']")) > 0 ,
    xpathSApply(ministry_xml, "//item//ibmwcm:element[@name = 'Email ID']//ibmwcm:value", xmlValue),
    NA),
  Website_URL = ifelse(
    length(xpathApply(ministry_xml, "//item//ibmwcm:element[@name = 'Website URL']")) > 0 ,
    xpathSApply(ministry_xml, "//item//ibmwcm:element[@name = 'Website URL'][1]//ibmwcm:value", xmlValue),
    NA)
)
