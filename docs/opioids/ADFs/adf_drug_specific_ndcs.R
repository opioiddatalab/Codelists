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

path <- str_replace(rstudioapi::getActiveDocumentContext()$path,"adf_drug_specific_ndcs.R","")

#---------------------------------------#
# Read files
#---------------------------------------#

all_adfs <- read_csv(str_c(path,"ADF_NDCs.csv")) %>% 
  mutate_if(is.character, str_to_lower) %>% 
  set_names(tolower(names(.))) %>% 
  mutate(ndc = str_remove_all(ndc, "'"),
         ndc = str_c("'",ndc,"'")) 
names(all_adfs) <- tolower(names(all_adfs))

folders <- c("Arymo_ER", "Embeda", "Hysingla_ER", "MorphaBond_ER", 
             "OxyContin", "RoxyBond", "Targiniq", "Troxyca_ER", "Xtampza_ER")
drugs <- c("arymo", "embeda", "hysingla", "morphabond", 
             "oxycontin|oxycodone", "roxybond", "targiniq", "troxyca", "xtampza")

purrr::walk2(.x = folders,
             .y = drugs,
             .f = ~ {
               x <- all_adfs %>% 
                 filter(str_detect(drug_name, .y)) %>% 
                 mutate_if(is.character, str_to_title) %>% 
                 mutate(ingredients = if_else(drug_name == "Oxycodone Hcl Er", 
                                              "Oxycodone Hydrochloride", ingredients),
                        strength_uom = str_to_upper(strength_uom),
                        ir_er = str_to_upper(ir_er))
               names(x) <- toupper(names(x))
               pattern <- str_replace(.y, "\\W.*", "")
               write_csv(x, str_c(path,glue("{.x}/{pattern}_NDCs.csv")))
             })



