# Scripts for cyber-espionage journal article
# Autor: Alex Petros 
library(tidyverse)
library(ggthemes)
library(xtable)
library(clipr)
library(lubridate)

# comment this line if your file is elsewhere
setwd('~/Documents/journal/src/data/')

# https://www.cfr.org/interactive/cyber-operations
cfr_data <- read_csv('./cyber-operations-incidents.csv') 

# added some useful columns, cleaned data, and removed sources
cyber_incidents <- cfr_data %>% 
  mutate(us_target=if_else(grepl("United States", Victims), TRUE, FALSE)) %>% 
  mutate(has_response=!is.na(Response)) %>% 
  mutate(Response=str_extract(Response, '\\w+\\b')) %>% 
  select(-Sources_1, -Sources_2, -Sources_3) %>% 
  replace_na(list(Type = "Undefined"))

# select cyber-incidents aginst the US
us_targeted <- cyber_incidents %>% 
  filter(us_target == TRUE) %>%
  select(-us_target)

# count of how often states respond to cyber-incidents by type
# swap in us_targeted for for US-only count
response_stats <- cyber_incidents %>% 
  filter(Type !='Undefined' & !is.na(Sponsor) & !is.na(Victims)) %>% 
  filter(Date > as.Date('2010-01-01')) %>% 
  # group_by(Type) %>% 
  summarize(num_incidents = n(), 
            num_responses = sum(has_response==TRUE), 
            response_pct = mean(has_response==TRUE)*100) %>% 
  ungroup() %>% 
  arrange(desc(response_pct))

response_stats

# print the table and save it as an xtable
response_stats
export_response_stats <- response_stats %>% 
  rename('Incidents' = num_incidents,
         'Public responses' = num_responses,
         'Response %' = response_pct) %>% 
  xtable()
write_clip(print(export_response_stats, include.rownames = FALSE))




# plot workspace
ggplot(data=filter(us_targeted, !is.na(Response))) +
  geom_bar(mapping=aes(x=Type, fill=Response))

# ex_table <- filter(us_targeted, Response == "Criminal")
# ex_table
