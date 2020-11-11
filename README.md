# Air Pollution in Seoul (updating)
## Background
* Data obtained on the website Kaggle
  * _Air Pollution in Seoul_. https://www.kaggle.com/bappekim/air-pollution-in-seoul
* Seoul Metropolitan Government (SMG) has collected and provided many public data including air pollution information. There are several stations measuring air pollution in South Korea including Seoul.

## Data
* The 25 mearing stations in Seoul has measured air pollutants (SO<sub>2</sub>, NO<sub>2</sub>, O<sub>3</sub>, CO, PM<sub>10</sub>, PM<sub>2.5</sub>) hourly
  * Used data by 8 hours since I can’t run the full dataset in my computer
* Datasets from 12 AM on 1 January 2017 to 11 PM on 31 December 2019
* Every station has its own code (101 to 125)
* Address, latitude, and longitude indicate where the stations are located
* **Variables:**
  * Measurement date: Measurement date and time
  * Station code: Measuring station code
  * Address: Address of measuring station
  * Latitude: Latitude of address
  * Longitude: Longitude of address
  * SO<sub>2</sub>: Sulfur dioxide
  * NO<sub>2</sub>: Nitrogen dioxide
  * O<sub>3</sub>: Ozone
  * CO: Carbon monoxide
  * PM<sub>10</sub>: Particulate matter
  * PM<sub>2.5</sub>: Particulate matter

## Problem
* Relationship between 4 air pollutants and PMs
* How the 4 air pollutants are related to the location (latitude, longitude, address, or stations code) and time (measurement date)

## Model
* Multivariate Regression Model 1
  * Responses: Measurement date, Station code, Latitude, Longitude
  * Predictors: SO<sub>2</sub>, NO<sub>2</sub>, O<sub>3</sub>, CO, PM<sub>10</sub>, PM<sub>2.5</sub>
* Multivariate Regression Model 2
  * Responses: PM<sub>10</sub>, PM<sub>2.5</sub>
  * Predictors: SO<sub>2</sub>, NO<sub>2</sub>, O<sub>3</sub>, CO

## Method
* Exploratory Data Analysis
  * Plot each of 4 air pollutants vs. PM<sub>10</sub> and PM<sub>2.5</sub>
* Clustering
  * Use weekly data since I couldn’t run the full dataset in my computer
  * Focus on SO<sub>2</sub>, NO<sub>2</sub>, O<sub>3</sub>, CO pollutants

## Remarkable Plots
* Figure 3: SO<sub>2</sub> vs. PM<sub>10</sub> & PM<sub>2.5</sub>
* Figure 4: NO<sub>2</sub> vs. PM<sub>10</sub> & PM<sub>2.5</sub>
* Figure 4: O<sub>3</sub> vs. PM<sub>10</sub> & PM<sub>2.5</sub>
* Figure 4: CO vs. PM<sub>10</sub> & PM<sub>2.5</sub>

Figure 8: Average Silhouettes under 3, 5, and 7 Clusters

## Conclusion
* Only NO<sub>2</sub> out of other pollutants and PMs was positively related to latitude
  * NO<sub>2</sub> values were recorded higher in northern counties
* SO<sub>2</sub> was negatively related to PM<sub>10</sub> and PM<sub>2.5</sub> values
  * When SO<sub>2</sub> values were high, values of PM<sub>10</sub> and PM<sub>2.5</sub> were recorded low
* 51 datasets have very high PM<sub>10</sub> values higher than approximately 2,000
  * According to the code information, four stations (116, 117, 121, and 122) are located southern or southwestern part of Seoul

## Discussion
* One county has only one measuring station
  * but the size, population, and number of factories are very various and random
* Counties with high density of population and factories may have higher air pollutants values than other counties even though they have fewer population and factories in reality
* More information of predictors/factors can improve analyzing the air pollution data
* Rain sometimes decreases the air pollution measurements
  * Better to analyze data collected in the same condition of weather
