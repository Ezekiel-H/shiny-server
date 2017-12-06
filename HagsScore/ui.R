library(readr)
library(shiny)
library(shinydashboard)

shinyUI(dashboardPage(
  dashboardHeader(title = ""),
  dashboardSidebar(selectInput("type", 
                               label = "Choose",
                               choices = c("Tries", "Carries", "Metres"),
                               selected = "Games")
                   ,
                   selectInput("weight", 
                                label = "Weight by",
                                choices = c("Min", "Games"),
                                selected = "Games")
                   ,
                    selectInput("Player", 
                                label = "Player selection",
                                choices = c(Selector_mitre10$Stats),
                                selected = "Marty Banks")
                  ),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    
    highchartOutput("hcontainer"),
    
    textOutput("textBio")
  )
  )
)