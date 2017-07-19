library(rgdal)
library(spdplyr)
library(geojsonio)
library(rmapshaper)
library(leaflet)


map <- readOGR(dsn=path.expand("C:\\Users\\ehaggart001\\Desktop\\R\\NZMAP\\2017 Digital Boundaries High Def Clipped"), layer="TA2017_HD_Clipped")

#### Converting format #######

wgs84 = '+proj=longlat +datum=WGS84'
map <- spTransform(map, CRS(wgs84))

#### Removing Chattam Islands ####

map <- map %>% filter(TA2017_NAM != "Chatham Islands Territory")

#### Providing smaller map size #######

map_simplified <- ms_simplify(map)

#### Check plot works ########

#leaflet(map_simplified) %>%
#addTiles() %>%
#addPolygons()

#### Reading stats into stats files ###


stats <- read.csv(file="C:\\Users\\ehaggart001\\Downloads\\RegionalPopData.csv", header = TRUE, sep = ",")
TAbase <- read.csv(file="C:\\Users\\ehaggart001\\Desktop\\R\\TABASE.csv", header = TRUE, sep = ",")

#### Correct the name ####

map_simplified$TA2017_Nam <- map_simplified$TA2017_NAM


################

map_simplified <- merge(y = TAbase, x = map_simplified, by = "TA2017_Nam")

head(test)
head(map_simplified)



##### Add labels and frills #####

maplabels <- sprintf(
  "<strong>%s</strong><br/>%g", 
  map_simplified$DLC, map_simplified$On.licence
) %>% lapply(htmltools::HTML)


bins <- c(0, 10, 50, 100, 150, 200, 250, 400, 450, Inf)
pal <- colorBin("YlOrRd", domain = map_simplified$On.licence, bins = bins)

leaflet(map_simplified) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.5,
              fillColor = ~pal(On.licence),
              highlightOptions = highlightOptions(color = "white", weight = 2,
                                                  bringToFront = TRUE)
              ,
              label = maplabels,
              labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "15px",
                direction = "auto")) %>%
  
  addLegend(pal = pal, values = ~(On.licence), opacity = 0.7, title = NULL,
            position = "bottomright")

map$TA2017_NAM