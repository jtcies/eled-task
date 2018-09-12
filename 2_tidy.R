library(readxl)
library(here)
library(tidyverse)
library(jtcr)



dat <- read_excel(here::here("data/Research Manager Task-2.xlsx"), skip = 1) %>% 
  fix_names()

names(dat)[9:20] <- c(
  "ela_school_2011_2012",
  "ela_district_2011_2012",
  "ela_school_2012_2013",
  "ela_district_2012_2013",
  "ela_school_2013_2014",
  "ela_district_2013_2014",
  "math_school_2011_2012",
  "math_district_2011_2012",
  "math_school_2012_2013",
  "math_district_2012_2013",
  "math_school_2013_2014",
  "math_district_2013_2014"
)
# remove first row
dat <- dat[-1, ]

# tidy
ela_dat <- select(dat, 1:8, starts_with("ela")) %>% 
  mutate(subject = "ela")
math_dat <- select(dat, 1:8, starts_with("math")) %>% 
  mutate(subject = "math")

names(ela_dat) <- gsub("ela_", "", names(ela_dat))
names(math_dat) <- gsub("math_", "", names(math_dat))

tidy_subj <- bind_rows(ela_dat, math_dat)

yr_1112 <- select(tidy_subj, 1:8, subject, contains("2011_2012")) %>% 
  mutate(year = "2011-2012")

names(yr_1112) <- gsub("_2011_2012", "", names(yr_1112))

yr_1213 <- select(tidy_subj, 1:8, subject, contains("2012_2013")) %>% 
  mutate(year = "2012-2013")

names(yr_1213) <- gsub("_2012_2013", "", names(yr_1213))

yr_1314 <- select(tidy_subj, 1:8, subject, contains("2013_2014")) %>% 
  mutate(year = "2013-2014")

names(yr_1314) <- gsub("_2013_2014", "", names(yr_1314))

tidy_dat <- bind_rows(yr_1112, yr_1213, yr_1314)

write_csv(tidy_dat, here::here("data/tidied_data.csv"))