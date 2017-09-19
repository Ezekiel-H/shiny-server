
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(leaflet)
library(shiny)

shinyUI(fillPage(

  # Application title
  # titlePanel("Old Faithful Geyser Data"),

  # Sidebar with a slider input for number of bins


    # Show a plot of the generated distribution

      

        # fluidRow(column(12, align="center", 
                        leafletOutput("mymap", height = "100%")
                       #  ,
                       # 
                       # 
                       # leafletOutput("othermap", width = "100%", height = 400)



, #main pannel
absolutePanel(top = 10, right = 10,
              
              
               selectInput("var",  
                              label = "Choose a variable to display", 
                              choices = c("PARTY VOTE",  
                                             "ELECTORATE VOTE" 
                                             ), 
                              selected = "PARTY VOTE"),
              selectInput("year",  
                          label = "Choose a variable to display", 
                          choices = c("2014",  
                                      "2011", 
                                      "2008" 
                          ), 
                          selected = "2014") 
              
) #absolute pannel

) #fluid page
) #ui
