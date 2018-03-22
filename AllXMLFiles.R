
library(XML)
library(tidyverse)

# All xml files path
files <- dir("xml/")

# DF columns names
col_names <- c("Title", "Service_Name_EN", "Service_Name_AR", "Entity_ID_EN",
               "Entity_ID_AR", "Lifecycle_ID_EN", "Lifecycle_ID_AR", "Individual",
               "Online", "Service_Link_EN", "Service_Link_AR", "Keywords_EN",
               "Keywords_AR", "Email", "Website_URL")

# Creating dataframe
services <- data.frame(matrix(ncol = 15, nrow = 0))
services <- setNames(services, col_names)

path <- "C:\\Users\\stsscab\\Desktop\\R files\\tmp\\"

# Function to fill services DF
fillServices <- function(path) {
  temp_df <- data.frame()
  for (variable in dir(path)) {
    
    print(paste0("xmlFile=", variable))
    
    # Read xml file
    xmlFile <- xmlParse(paste0(path, variable), encoding = "UTF-8")
    
    # Create temp df
    xml_df <- data.frame(
      Title = xpathSApply(xmlFile, "//item//title", xmlValue),
      Service_Name_EN = xpathSApply(xmlFile, "//item//ibmwcm:element[@name = 'Service Name']//ibmwcm:value", xmlValue),
      Service_Name_AR = xpathSApply(xmlFile, "//item//ibmwcm:element[@name = 'Service Name_ar']//ibmwcm:value", xmlValue),
      Entity_ID_EN = xpathSApply(xmlFile, "//item//ibmwcm:element[@name = 'Entities ID']//ibmwcm:value", xmlValue),
      Entity_ID_AR = xpathSApply(xmlFile, "//item//ibmwcm:element[@name = 'Entities ID_ar']//ibmwcm:value", xmlValue),
      Lifecycle_ID_EN = xpathSApply(xmlFile, "//item//ibmwcm:element[@name = 'Life Cycle ID']//ibmwcm:value", xmlValue),
      Lifecycle_ID_AR = xpathSApply(xmlFile, "//item//ibmwcm:element[@name = 'Life Cycle ID_ar']//ibmwcm:value", xmlValue),
      Individual = xpathSApply(xmlFile, "//item//ibmwcm:element[@name = 'is Individuals']//ibmwcm:value", xmlValue),
      Online = xpathSApply(xmlFile, "//item//ibmwcm:element[@name = 'is Online']//ibmwcm:value", xmlValue),
      Service_Link_EN = xpathSApply(xmlFile, "//item//ibmwcm:element[@name = 'Service Link']//ibmwcm:value", xmlValue),
      Service_Link_AR = xpathSApply(xmlFile, "//item//ibmwcm:element[@name = 'ServiceLink_ar']//ibmwcm:value", xmlValue),
      Keywords_EN = xpathSApply(xmlFile, "//item//ibmwcm:element[@name = 'Keywords']//ibmwcm:value", xmlValue),
      Keywords_AR = xpathSApply(xmlFile, "//item//ibmwcm:element[@name = 'Keywords_ar']//ibmwcm:value", xmlValue),
      #Email = xpathSApply(xmlFile, "//item//ibmwcm:element[@name = 'Email ID']//ibmwcm:value", xmlValue),
      #Website_URL = xpathSApply(xmlFile, "//item//ibmwcm:element[@name = 'Website URL'][1]//ibmwcm:value", xmlValue)
      stringsAsFactors = FALSE
    )
    
    print(paste0("xml_df =", nrow(xml_df)))
    print(paste0("temp_df =", nrow(temp_df)))
    
    # Add xml_df to services
    bind_rows(temp_df, xml_df)
    
  }
  return(temp_df)
}


