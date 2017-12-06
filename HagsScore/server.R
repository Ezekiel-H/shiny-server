library(readr)
library(shiny)
library(shinydashboard)
library(highcharter)
library(dplyr)

options(stringsAsFactors = FALSE)

Selector_mitre10 <- as.data.frame(read_csv("C:/Users/Ezekiel/Desktop/R/shiny-server/HagsScore/Assets/Selector_mitre10.csv"))

shinyServer(function(input, output) {


  output$hcontainer <- renderHighchart({
    
    
    
    target <- Selector_mitre10 %>% select(Stats, abc = paste(input$type), weights = paste(input$weight)) %>% 
      mutate(weighted = abc/weights)
    
    
    # 
    # target <- Selector_mitre10 %>% select(Stats, abc = Metres, weights = Min) %>% 
    #   mutate(weighted = abc/weights)
    # 
    
    highchart() %>%
      hc_xAxis(categories = target$Stats) %>% 
      hc_add_series(name = "Tackles", data = target$weighted, type = "column") %>%
      hc_tooltip(sort = TRUE, table = TRUE, valueDecimals = 2, type = "column") %>%
      #hc_colors(cols) %>%
      hc_title(text = "Weighted Attack Statistics")
    
    # %>%
    #   hc_tooltip(sort = TRUE, table = TRUE, valueDecimals = 2) %>%
    #   hc_yAxis(min = 0, max = 1) %>%
    #   hc_colors(cols)
  
    
  })
  
  
  
  output$textBio <- renderPrint({Selector_mitre10 %>%
      filter(Stats == paste(input$Player)) %>%
      select(Bio)
  
  })
  
  #"Marty Banks") %>%
  
})

