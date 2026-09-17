library(tidyverse)
library(ggrepel)
library(stringr)
library(lubridate)

setwd("/Users/patrickchen/Desktop/650_finalproject")

#Purpose: The latest version (Version 13) of the LinkedIn Job Postings (2023-2024) data is missing many 2023 observations
#that were initially included in the earlier versions of the data set. This R script merges different versions for more complete data set.


#load v01 and v10, they represent the first and last run of the first period June 2023 - November 2023
#https://www.kaggle.com/datasets/arshkon/linkedin-job-postings/versions/1
#https://www.kaggle.com/datasets/arshkon/linkedin-job-postings/versions/10

v01_postings <- read.csv(file = "v01_postings.csv") 

v01_cleaned_postings <- v01_postings %>% mutate(original_listed_time = as_datetime(original_listed_time / 1000)) %>%  
  mutate(closed_time = as_datetime(closed_time / 1000)) %>% 
  mutate(listed_time = as_datetime(listed_time / 1000)) %>% arrange(original_listed_time)

v10_postings <- read.csv(file = "v10_postings.csv") 

v10_cleaned_postings <- v10_postings %>% mutate(original_listed_time = as_datetime(original_listed_time / 1000)) %>%  
  mutate(closed_time = as_datetime(closed_time / 1000)) %>% 
  mutate(listed_time = as_datetime(listed_time / 1000)) %>% arrange(original_listed_time)


#load v11 and v13, they represent the first and last run of the second period December 2023 - April 2024
#https://www.kaggle.com/datasets/arshkon/linkedin-job-postings/versions/11
#https://www.kaggle.com/datasets/arshkon/linkedin-job-postings

v11_postings <- read.csv(file = "v11_postings.csv") 

v11_cleaned_postings <- v11_postings %>% mutate(original_listed_time = as_datetime(original_listed_time / 1000)) %>%  
  mutate(closed_time = as_datetime(closed_time / 1000)) %>% 
  mutate(listed_time = as_datetime(listed_time / 1000)) %>% arrange(original_listed_time)

v13_postings <- read.csv(file = "v13_postings.csv") 

v13_cleaned_postings <- v13_postings %>% mutate(original_listed_time = as_datetime(original_listed_time / 1000)) %>%  
  mutate(closed_time = as_datetime(closed_time / 1000)) %>% 
  mutate(listed_time = as_datetime(listed_time / 1000)) %>% arrange(original_listed_time)


#check if any rows in the start of period are missing from the end
v1_v10_dropped <- anti_join(v01_cleaned_postings, v10_cleaned_postings, by = "job_id")

v11_v13_dropped <- anti_join(v11_cleaned_postings, v13_cleaned_postings, by = "job_id")


#join v10, v1_v10_dropped, v13, v11_v13_dropped
merged <- bind_rows(v10_cleaned_postings, v1_v10_dropped, v13_cleaned_postings, v11_v13_dropped)

merged_check <- merged %>% group_by(job_id) %>% summarize(count = n())

merged_cleaned <- merged %>% mutate(original_listed_month = month(original_listed_time))  %>% 
  mutate(original_listed_year = year(original_listed_time)) %>% filter(!is.na(original_listed_month)) %>% arrange(original_listed_time)

#write csv files
write.csv(merged_cleaned, "merged_postings.csv", row.names = FALSE)


#MAPPING FILES
#Purpose: Perform similar procedure with mapping files. 
#Source: All versions of mapping files come from different versions of Kaggle dataset linked above.

#merge companies.csv, v1 to v10 is the same, so keep v10, v11 to v13 is the same, so keep v13.
#Keep unique rows by merging v13 with rows that are in v10 but not v13
v10_companies <- read.csv("v10_companies.csv")
v13_companies <- read.csv("v13_companies.csv")
v10_v13_companies_dropped <- anti_join(v10_companies, v13_companies, by = "company_id")

merged_companies <- bind_rows(v10_v13_companies_dropped, v13_companies)
merged_companies_check <- merged_companies %>% group_by(company_id) %>% summarize(count = n())

write.csv(merged_companies, "merged_companies.csv", row.names = FALSE)


#industries.csv, v1 is completely different mapping, do don't use and keep v10, v11 to v13 is the same, so keep v13.
#Keep unique rows by merging v13 with rows that are in v10 but not v13
v10_industries <- read.csv("v10_industries.csv")
v13_industries <- read.csv("v13_industries.csv")
v10_v13_industries_dropped <- anti_join(v10_industries, v13_industries, by = "industry_id")

merged_industries <- bind_rows(v10_v13_industries_dropped, v13_industries)
merged_industries_check <- merged_industries %>% group_by(industry_id) %>% summarize(count = n())

write.csv(merged_industries, "merged_industries.csv", row.names = FALSE)


#merge job_industries.csv, v10 contains all of v1 rows, keep v10. v11 to v13 is the same, so keep v13.
#Keep unique rows by merging v10 with v13
v10_job_industries <- read.csv("v10_job_industries.csv")
v13_job_industries <- read.csv("v13_job_industries.csv")

merged_job_industries <- bind_rows(v10_job_industries, v13_job_industries)
merged_job_industries_check <- merged_job_industries %>% group_by(job_id,industry_id) %>% summarize(count = n())

write.csv(merged_job_industries, "merged_job_industries.csv", row.names = FALSE)


#merge job_skills.csv, v10 contains all of v1 rows, keep v10. v11 to v13 is the same, so keep v13.
#Keep unique rows by merging v10 with v13, one job can have multiple skills
v10_job_skills <- read.csv("v10_job_skills.csv")
v13_job_skills <- read.csv("v13_job_skills.csv")

merged_job_skills <- bind_rows(v10_job_skills, v13_job_skills)

write.csv(merged_job_skills, "merged_job_skills.csv", row.names = FALSE)


#merge skills.csv - no v1, all other version are the same, just keep original in v13
v13_skills <- read.csv("v13_skills.csv")

write.csv(v13_skills, "merged_skills.csv", row.names = FALSE)


