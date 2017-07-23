
libs <- c("tidyverse", "lubridate", "httr", "RCurl", "jsonlite", "readxl", "dplyr", "shiny", "rmarkdown", "knitr") #, "stringdist")
lapply(libs, require, character.only = TRUE)

####### 

####### Read in data
joinner <- readRDS("playerprofile.rds")
totals <- readRDS("totals.rds")


joinner <- joinner %>% filter(OnSite=="Y") 
 


shinyServer(function(input, output) {
 
  
### initial tables   
output$playertable <- renderTable({


joinner %>% 
  filter(Player ==  paste(input$player)) %>%
  select(Total.Mins,"Tackles Made" = Total.Complete,"Tackle Percentage" = PercentageMade,Carries,Metres)

  
})
#input$n()


output$playerstats <- renderTable({
  
  joinner %>%
    filter(Player ==  paste(input$player)) %>%
    select(Country,"Date Of Birth" = DOB,"Heigh and Weight" = HeightWeight, "Joined Stade France" = Arrived)
  
  
})

###



output$Binds <- renderTable({
   a <- joinner %>%
    filter(Player == paste(input$player)) %>%
    summarise("Missed Tackles" = PercentageMade, "Missed Passive Tackles" = PercentagePassiveMissed, "Average Tackles Per Game" = (Total.Complete/Total.Mins*80))
  
    posi <- joinner %>% filter(Player == input$player) %>% select(Position)
    add_column(a, "Player")
    
    b <- totals %>%
    filter(Position ==  paste(posi)) %>%
    select("Missed Tackles" = MissedTackles, "Missed Passive Tackles" = MissedPassiveTackles, "Average Tackles Per Game" = AverageTacklesPerGame) 
    add_column(b, "Position")
    
    c <- totals %>%
    filter(Position ==  "Totals") %>%
    select("Missed Tackles" = MissedTackles, "Missed Passive Tackles" = MissedPassiveTackles, "Average Tackles Per Game" = AverageTacklesPerGame) 
    add_column(c, "Team")
    

    
  totals  <- bind_rows(a, b, c)
  add_column(totals, "Group" = c("Player", "Position", "Team"))
   
  })



### Text outputs

output$Position <- renderText({
  as.character(
    joinner %>%
    filter(Player ==  paste(input$player)) %>%
    select("Position" = Position)
)
})


output$Nationality <- renderText({
  as.character(
    joinner %>%
      filter(Player ==  paste(input$player)) %>%
      select("Nationality" = Nationality)
  )
})


output$DOB <- renderText({
  as.character(
    joinner %>%
      filter(Player ==  paste(input$player)) %>%
      select("DOB" = DOB)
  )
})


output$HaW <- renderText({
  as.character(
    joinner %>%
      filter(Player ==  paste(input$player)) %>%
      select("HaW" = HeightWeight)
  )
})


output$JoinS <- renderText({
  as.character(
    joinner %>%
      filter(Player ==  paste(input$player)) %>%
      select("JoinnedStade" = Arrived)
  )
})

output$PTeam <- renderTable(colnames = FALSE, {
    joinner %>%
      filter(Player ==  paste(input$player)) %>%
      select("Prior Teams" = PriorTeams)
})


###


output$preImage <- renderImage({
  # When input$n is 3, filename is ./images/image3.jpeg
  filename <- normalizePath(file.path('./Assets/Images',
                                      paste(joinner %>% 
                                              filter(Player ==  input$player) %>%
                                              select(lastlower), '.jpg', sep='')))
  # 
  # # Return a list containing the filename and alt text
   list(src = filename,
        alt = paste("Image number", joinner %>% 
                      filter(Player ==  input$player) %>%
        select(lastlower)))
  
}, deleteFile = FALSE)


})
