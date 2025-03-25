# Installing packages

install.packages("conflicted")
install.packages("tidyverse")
install.packages("janitor")
install.packages("lubridate")
install.packages("readxl")

# Enabling packages

library(conflicted)
library(tidyverse)
library(janitor)
library(lubridate)
library(readxl)

# Importing 12 data sets from my PC into R

bike1 <- read_excel("E:\\divvy_trip_data\\cleaned_data\\202301-divvy-tripdata.xlsx")
bike2 <- read_excel("E:\\divvy_trip_data\\cleaned_data\\202302-divvy-tripdata.xlsx")
bike3 <- read_excel("E:\\divvy_trip_data\\cleaned_data\\202303-divvy-tripdata.xlsx")
bike4 <- read_excel("E:\\divvy_trip_data\\cleaned_data\\202304-divvy-tripdata.xlsx")
bike5 <- read_excel("E:\\divvy_trip_data\\cleaned_data\\202305-divvy-tripdata.xlsx")
bike6 <- read_excel("E:\\divvy_trip_data\\cleaned_data\\202306-divvy-tripdata.xlsx")
bike7 <- read_excel("E:\\divvy_trip_data\\cleaned_data\\202307-divvy-tripdata.xlsx")
bike8 <- read_excel("E:\\divvy_trip_data\\cleaned_data\\202308-divvy-tripdata.xlsx")
bike9 <- read_excel("E:\\divvy_trip_data\\cleaned_data\\202309-divvy-tripdata.xlsx")
bike10 <- read_excel("E:\\divvy_trip_data\\cleaned_data\\202310-divvy-tripdata.xlsx")
bike11 <- read_excel("E:\\divvy_trip_data\\cleaned_data\\202311-divvy-tripdata.xlsx")
bike12 <- read_excel("E:\\divvy_trip_data\\cleaned_data\\202312-divvy-tripdata.xlsx")

# Consolidating and further cleaning the data

bike_total <- rbind(bike1, bike2, bike3, bike4, bike5, bike6, bike7, bike8, bike9, bike10, bike11, bike12)
bike_total <- janitor::remove_empty(bike_total, which = c("cols"))
bike_total <- janitor::remove_empty(bike_total, which = c("rows"))

# Using summary functions to check the readiness of the data

str(bike_total)
summary(bike_total)

# Calculating the time duration of each rental

bike_total$ride_length <- difftime(bike_total$ended_at, bike_total$started_at, units = "mins")
bike_total$ride_length <- as.numeric(bike_total$ride_length)

# Expansive analysis of the data

bike_total$day <- weekdays(bike_total$started_at)
bike_total$month <- months(bike_total$started_at)
bike_total$year <- year(bike_total$started_at)

# Reviewing what we have

View(bike_total)

# Filtering out ride_length due to incosistencies

bike_total <- filter(bike_total, bike_total$ride_length > 0)

# Obtaining important data for further analysis

mean_member_casual <- aggregate(ride_length~member_casual, bike_total, mean)
max_member_casual <- aggregate(ride_length~member_casual, bike_total, max)
min_member_casual <- aggregate(ride_length~member_casual, bike_total, min)
mean_member_casual
max_member_casual
min_member_casual

# Export CSV

write.csv(bike_total, "bike_total_cleaned_case_1_data.csv")