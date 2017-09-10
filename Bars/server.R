# server -----------------------------

# packages ---------------------------

library(rsconnect)
library(shiny)
library(rgdal)
library(spdplyr)
library(geojsonio)
library(rmapshaper)
library(leaflet)

# data -------------------------------

getwd()

#setwd("~/Bars")

map <- readOGR(dsn=path.expand("data//Shapefiles"), layer="TA2017_")


wgs84 = '+proj=longlat +datum=WGS84'
map <- spTransform(map, CRS(wgs84))


map <- map %>% filter(TA2017_ != "Chatham Islands Territory")


#map <- ms_simplify(map)

map$TA2017_Nam <- map$TA2017_

#writeOGR(map, path.expand("data"), layer ="TA2017_", driver="ESRI Shapefile")



TAbase <- read.csv(file="TABASE.csv", header = TRUE, sep = ",")

#map$TA2017_Nam <- map$TA2017_NAM

map <- merge(y = TAbase, x = map, by = "TA2017_Nam")

bins <- c(Inf, 1500, 1250, 1000, 750, 500, 250, 0)
pal <- colorBin("Blues", domain = map$Pop_2016, bins = bins, reverse = TRUE)





# functions --------------------------


shinyServer(function(input, output) {

  output$mymap <- renderLeaflet({

    #switching between the input labels
    
    maplabels <- switch(input$var,
                        "Bars" = sprintf(
      "<strong>%s</strong><br/>%g People for every bar", 
      map$DLC, round(map$Pop_2016/map$On_licence, digits = 1)
    ) %>% lapply(htmltools::HTML),
                        "Alcohol retailers" = sprintf(
      "<strong>%s</strong><br/>%g People for every liquour outlet", 
      map$DLC, round(map$Pop_2016/map$Off_licence, digits = 1)
    ) %>% lapply(htmltools::HTML),
                        "Clubs" = sprintf(
      "<strong>%s</strong><br/>%g People for every club", 
      map$DLC, round(map$Pop_2016/map$Club_Licence, digits = 1)
    ) %>% lapply(htmltools::HTML))
    
    #switching between the input colour filters
    #switching between the legends
    
    fill <- switch(input$var,
    "Bars" = (map$Pop_2016/map$On_licence),
    "Alcohol retailers" = (map$Pop_2016/map$Off_licence),
    "Clubs" = (map$Pop_2016/map$Club_Licence))
    
    
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
