library(shiny)
library(dplyr)

joinner <- readRDS("playerprofile.rds")
totals <- readRDS("totals.rds")

shinyUI(fluidPage(theme = "bootstrap.css",
             
                  
                  
fluidRow(
  column(12, align="center", offset =0,
         
         # Application title
         headerPanel("Player Profiler Defence")
         
  ),

  br(),  
  br(),     
fluidRow(

column(4, offset =2, 
        imageOutput("preImage", inline = TRUE)
),
column(2,        
       paste("Position"),
       br(),
       br(),
       paste("Nationality"),
       br(),
       br(),
       paste("Date of Birth"),
       br(),
       br(),
       paste("Height and Weight"),
       br(),
       br(),
       paste("Joinned Stade"),
       br(),
       br(),
       paste("Prior Teams")
),
column(4, 
       tags$b(
       textOutput("Position"),
       br(),

       textOutput("Nationality"),

       br(),
       textOutput("DOB"),
       br(),

       textOutput("HaW"),

       br(),
       textOutput("JoinS"),

       br(),
       tableOutput("PTeam")
)
)
),


br(),br(),




         

                  

                                                     
#                            
#                            
# p(
# helpText("aeo"),
# selectInput("squad", "Choose Player:", c("Current Squad", "Full Dataset")
#             
# )),

fluidRow(align="center", offset =0,
  
                                         
selectInput("player", "Choose Player:",
            
            
            
            joinner %>% filter(!is.na(PreviousPlayer)) %>% select(Player)
            # 
            # joinner$Player
                        # c(
            #   "Abdellatif Boutaty"      ,"Aled De Malmanche"       ,"Alexandre Flanquart"     ,"Antoine Burban"          ,"Arthur Coville"         
            #   ,"Bakary Meite"            ,"Benjamin Epsinal"        ,"Clement Daguin"          ,"Craig Burden"            ,"Djibril Camara"         
            #   ,"Elies El Ansari"         ,"Emmanuel Felsina"        ,"Etienne Swanepoel"       ,"Geoffrey Doumayrou"      ,"George Pisi"            
            #   ,"Gerhard Mostert"         ,"Giorgi Melikidze"        ,"Heinke Van der Merwe"    ,"Hugh Pyle"               ,"Hugo Bonneval"          
            #   ,"Jean Baptiste De Clercq" ,"Jeremy Sinzelle"         ,"Jimmy Yobo"              ,"Jonathan Danty"          ,"Jonathan Ross"          
            #   ,"Josaia Raisuqe"          ,"Jules Plisson"           ,"Julien Arias"            ,"Julien Dupuy"            ,"Karim Qadiri"           
            #   ,"Laurent Panis"           ,"Laurent Sempere"         ,"Lorenzo Cittadini"       ,"Mathieu De Giovanni"     ,"Mathieu Ugena"          
            #   ,"Meyer Bosman"            ,"Morne Steyn"             ,"Pascal Papé"             ,"Patrick Sio"             ,"Paul Alo-Emile"         
            #   ,"Paul Gabrillagues"       ,"Paul Williams"           ,"Rabah Slimani"           ,"Raphael Lakafia"         ,"Ratu Ratini"            
            #   ,"Remi Bonfils"            ,"Remi Seneca"             ,"Remy Bonfils"            ,"Romain Martial"          ,"Sakaria Taulafo"        
            #   ,"Sekou Macalou"           ,"Sergio Parisse"          ,"Simone Favaro"           ,"Steevy Cerqueira"        ,"Sylvain Nicolas"        
            #   ,"Terry Bouhraoua"         ,"Theo Millet"             ,"Tony Ensor"              ,"Waisea Nayacalevu"       ,"Will Genia"             
            #   ,"Willem Alberts"          ,"Zurabi Zhvania"         
            #   
            # ) 
)     
)
)

,


fluidRow(width = 6, align="center", offset =0,  
                tableOutput("playertable")),


fluidRow(width = 6, align="center", offset =6,  
         tableOutput("Binds"))



))
