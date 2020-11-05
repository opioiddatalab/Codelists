#---------------------------------------#
#' Project: FDA T1 Codelists
#' Purpose: Pull drug-specific NDC lists
#---------------------------------------#

#---------------------------------------#
# Initialize
#---------------------------------------#

library(tidyverse)
library(rstudioapi)   
library(here)
library(glue)

path <- str_replace(rstudioapi::getActiveDocumentContext()$path,"all_opioid_drug_specific_ndcs.R","") 

#---------------------------------------#
# Read files
#---------------------------------------#

all_opioids <- read_csv(str_c(path,"opioid_NDCs.csv")) %>% 
  mutate_if(is.character, str_to_lower) %>% 
  select(ndc, drug_name, generic_name, opioid_ingredient1, opioid_ingredient2,
         strength, strength_uom, manufacturer, status)

#write_csv(all_opioids, str_c(path,"opioid_NDCs.csv"))

ingredients <- c(list.dirs(path = path, full.names = F))[-1]

drugs <- purrr::map(.x = ingredients,
                      .f = ~ {
                        x <- all_opioids %>% 
                          filter(str_detect(opioid_ingredient1, .x))}) %>% 
  set_names(ingredients)

purrr::walk(.x = ingredients,
            .f = ~ {
              x <- all_opioids %>% 
                filter(str_detect(opioid_ingredient1, .x)) 
              write_csv(x, str_c(path,glue("/{.x}/{.x}_NDCs.csv")))
            })



