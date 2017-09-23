
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
# packages --------------------------------------

library(shiny)
library(leaflet)

# data ------------------------------------------



shinyUI(fillPage(
  
  # Application title
  #titlePanel("TLA's in NZ"),
  
  
  leafletOutput("mymap", height = "100%")
  
  , #main pannel
  absolutePanel(top = 100, left = 50,
                
                
                
                p(
                  helpText("From the NZ Justice department statistics select licence type"),
                  
                  
                  selectInput("var", 
                              label = "Choose Bar, Club or Retailer",
                              choices = c("Bars", 
                                          "Alcohol retailers",
                                          "Clubs"
                              ),
                              selected = "Bars")
))))
###------------------------------------------###
