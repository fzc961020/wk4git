#The room is too shiny....
library(tidyverse)
library(here)
library(sf)
library(janitor)
library(sp)
library(tmap)
library(tmaptools)

mycsv <- read_csv('Gender Inequality Index (GII)_only2.csv',na = c("..", "NA"))
class(mycsv)

myshape <- st_read(here::here("World_Countries_(Generalized)","World_Countries__Generalized_.shp"))
filcsv <- mycsv%>%
  clean_names()%>%
  filter(x2019 !="..")
filcsv2 <- mycsv%>%
  filter(x2010!="..")
diffcsv <- filcsv2%>%
  mutate(diff = x2019-x2010)

worldmap <- myshape %>%
  clean_names()%>%
# the . here just means use the data already loaded
  merge(.,
        diffcsv, 
        by.x="country", 
        by.y="Country",
        no.dups = TRUE)
tmap_mode('plot')
worldmap%>%
  qtm(.,fil='diff')


