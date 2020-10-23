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

path <- str_replace(rstudioapi::getActiveDocumentContext()$path,"adf_drug_specific_ndcs.R","") %>% 
  str_remove(., "~")

#---------------------------------------#
# Read files
#---------------------------------------#

all_adfs <- read_csv(here(path,"ADF_NDCs.csv")) %>% 
  mutate_if(is.character, str_to_lower) 
names(all_adfs) <- tolower(names(all_adfs))

folders <- c("Arymo_ER", "Embeda", "Hysingla_ER", "MorphaBond_ER", "Oxaydo",
             "OxyContin", "RoxyBond", "Targiniq", "Troxyca_ER", "Xtampza_ER")
drugs <- c("arymo", "embeda", "hysingla", "morphabond", "oxaydo|oxecta", 
             "oxycontin|oxycodone", "roxybond", "targiniq", "troxyca", "xtampza")

purrr::walk2(.x = folders,
             .y = drugs,
             .f = ~ {
               x <- all_adfs %>% 
                 filter(str_detect(drug_name, .y)) %>% 
                 mutate_if(is.character, str_to_title) %>% 
                 mutate(strength_unit_of_measure = str_to_upper(strength_unit_of_measure))
               names(x) <- toupper(names(x))
               pattern <- str_replace(.y, "\\W.*", "")
               write_csv(x, here(path,glue("/{.x}/{pattern}_NDCs.csv")))
             })



