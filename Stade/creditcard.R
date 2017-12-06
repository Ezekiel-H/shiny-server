library(tidyverse)
library(readr)


setwd("C:/Users/Ezekiel/Desktop/R/creditcardfraud")

###----------------------------------------###

###--------------Read in data--------------###

creditcard <- read_csv("C:/Users/Ezekiel/Desktop/R/creditcardfraud/Assets/creditcard.csv")

##lets have a look at the data
as_tibble(creditcard)

#V1 - V28 and three catagories: Time, Amount class

as_tibble(creditcard %>% select(Time, Amount, Class))


normalize <- function(x) {
  num <- x - min(x)
  denom <- max(x) - min(x)
  return (num/denom)
}

CreditCardNormalized <- as.data.frame(lapply(creditcard, normalize))
