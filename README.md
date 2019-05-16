# Project2-ETL
ETL project by Clara Eberhardy and Andrew Bonwick

# Combining Fatal Traffic Data from France and Canada.

## Goal: 
Normalize and combine data from multiple sources to aid in comparison globally, not just locally.

## Data Sources: 
Canadian Traffic Accidents:
	https://www.kaggle.com/tbsteal/canadian-car-accidents-19942014
	A single CSV file containing all traffic accidents from 1999-2014
French Traffic Accidents:
	https://www.kaggle.com/ahmedlahlou/accidents-in-france-from-2005-to-2016
	4 CSV files containing all traffic accidents from 2005 to 2016

### Source Transformations:
Each source uses their own codes and methods to track accident data.  The canadian source combined all the data into one file while the french source separated the various accident factors into separate files that required merging.

## Transformation Method:
* Compare available data fields for each set
* Decide which data to keep and which are unnecessary
* accident_id, source, year, day, month, hour, weather, surface_condition, fatality, safety_device, vehicle_category
* Decide on a normalized coding for each set
* Using real words for surface condition and weather for readability
* Add 2000 to all the years to match a 4 digit year coding
* Filter each set to only look at fatal accidents involving light duty vehicles (cars)
	
### French Data:
1. The first file contained the overall characteristics of each accident
	- Drop the extra columns and translate the others to english
	- The canadian file only reveals the hour of the accident instead of the full time, drop the minutes from the file to match Canada’s formatting
	- The file uses a number code to describe the weather.  Translate the code into human readable words that will match the canadian data.
	- Check for null values and fill them with ‘Other’
2. The second file deals with the location of each accident
	- We dropped most of the data from this file to save time in translating the files
	- The road surface condition codes needed to be translated into human readable words to match the canadian data
	- Check for null values and fill them with ‘Other’
3. The third file contains the data of each participant in each collision.  It includes their injury status, position relative to each vehicle and more
	- We decided to only look at fatal accidents so we set people with fatal injury to 1 and everyone else’s injury level to 0.  We filtered out every accident without a fatal injury. We also summed up all the deaths in each accident to find out the total number of fatalities per accident.
	- We also decided to look at safety device usage (seat belts, helmets, child seats).  We translated the codes into these categories: safety devices used, safety device not used, or usage unknown.  We then flattened the person data for each collision to find out whether each collision had everyone using all their safety devices, anyone not using a safety device or, if safety usage was unknown.
4.  The fourth file contains all the vehicles involved in each collision and their data.
	- We decided to only look at accidents involving light duty vehicles as their characteristics matched across both countries, therefore we cleaned up the coding to only look at the cars and then filter the data to only accidents involving at least one car.
	- The 4 cleaned and translated files needed to be merged, then the non fatal accidents were dropped along with accidents that did not involve light duty vehicles.
	- Finally the CSV files needed to be shortened from the very large files to much smaller files so each file was truncated to just 2016 data for uploading.  Either the original files or the sm_files can be used in the final project.

### Canadian Data:
1. For the Canadian accident data, there was only one file included. This file contains 22 different columns which have collision level data, person level data, and vehicle level data.
	- We shortened the dataset to only include accidents after 2011.
	- We dropped many of the columns from the Canadian data, leaving only the columns which we could combine with the filtered French dataset.
	- We re-coded many of the columns in the Canadian data to match the catagories which we used for the French data.

## Load Decision:
We decided to put our combined data into a MySQL database.  The data structure lent itself well to a table format as the original data were in table formatting.  We also found that with the time constraints the best method was MySQL.  Our resulting accident table can be used to compare data from both Canada and France.  With more time, we would like to add accident traffic data from additional countries.  Also, we could look at some of the data that we dropped for brevity to normalize their usage for comparison as well.

### Conclusion:

With both datasets combined we  can now compare rates  of accidents and compare conditions in which most fatalities occur.  With more time, we could include datasets from additional countries to start looking at global accident trends with the goal of seeing if some countries have policies that improve safety.
