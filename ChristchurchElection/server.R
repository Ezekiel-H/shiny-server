
library(rgdal)		
library(spdplyr)		
library(geojsonio)		
library(rmapshaper)		
library(leaflet)
library(tidyverse)
library(ggforce)		
#library(scales)		
library(shiny)
#library(RColorBrewer)
library(plyr)


# data -------------------------------

###-------------------------------Setup-----------------------------###

options(stringsasfactors = FALSE)

getwd()


###-------------------------------Data-------------------------------###

# 
# partyvotes <- readRDS("partyvotes.RDS")
# totalvotes <- readRDS("totalvotes.RDS")

votes <- readRDS("shapefiles/data/Votes.RDS")

###-------------------------------Maps------------------------------###
map <- readOGR(dsn=path.expand("shapefiles"), layer="Chchclip")

wgs84 = '+proj=longlat +datum=WGS84'
map <- spTransform(map, CRS(wgs84))
map <- map %>% filter(GED2014_NA != "Kaikoura")

map$GED2014_NA <- revalue(map$GED2014_NA, c("Christchurch Central" = "Christchurch Central", "Christchurch East"="Christchurch East", "Port Hills"="Port Hills" ))



###-----------------------------cleaning----------------------------###
# 
# partyvotes[, "Winner"] <- colnames(partyvotes[, 3:8])[apply(partyvotes[, 3:8], 1, which.max)]
# partyvotes[, "Winning Votes"] <- partyvotes[, 3:8][apply(partyvotes[, 3:8], 1, which.max)]

map$District <- map$GED2014_NA

map14 <- merge(x = map, y = (votes %>% filter(Year == '2014')), by = "District")
map11 <- merge(x = map, y = (votes %>% filter(Year == '2011')), by = "District")
map08 <- merge(x = map, y = (votes %>% filter(Year == '2008')), by = "District")

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
                          "<strong>%s<br/>Winner %s</strong><br/>National %g<br/>Labour %g<br/>Act %g<br/>Green %g<br/>Maroi %g<br/>NZF %g", 
                          map$District, map$Winner,map$`NATIONAL PARTY`, map$`LABOUR PARTY`, map$`ACT NEW ZEALAND`, map$`GREEN PARTY`, map$`MAORI PARTY`,map$`NEW ZEALAND FIRST PARTY`
                        ) %>% lapply(htmltools::HTML),
                        "ELECTORATE VOTE" = sprintf(
                          "<strong>%s</strong><br/>%s<br/>%s<br/>Margin %g votes", 
                          map$District, map$`Electoral Winner`, map$`Electorate Candidate`, map$`Electoral Majority`
                        ) %>% lapply(htmltools::HTML))
    
    #switching between the input colour filters
    #switching between the legends
    
    #fill = map$`Winning Votes`
    
    # fill <- switch(input$var,
    #                "2008" = (map$`Winning Votes`),
    #                "2008" = (map$`Winning Votes`),
    #                "2008" = (map$`Winning Votes`))
    # 
    #bins <- c(Inf, 15000, 12500, 10000, 7500, 5000, 2500, 0)
    pal <- switch(input$var,
                  "PARTY VOTE" = colorFactor(
                                              palette = map$colour,
                                              domain = map$Winner
                                              ),
                  "ELECTORATE VOTE" = colorFactor(
                                              palette = map$Ecolour,
                                              domain = map$`Electoral Winner`
                                              ))
    colourdata <- switch(input$var,
                  "PARTY VOTE" = map$colour,
                  "ELECTORATE VOTE" = map$Ecolour
                  )

    
    
    #mapping from leaflet
    
    leaflet(map) %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
                  opacity = 1.0, fillOpacity = 0.5,
                  fillColor = colourdata,
                  highlightOptions = highlightOptions(color = "white", weight = 2,
                                                      bringToFront = TRUE)
                  ,
                  label = maplabels,
                  labelOptions = labelOptions(
                    style = list("font-weight" = "normal", padding = "3px 8px"),
                    textsize = "15px",
                    direction = "auto")) 
    # %>%
    # 
    #   addLegend(pal = pal, values = ~(fill), opacity = 0.7, title = "Persons per place",
    #             position = "bottomright")
    # 
    
    # mappingdata ----------------------------
    
    #   displaymap(var = data,
    #               fillcolour = color,
    #              legend.title = legend,
    #               max = input$range[2],
    #              min = input$range[1])
    
    
    # generate bins based on input$bins from ui.R
    
    
  })
  
})

