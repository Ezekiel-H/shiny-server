
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
# packages --------------------------------------

library(shiny)
library(leaflet)

# data ------------------------------------------



shinyUI(fluidPage(theme = "bootstrap.css",

tags$style(type="text/css", "div.info.legend.leaflet-control br {clear: both;}")                  
                  
fluidRow(
column(12, align="center", offset =0,

# Application title
headerPanel("New Zealand regional liquour access per person"),



p(
helpText("From the NZ Justice department statistics select licence type"),


selectInput("var", 
label = "Choose a variable to display",
choices = c("Bars", 
"Alcohol retailers",
"Clubs"
),
selected = "Bars")

)

)),          
 
                  
mainPanel(

fluidRow(column(12, align="center", offset =3,  
leafletOutput("mymap", width = "100%", height = 400)

)),
fluidRow(column(12, align="left", offset =3,  

p("Etiam id purus mauris. Nunc imperdiet nulla turpis, sed finibus metus molestie vel. Sed imperdiet vestibulum lacus, at convallis lorem malesuada a. Ut sagittis luctus purus, varius lacinia lorem congue ac. Cras bibendum libero ac commodo pulvinar. Mauris vulputate nisl orci. Vivamus tortor risus, aliquet auctor dui eu, rutrum suscipit mi. Nulla maximus egestas vestibulum. Nam cursus at odio id vulputate.",

br("Morbi varius, neque sit amet pretium porttitor, purus justo rhoncus nisl, nec feugiat nisi nunc at magna. Nunc lectus ex, interdum in ultricies ultrices, porttitor quis arcu. Quisque quis interdum velit. Pellentesque id ante dolor. Aliquam eget elit eu quam volutpat tristique. Etiam ultricies nisi ut felis venenatis, in tempor mi hendrerit. Aliquam ac neque quis lacus venenatis varius. Nulla facilisi. Aliquam lorem tellus, fringilla in erat quis, maximus semper arcu. Morbi auctor mi at ipsum laoreet viverra. Suspendisse luctus nulla erat, vitae auctor sem suscipit sit amet. Sed volutpat sapien et justo blandit, nec laoreet libero malesuada. Sed nec purus quis dolor placerat imperdiet. Nam eget libero placerat, porttitor urna pellentesque, lacinia felis."
),
br("Aliquam pulvinar suscipit massa, ut semper ante dapibus ac. In semper ipsum lorem, vitae rhoncus leo varius nec. Integer commodo libero at lobortis sagittis. Sed volutpat interdum lectus blandit lacinia. Suspendisse ut orci at neque volutpat commodo. Nulla finibus ex vitae ornare ullamcorper. Suspendisse finibus nulla id elit feugiat porta. Nunc a purus at libero hendrerit accumsan. Praesent ornare ante eu dolor lobortis vestibulum. Nunc id tincidunt nunc. Duis vel leo gravida quam ornare pulvinar. Interdum et malesuada fames ac ante ipsum primis in faucibus. Morbi urna turpis, tincidunt non lacus a, varius placerat nisl. Etiam interdum ante eget leo porttitor vestibulum. Sed ex est, lacinia at justo a, accumsan feugiat diam."
)
))   
)

))
)
