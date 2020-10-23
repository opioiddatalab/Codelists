#---------------------------------------#
#' Project: FDA T1 Codelists
#' Purpose: Pull site-specific cancer lists
#---------------------------------------#

#---------------------------------------#
# Initialize
#---------------------------------------#

library(tidyverse)
library(rstudioapi)   
library(here)
library(glue)

path <- str_replace(rstudioapi::getActiveDocumentContext()$path,"cancer_type_icd.R","") %>% 
  str_remove(., "~")

#---------------------------------------#
# Read files
#---------------------------------------#

all_cancer <- read_csv(here(path,"cancer_dx_all_icd.csv")) %>% 
  mutate(icd_cm=str_c("'",icd_cm,"'"))
  
names(all_cancer) <- tolower(names(all_cancer))

type <- c("head_neck", "gi", "colorectal", "lung", "bone",
             "melanoma", "breast", "uterine_cervical", "other_female", "male_genital",
          "urinary", "brain", "lymph_hem")

purrr::walk(.x = type,
            .f = ~ {
              type <- sym(str_c(.x, "_cancer"))
              x <- all_cancer %>% 
                filter(!!type==1) %>% 
                select(icd_cm, ver) 
              write_csv(x, here(path,glue("cancer_type/{type}_dx_icd.csv")))
            })


write_csv(all_cancer, here(path,"cancer_dx_all_icd.csv"))

malignant_cancer <- all_cancer %>% 
  filter(nonmelanoma_skin_cancer==0 & carcinoma_in_situ_cancer==0 & 
           benign_cancer==0 & uncertain_unspecified_cancer==0) %>% 
  select(icd_cm, ver)

write_csv(malignant_cancer, here(path,"malignant_cancer_dx_icd.csv"))

