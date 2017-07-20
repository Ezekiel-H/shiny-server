library(dplyr)

#read in data and save as RDS file


ForAgainst <- read.csv(file = "Assets/Data/ForAgainst.csv", header = TRUE, sep = ",", stringsAsFactors=FALSE)
TeamOverview <- read.csv(file = "Assets/Data/TeamOverview.csv", header = TRUE, sep = ",", stringsAsFactors=FALSE)


TeamSummary <- read.csv(file = "Assets/Data/TeamSummary.csv", header = TRUE, sep = ",", stringsAsFactors=FALSE)
ShirtNo <- read.csv(file = "Assets/Data/ShirtNo.csv", header = TRUE, sep = ",", stringsAsFactors=FALSE)
Carries <- read.csv(file = "Assets/Data/Carries.csv", header = TRUE, sep = ",", stringsAsFactors=FALSE)

AttackC <- read.csv(file = "Assets/Data/AttackC.csv", header = TRUE, sep = ",", stringsAsFactors=FALSE)
AttackQ <- read.csv(file = "Assets/Data/AttackQ.csv", header = TRUE, sep = ",", stringsAsFactors=FALSE)

Defence <- read.csv(file = "Assets/Data/Defence.csv", header = TRUE, sep = ",", stringsAsFactors=FALSE)
DefenceTotals <- read.csv(file = "Assets/Data/DefenceTotals.csv", header = TRUE, sep = ",", stringsAsFactors=FALSE)

TacklesMade <- read.csv(file = "Assets/Data/TacklesMade.csv", header = TRUE, sep = ",", stringsAsFactors=FALSE)
TacklesMissed <- read.csv(file = "Assets/Data/TacklesMissed.csv", header = TRUE, sep = ",", stringsAsFactors=FALSE)


# Kicks <- read_excel("C:/Users/ehaggart001/Desktop/R/RUGBY/Assets/Data/StadeFrancais.xlsx", sheet = "Kicks")
# Pens <- read_excel("C:/Users/ehaggart001/Desktop/R/RUGBY/Assets/Data/StadeFrancais.xlsx", sheet = "Pens")
# Turrnovers <- read_excel("C:/Users/ehaggart001/Desktop/R/RUGBY/Assets/Data/StadeFrancais.xlsx", sheet = "Turnovers")
# Handling <- read_excel("C:/Users/ehaggart001/Desktop/R/RUGBY/Assets/Data/StadeFrancais.xlsx", sheet = "Handling")

PriorPlayer <- read.csv(file = "Assets/Data/PriorPlayer.csv", header = TRUE, sep = ",", stringsAsFactors=FALSE)


######

#playerprofiling


CarriesPlayer <- Carries %>% filter(Type == "Total")

joinner <- merge(DefenceTotals, CarriesPlayer, by = "Player")
joinner <- merge(TeamOverview, joinner, by = "Player", all = TRUE)

joinner <- merge(PriorPlayer, joinner, by = "Player", all = TRUE)

saveRDS(joinner, file = "playerprofile.rds")

######
