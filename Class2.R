# Program to create a test R script



#x <- 5
#print(x)
#cat("The value of x is", x, "\n")

#y <- 6

#z <- x + y
#cat("The value of z is", z, "\n")




rm(list = ls())
library(plyr)
library(dplyr)
library(lubridate)

d.in <- read.csv("sample_patient_dataset.csv", header = TRUE)
# 
#d.in <- read.table("~/Desktop/CLASS 2/patient_dataset.csv", header = TRUE, sep = "\t")

# covert date of birth into date-time
#d.new <- mutate(d.in, new_dob = mdy(dob))
#d.in <- mutate(d.in, dob = mdy(dob))

#convert dob and hosp admission into date-time
d.in <- mutate(d.in, dob = mdy(dob), hosp_admission = mdy(hosp_admission))
#d.in <- mutate(d.in, dob = mdy(dob, tz = "Chicago/America"), hosp_admission = mdy(hosp_admission))

#calculate age
d.in <- mutate(d.in, age_at_admit = interval(dob, hosp_admission)/dyears(1))

# choose male,
d.males <- filter(d.in, gender == "M")

#choose outcome and exposure
d.cohort <- select(d.in, c("age_at_admit", "had_cardiac_arrests"))



d.cohort <- d.in %>%
  mutate(dob = mdy(dob), hosp_admission = mdy(hosp_admission)) %>%
  mutate(age_at_admit = interval(dob, hosp_admission)/dyears(1)) %>%
  select(c("age_at_admit","had_cardiac_arrests"))

mean_age_ca <- d.cohort %>%
  filter(had_cardiac_arrests == 1) %>%
  select("age_at_admit") %>%
  unlist() %>%
  sd()
