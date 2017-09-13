
library(rgdal)
library(spdplyr)
library(geojsonio)
library(rmapshaper)
library(leaflet)
library(tidyverse)
library(ggforce)
library(scales)
library(shiny)
library(RColorBrewer)

# data -------------------------------

###-------------------------------Setup-----------------------------###

options(stringsasfactors = FALSE)




###-------------------------------Data-------------------------------###


partyvotes <- readRDS("partyvotes.RDS") 
totalvotes <- readRDS("totalvotes.RDS")


###-------------------------------Maps------------------------------###
map <- readOGR(dsn=path.expand("shapefiles"), layer="Chchclip")

wgs84 = '+proj=longlat +datum=WGS84'
map <- spTransform(map, CRS(wgs84))
map <- map %>% filter(GED2014_NA != "Kaikoura")

colnames(partyvotes)[1] <- "District"

map$GED2014_NA <- revalue(map$GED2014_NA, c("Christchurch Central" = "Christchurch Central", "Christchurch East"="Christchurch East", "Port Hills"="Port Hills" ))


###-----------------------------cleaning----------------------------###

partyvotes[, "Winner"] <- colnames(partyvotes[, 3:8])[apply(partyvotes[, 3:8], 1, which.max)]

map$District <- map$GED2014_NA

map14 <- merge(x = map, y = (partyvotes %>% filter(Year == '2014')), by = "District")
map11 <- merge(x = map, y = (partyvotes %>% filter(Year == '2011')), by = "District")
map08 <- merge(x = map, y = (partyvotes %>% filter(Year == '2008')), by = "District")

# functions --------------------------


shinyServer(function(input, output) {
  
  
  
  output$mymap <- renderLeaflet({
    
    #switching between the input labels
    
    map <- switch(input$year,
                        "2014" = map14,
                        "2011" = map11,
                        "2008" = map08)
    
    maplabels <- switch(input$var,
                        "PARTY VOTE" = sprintf(
                          "<strong>%s</strong><br/>%s", 
                          map$District, map$Winner
                        ) %>% lapply(htmltools::HTML),
                        "ELECTORATE VOTE" = sprintf(
                          "<strong>%s</strong><br/>%s", 
                          map$District, map$Winner
                        ) %>% lapply(htmltools::HTML))
    
    #switching between the input colour filters
    #switching between the legends
    
    fill <- switch(input$var,
                   "NATIONAL PARTY" = (map$`NATIONAL PARTY`),
                   "LABOUR PARTY" = (map$`LABOUR PARTY`),
                   "GREEN PARTY" = (map$`GREEN PARTY`))
    
    bins <- c(Inf, 1500, 1250, 1000, 750, 500, 250, 0)
    pal <- colorBin("Blues", domain = map$`NATIONAL PARTY`, bins = bins, reverse = TRUE)
    #mapping from leaflet
    
    leaflet(map) %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
                  opacity = 1.0, fillOpacity = 0.5,
                  fillColor = ~pal(fill)
                  ,
                  highlightOptions = highlightOptions(color = "white", weight = 2,
                                                      bringToFront = TRUE)
                  ,
                  label = maplabels,
                  labelOptions = labelOptions(
                    style = list("font-weight" = "normal", padding = "3px 8px"),
                    textsize = "15px",
                    direction = "auto")) %>%
      
      addLegend(pal = pal, values = ~(fill), opacity = 0.7, title = "Persons per place",
                position = "bottomright")
    
    
    # mappingdata ----------------------------
    
    #   displaymap(var = data,
    #               fillcolour = color,
    #              legend.title = legend,
    #               max = input$range[2],
    #              min = input$range[1])
    
    
    # generate bins based on input$bins from ui.R
    
    
  })
  
})

