---
title: "Tidy US election and census data"
author: "Erik Ländström"
date: '2020-01-29'
output: 
  html_document:
    code_folding: show
    toc: yes
    toc_float: yes
    toc_depth: 4
    keep_md: yes
    theme: cerulean
    number_sections: yes
---



This is my project for testing machine learning techniques in order to predict US election outcomes from census data.

This markdown is mainly for tidying data. 

# Load libraries


```r
library(tidyverse)
library(knitr)
library(kableExtra)
```

## Load functions


```r
source("functions/table_styling.R")
```


# Read US census data

Read US census data from 2015 (data from [www.kaggle.com](https://www.kaggle.com/muonneutrino/us-census-demographic-data)).


```r
census_data <- read_csv("data/acs2015_county_data.csv")
```

```
## Parsed with column specification:
## cols(
##   .default = col_double(),
##   State = col_character(),
##   County = col_character()
## )
```

```
## See spec(...) for full column specifications.
```

```r
# Print first rows
head(census_data) %>% 
  table_styling(scroll_box = FALSE)
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:100%; overflow-x: scroll; width:100%; "><table class="table table-striped" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> CensusId </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> State </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> County </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> TotalPop </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Men </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Women </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Hispanic </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> White </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Black </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Native </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Asian </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Pacific </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Citizen </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Income </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> IncomeErr </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> IncomePerCap </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> IncomePerCapErr </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Poverty </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> ChildPoverty </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Professional </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Service </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Office </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Construction </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Production </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Drive </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Carpool </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Transit </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Walk </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> OtherTransp </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> WorkAtHome </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> MeanCommute </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Employed </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> PrivateWork </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> PublicWork </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> SelfEmployed </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> FamilyWork </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;"> Unemployment </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1001 </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> Autauga </td>
   <td style="text-align:right;"> 55221 </td>
   <td style="text-align:right;"> 26745 </td>
   <td style="text-align:right;"> 28476 </td>
   <td style="text-align:right;"> 2.6 </td>
   <td style="text-align:right;"> 75.8 </td>
   <td style="text-align:right;"> 18.5 </td>
   <td style="text-align:right;"> 0.4 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 40725 </td>
   <td style="text-align:right;"> 51281 </td>
   <td style="text-align:right;"> 2391 </td>
   <td style="text-align:right;"> 24974 </td>
   <td style="text-align:right;"> 1080 </td>
   <td style="text-align:right;"> 12.9 </td>
   <td style="text-align:right;"> 18.6 </td>
   <td style="text-align:right;"> 33.2 </td>
   <td style="text-align:right;"> 17.0 </td>
   <td style="text-align:right;"> 24.2 </td>
   <td style="text-align:right;"> 8.6 </td>
   <td style="text-align:right;"> 17.1 </td>
   <td style="text-align:right;"> 87.5 </td>
   <td style="text-align:right;"> 8.8 </td>
   <td style="text-align:right;"> 0.1 </td>
   <td style="text-align:right;"> 0.5 </td>
   <td style="text-align:right;"> 1.3 </td>
   <td style="text-align:right;"> 1.8 </td>
   <td style="text-align:right;"> 26.5 </td>
   <td style="text-align:right;"> 23986 </td>
   <td style="text-align:right;"> 73.6 </td>
   <td style="text-align:right;"> 20.9 </td>
   <td style="text-align:right;"> 5.5 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 7.6 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1003 </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> Baldwin </td>
   <td style="text-align:right;"> 195121 </td>
   <td style="text-align:right;"> 95314 </td>
   <td style="text-align:right;"> 99807 </td>
   <td style="text-align:right;"> 4.5 </td>
   <td style="text-align:right;"> 83.1 </td>
   <td style="text-align:right;"> 9.5 </td>
   <td style="text-align:right;"> 0.6 </td>
   <td style="text-align:right;"> 0.7 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 147695 </td>
   <td style="text-align:right;"> 50254 </td>
   <td style="text-align:right;"> 1263 </td>
   <td style="text-align:right;"> 27317 </td>
   <td style="text-align:right;"> 711 </td>
   <td style="text-align:right;"> 13.4 </td>
   <td style="text-align:right;"> 19.2 </td>
   <td style="text-align:right;"> 33.1 </td>
   <td style="text-align:right;"> 17.7 </td>
   <td style="text-align:right;"> 27.1 </td>
   <td style="text-align:right;"> 10.8 </td>
   <td style="text-align:right;"> 11.2 </td>
   <td style="text-align:right;"> 84.7 </td>
   <td style="text-align:right;"> 8.8 </td>
   <td style="text-align:right;"> 0.1 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1.4 </td>
   <td style="text-align:right;"> 3.9 </td>
   <td style="text-align:right;"> 26.4 </td>
   <td style="text-align:right;"> 85953 </td>
   <td style="text-align:right;"> 81.5 </td>
   <td style="text-align:right;"> 12.3 </td>
   <td style="text-align:right;"> 5.8 </td>
   <td style="text-align:right;"> 0.4 </td>
   <td style="text-align:right;"> 7.5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1005 </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> Barbour </td>
   <td style="text-align:right;"> 26932 </td>
   <td style="text-align:right;"> 14497 </td>
   <td style="text-align:right;"> 12435 </td>
   <td style="text-align:right;"> 4.6 </td>
   <td style="text-align:right;"> 46.2 </td>
   <td style="text-align:right;"> 46.7 </td>
   <td style="text-align:right;"> 0.2 </td>
   <td style="text-align:right;"> 0.4 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 20714 </td>
   <td style="text-align:right;"> 32964 </td>
   <td style="text-align:right;"> 2973 </td>
   <td style="text-align:right;"> 16824 </td>
   <td style="text-align:right;"> 798 </td>
   <td style="text-align:right;"> 26.7 </td>
   <td style="text-align:right;"> 45.3 </td>
   <td style="text-align:right;"> 26.8 </td>
   <td style="text-align:right;"> 16.1 </td>
   <td style="text-align:right;"> 23.1 </td>
   <td style="text-align:right;"> 10.8 </td>
   <td style="text-align:right;"> 23.1 </td>
   <td style="text-align:right;"> 83.8 </td>
   <td style="text-align:right;"> 10.9 </td>
   <td style="text-align:right;"> 0.4 </td>
   <td style="text-align:right;"> 1.8 </td>
   <td style="text-align:right;"> 1.5 </td>
   <td style="text-align:right;"> 1.6 </td>
   <td style="text-align:right;"> 24.1 </td>
   <td style="text-align:right;"> 8597 </td>
   <td style="text-align:right;"> 71.8 </td>
   <td style="text-align:right;"> 20.8 </td>
   <td style="text-align:right;"> 7.3 </td>
   <td style="text-align:right;"> 0.1 </td>
   <td style="text-align:right;"> 17.6 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1007 </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> Bibb </td>
   <td style="text-align:right;"> 22604 </td>
   <td style="text-align:right;"> 12073 </td>
   <td style="text-align:right;"> 10531 </td>
   <td style="text-align:right;"> 2.2 </td>
   <td style="text-align:right;"> 74.5 </td>
   <td style="text-align:right;"> 21.4 </td>
   <td style="text-align:right;"> 0.4 </td>
   <td style="text-align:right;"> 0.1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 17495 </td>
   <td style="text-align:right;"> 38678 </td>
   <td style="text-align:right;"> 3995 </td>
   <td style="text-align:right;"> 18431 </td>
   <td style="text-align:right;"> 1618 </td>
   <td style="text-align:right;"> 16.8 </td>
   <td style="text-align:right;"> 27.9 </td>
   <td style="text-align:right;"> 21.5 </td>
   <td style="text-align:right;"> 17.9 </td>
   <td style="text-align:right;"> 17.8 </td>
   <td style="text-align:right;"> 19.0 </td>
   <td style="text-align:right;"> 23.7 </td>
   <td style="text-align:right;"> 83.2 </td>
   <td style="text-align:right;"> 13.5 </td>
   <td style="text-align:right;"> 0.5 </td>
   <td style="text-align:right;"> 0.6 </td>
   <td style="text-align:right;"> 1.5 </td>
   <td style="text-align:right;"> 0.7 </td>
   <td style="text-align:right;"> 28.8 </td>
   <td style="text-align:right;"> 8294 </td>
   <td style="text-align:right;"> 76.8 </td>
   <td style="text-align:right;"> 16.1 </td>
   <td style="text-align:right;"> 6.7 </td>
   <td style="text-align:right;"> 0.4 </td>
   <td style="text-align:right;"> 8.3 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1009 </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> Blount </td>
   <td style="text-align:right;"> 57710 </td>
   <td style="text-align:right;"> 28512 </td>
   <td style="text-align:right;"> 29198 </td>
   <td style="text-align:right;"> 8.6 </td>
   <td style="text-align:right;"> 87.9 </td>
   <td style="text-align:right;"> 1.5 </td>
   <td style="text-align:right;"> 0.3 </td>
   <td style="text-align:right;"> 0.1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 42345 </td>
   <td style="text-align:right;"> 45813 </td>
   <td style="text-align:right;"> 3141 </td>
   <td style="text-align:right;"> 20532 </td>
   <td style="text-align:right;"> 708 </td>
   <td style="text-align:right;"> 16.7 </td>
   <td style="text-align:right;"> 27.2 </td>
   <td style="text-align:right;"> 28.5 </td>
   <td style="text-align:right;"> 14.1 </td>
   <td style="text-align:right;"> 23.9 </td>
   <td style="text-align:right;"> 13.5 </td>
   <td style="text-align:right;"> 19.9 </td>
   <td style="text-align:right;"> 84.9 </td>
   <td style="text-align:right;"> 11.2 </td>
   <td style="text-align:right;"> 0.4 </td>
   <td style="text-align:right;"> 0.9 </td>
   <td style="text-align:right;"> 0.4 </td>
   <td style="text-align:right;"> 2.3 </td>
   <td style="text-align:right;"> 34.9 </td>
   <td style="text-align:right;"> 22189 </td>
   <td style="text-align:right;"> 82.0 </td>
   <td style="text-align:right;"> 13.5 </td>
   <td style="text-align:right;"> 4.2 </td>
   <td style="text-align:right;"> 0.4 </td>
   <td style="text-align:right;"> 7.7 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1011 </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> Bullock </td>
   <td style="text-align:right;"> 10678 </td>
   <td style="text-align:right;"> 5660 </td>
   <td style="text-align:right;"> 5018 </td>
   <td style="text-align:right;"> 4.4 </td>
   <td style="text-align:right;"> 22.2 </td>
   <td style="text-align:right;"> 70.7 </td>
   <td style="text-align:right;"> 1.2 </td>
   <td style="text-align:right;"> 0.2 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 8057 </td>
   <td style="text-align:right;"> 31938 </td>
   <td style="text-align:right;"> 5884 </td>
   <td style="text-align:right;"> 17580 </td>
   <td style="text-align:right;"> 2055 </td>
   <td style="text-align:right;"> 24.6 </td>
   <td style="text-align:right;"> 38.4 </td>
   <td style="text-align:right;"> 18.8 </td>
   <td style="text-align:right;"> 15.0 </td>
   <td style="text-align:right;"> 19.7 </td>
   <td style="text-align:right;"> 20.1 </td>
   <td style="text-align:right;"> 26.4 </td>
   <td style="text-align:right;"> 74.9 </td>
   <td style="text-align:right;"> 14.9 </td>
   <td style="text-align:right;"> 0.7 </td>
   <td style="text-align:right;"> 5.0 </td>
   <td style="text-align:right;"> 1.7 </td>
   <td style="text-align:right;"> 2.8 </td>
   <td style="text-align:right;"> 27.5 </td>
   <td style="text-align:right;"> 3865 </td>
   <td style="text-align:right;"> 79.5 </td>
   <td style="text-align:right;"> 15.1 </td>
   <td style="text-align:right;"> 5.4 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 18.0 </td>
  </tr>
</tbody>
</table></div>

```r
# Get a glimpse of the data
dim(census_data)
```

```
## [1] 3220   37
```

```r
glimpse(census_data)
```

```
## Observations: 3,220
## Variables: 37
## $ CensusId        <dbl> 1001, 1003, 1005, 1007, 1009, 1011, 1013, 1015, 101...
## $ State           <chr> "Alabama", "Alabama", "Alabama", "Alabama", "Alabam...
## $ County          <chr> "Autauga", "Baldwin", "Barbour", "Bibb", "Blount", ...
## $ TotalPop        <dbl> 55221, 195121, 26932, 22604, 57710, 10678, 20354, 1...
## $ Men             <dbl> 26745, 95314, 14497, 12073, 28512, 5660, 9502, 5627...
## $ Women           <dbl> 28476, 99807, 12435, 10531, 29198, 5018, 10852, 603...
## $ Hispanic        <dbl> 2.6, 4.5, 4.6, 2.2, 8.6, 4.4, 1.2, 3.5, 0.4, 1.5, 7...
## $ White           <dbl> 75.8, 83.1, 46.2, 74.5, 87.9, 22.2, 53.3, 73.0, 57....
## $ Black           <dbl> 18.5, 9.5, 46.7, 21.4, 1.5, 70.7, 43.8, 20.3, 40.3,...
## $ Native          <dbl> 0.4, 0.6, 0.2, 0.4, 0.3, 1.2, 0.1, 0.2, 0.2, 0.6, 0...
## $ Asian           <dbl> 1.0, 0.7, 0.4, 0.1, 0.1, 0.2, 0.4, 0.9, 0.8, 0.3, 0...
## $ Pacific         <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0...
## $ Citizen         <dbl> 40725, 147695, 20714, 17495, 42345, 8057, 15581, 88...
## $ Income          <dbl> 51281, 50254, 32964, 38678, 45813, 31938, 32229, 41...
## $ IncomeErr       <dbl> 2391, 1263, 2973, 3995, 3141, 5884, 1793, 925, 2949...
## $ IncomePerCap    <dbl> 24974, 27317, 16824, 18431, 20532, 17580, 18390, 21...
## $ IncomePerCapErr <dbl> 1080, 711, 798, 1618, 708, 2055, 714, 489, 1366, 15...
## $ Poverty         <dbl> 12.9, 13.4, 26.7, 16.8, 16.7, 24.6, 25.4, 20.5, 21....
## $ ChildPoverty    <dbl> 18.6, 19.2, 45.3, 27.9, 27.2, 38.4, 39.2, 31.6, 37....
## $ Professional    <dbl> 33.2, 33.1, 26.8, 21.5, 28.5, 18.8, 27.5, 27.3, 23....
## $ Service         <dbl> 17.0, 17.7, 16.1, 17.9, 14.1, 15.0, 16.6, 17.7, 14....
## $ Office          <dbl> 24.2, 27.1, 23.1, 17.8, 23.9, 19.7, 21.9, 24.2, 26....
## $ Construction    <dbl> 8.6, 10.8, 10.8, 19.0, 13.5, 20.1, 10.3, 10.5, 11.5...
## $ Production      <dbl> 17.1, 11.2, 23.1, 23.7, 19.9, 26.4, 23.7, 20.4, 24....
## $ Drive           <dbl> 87.5, 84.7, 83.8, 83.2, 84.9, 74.9, 84.5, 85.3, 85....
## $ Carpool         <dbl> 8.8, 8.8, 10.9, 13.5, 11.2, 14.9, 12.4, 9.4, 11.9, ...
## $ Transit         <dbl> 0.1, 0.1, 0.4, 0.5, 0.4, 0.7, 0.0, 0.2, 0.2, 0.2, 0...
## $ Walk            <dbl> 0.5, 1.0, 1.8, 0.6, 0.9, 5.0, 0.8, 1.2, 0.3, 0.6, 1...
## $ OtherTransp     <dbl> 1.3, 1.4, 1.5, 1.5, 0.4, 1.7, 0.6, 1.2, 0.4, 0.7, 1...
## $ WorkAtHome      <dbl> 1.8, 3.9, 1.6, 0.7, 2.3, 2.8, 1.7, 2.7, 2.1, 2.5, 1...
## $ MeanCommute     <dbl> 26.5, 26.4, 24.1, 28.8, 34.9, 27.5, 24.6, 24.1, 25....
## $ Employed        <dbl> 23986, 85953, 8597, 8294, 22189, 3865, 7813, 47401,...
## $ PrivateWork     <dbl> 73.6, 81.5, 71.8, 76.8, 82.0, 79.5, 77.4, 74.1, 85....
## $ PublicWork      <dbl> 20.9, 12.3, 20.8, 16.1, 13.5, 15.1, 16.2, 20.8, 12....
## $ SelfEmployed    <dbl> 5.5, 5.8, 7.3, 6.7, 4.2, 5.4, 6.2, 5.0, 2.8, 7.9, 4...
## $ FamilyWork      <dbl> 0.0, 0.4, 0.1, 0.4, 0.4, 0.0, 0.2, 0.1, 0.0, 0.5, 0...
## $ Unemployment    <dbl> 7.6, 7.5, 17.6, 8.3, 7.7, 18.0, 10.9, 12.3, 8.9, 7....
```

The census data has `3220` observations and `37` variables.

Read 2016 election results (data taken from [GitHub user tonmcg](https://github.com/tonmcg/US_County_Level_Election_Results_08-16/blob/master/2016_US_County_Level_Presidential_Results.csv)).


```r
election_data <- read_csv("data/US_2016_election_results.txt")
```

```
## Warning: Missing column names filled in: 'X1' [1]
```

```
## Parsed with column specification:
## cols(
##   X1 = col_double(),
##   votes_dem = col_double(),
##   votes_gop = col_double(),
##   total_votes = col_double(),
##   per_dem = col_double(),
##   per_gop = col_double(),
##   diff = col_number(),
##   per_point_diff = col_character(),
##   state_abbr = col_character(),
##   county_name = col_character(),
##   combined_fips = col_double()
## )
```

```r
# Print first rows
head(election_data)
```

```
## # A tibble: 6 x 11
##      X1 votes_dem votes_gop total_votes per_dem per_gop  diff per_point_diff
##   <dbl>     <dbl>     <dbl>       <dbl>   <dbl>   <dbl> <dbl> <chr>         
## 1     0     93003    130413      246588   0.377   0.529 37410 15.17%        
## 2     1     93003    130413      246588   0.377   0.529 37410 15.17%        
## 3     2     93003    130413      246588   0.377   0.529 37410 15.17%        
## 4     3     93003    130413      246588   0.377   0.529 37410 15.17%        
## 5     4     93003    130413      246588   0.377   0.529 37410 15.17%        
## 6     5     93003    130413      246588   0.377   0.529 37410 15.17%        
## # ... with 3 more variables: state_abbr <chr>, county_name <chr>,
## #   combined_fips <dbl>
```

```r
# Get a glimpse of the data
dim(election_data)
```

```
## [1] 3141   11
```

```r
glimpse(election_data)
```

```
## Observations: 3,141
## Variables: 11
## $ X1             <dbl> 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15...
## $ votes_dem      <dbl> 93003, 93003, 93003, 93003, 93003, 93003, 93003, 930...
## $ votes_gop      <dbl> 130413, 130413, 130413, 130413, 130413, 130413, 1304...
## $ total_votes    <dbl> 246588, 246588, 246588, 246588, 246588, 246588, 2465...
## $ per_dem        <dbl> 0.3771595, 0.3771595, 0.3771595, 0.3771595, 0.377159...
## $ per_gop        <dbl> 0.52887, 0.52887, 0.52887, 0.52887, 0.52887, 0.52887...
## $ diff           <dbl> 37410, 37410, 37410, 37410, 37410, 37410, 37410, 374...
## $ per_point_diff <chr> "15.17%", "15.17%", "15.17%", "15.17%", "15.17%", "1...
## $ state_abbr     <chr> "AK", "AK", "AK", "AK", "AK", "AK", "AK", "AK", "AK"...
## $ county_name    <chr> "Alaska", "Alaska", "Alaska", "Alaska", "Alaska", "A...
## $ combined_fips  <dbl> 2013, 2016, 2020, 2050, 2060, 2068, 2070, 2090, 2100...
```

The census data has `3141` observations and `11` variables, this is `79`
fewer observations than in the census data. Let's investigate!

# Tidy data

## Prepare data sets for join

Check how many states are included in each data set.


```r
# Census data
census_data %>% 
  group_by(State) %>% 
  summarise(n = n())
```

```
## # A tibble: 52 x 2
##    State                    n
##    <chr>                <int>
##  1 Alabama                 67
##  2 Alaska                  29
##  3 Arizona                 15
##  4 Arkansas                75
##  5 California              58
##  6 Colorado                64
##  7 Connecticut              8
##  8 Delaware                 3
##  9 District of Columbia     1
## 10 Florida                 67
## # ... with 42 more rows
```

```r
# Election data
election_data %>% 
  group_by(state_abbr) %>% 
  summarise(n = n())
```

```
## # A tibble: 51 x 2
##    state_abbr     n
##    <chr>      <int>
##  1 AK            29
##  2 AL            67
##  3 AR            75
##  4 AZ            15
##  5 CA            58
##  6 CO            64
##  7 CT             8
##  8 DC             1
##  9 DE             3
## 10 FL            67
## # ... with 41 more rows
```

The census data includes Puerto Rico, who can't vote in elections. So I will 
remove these observations from the `census_data`.


```r
census_data_voting <- census_data %>% 
  filter(State != "Puerto Rico")

# Check dimensions
dim(census_data_voting)
```

```
## [1] 3142   37
```

There's still one more observation in `census_data_voting`. Check it out with
an `anti_join`.


```r
# First change name of fips code column
# I will also remove the first column X1
election_data_trimmed <- election_data %>% 
  select(-X1) %>% 
  rename(CensusId = combined_fips)

# Use anti_join to join the datasets
anti_join(election_data_trimmed, census_data_voting, by = "CensusId")
```

```
## # A tibble: 2 x 10
##   votes_dem votes_gop total_votes per_dem per_gop  diff per_point_diff
##       <dbl>     <dbl>       <dbl>   <dbl>   <dbl> <dbl> <chr>         
## 1     93003    130413      246588   0.377  0.529  37410 15.17%        
## 2      2504       241        2896   0.865  0.0832  2263 78.14%        
## # ... with 3 more variables: state_abbr <chr>, county_name <chr>,
## #   CensusId <dbl>
```

```r
anti_join(census_data_voting, election_data_trimmed, by = "CensusId")
```

```
## # A tibble: 3 x 37
##   CensusId State County TotalPop   Men Women Hispanic White Black Native Asian
##      <dbl> <chr> <chr>     <dbl> <dbl> <dbl>    <dbl> <dbl> <dbl>  <dbl> <dbl>
## 1     2158 Alas~ Kusil~     7914  4200  3714      1     4.5   0.4   87.4   0.4
## 2    15005 Hawa~ Kalaw~       85    42    43      4.7  37.6   0      0    21.2
## 3    46102 Sout~ Oglal~    14153  6809  7344      1     4.8   0.5   92.1   0  
## # ... with 26 more variables: Pacific <dbl>, Citizen <dbl>, Income <dbl>,
## #   IncomeErr <dbl>, IncomePerCap <dbl>, IncomePerCapErr <dbl>, Poverty <dbl>,
## #   ChildPoverty <dbl>, Professional <dbl>, Service <dbl>, Office <dbl>,
## #   Construction <dbl>, Production <dbl>, Drive <dbl>, Carpool <dbl>,
## #   Transit <dbl>, Walk <dbl>, OtherTransp <dbl>, WorkAtHome <dbl>,
## #   MeanCommute <dbl>, Employed <dbl>, PrivateWork <dbl>, PublicWork <dbl>,
## #   SelfEmployed <dbl>, FamilyWork <dbl>, Unemployment <dbl>
```

There are 5 counties that are not shared between the two data sets.

Use a `full_join` to merge the two data sets.


```r
data_joined <- full_join(census_data_voting, election_data_trimmed, by = "CensusId")

# Check stats
dim(data_joined)
```

```
## [1] 3144   46
```

```r
glimpse(data_joined)
```

```
## Observations: 3,144
## Variables: 46
## $ CensusId        <dbl> 1001, 1003, 1005, 1007, 1009, 1011, 1013, 1015, 101...
## $ State           <chr> "Alabama", "Alabama", "Alabama", "Alabama", "Alabam...
## $ County          <chr> "Autauga", "Baldwin", "Barbour", "Bibb", "Blount", ...
## $ TotalPop        <dbl> 55221, 195121, 26932, 22604, 57710, 10678, 20354, 1...
## $ Men             <dbl> 26745, 95314, 14497, 12073, 28512, 5660, 9502, 5627...
## $ Women           <dbl> 28476, 99807, 12435, 10531, 29198, 5018, 10852, 603...
## $ Hispanic        <dbl> 2.6, 4.5, 4.6, 2.2, 8.6, 4.4, 1.2, 3.5, 0.4, 1.5, 7...
## $ White           <dbl> 75.8, 83.1, 46.2, 74.5, 87.9, 22.2, 53.3, 73.0, 57....
## $ Black           <dbl> 18.5, 9.5, 46.7, 21.4, 1.5, 70.7, 43.8, 20.3, 40.3,...
## $ Native          <dbl> 0.4, 0.6, 0.2, 0.4, 0.3, 1.2, 0.1, 0.2, 0.2, 0.6, 0...
## $ Asian           <dbl> 1.0, 0.7, 0.4, 0.1, 0.1, 0.2, 0.4, 0.9, 0.8, 0.3, 0...
## $ Pacific         <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0...
## $ Citizen         <dbl> 40725, 147695, 20714, 17495, 42345, 8057, 15581, 88...
## $ Income          <dbl> 51281, 50254, 32964, 38678, 45813, 31938, 32229, 41...
## $ IncomeErr       <dbl> 2391, 1263, 2973, 3995, 3141, 5884, 1793, 925, 2949...
## $ IncomePerCap    <dbl> 24974, 27317, 16824, 18431, 20532, 17580, 18390, 21...
## $ IncomePerCapErr <dbl> 1080, 711, 798, 1618, 708, 2055, 714, 489, 1366, 15...
## $ Poverty         <dbl> 12.9, 13.4, 26.7, 16.8, 16.7, 24.6, 25.4, 20.5, 21....
## $ ChildPoverty    <dbl> 18.6, 19.2, 45.3, 27.9, 27.2, 38.4, 39.2, 31.6, 37....
## $ Professional    <dbl> 33.2, 33.1, 26.8, 21.5, 28.5, 18.8, 27.5, 27.3, 23....
## $ Service         <dbl> 17.0, 17.7, 16.1, 17.9, 14.1, 15.0, 16.6, 17.7, 14....
## $ Office          <dbl> 24.2, 27.1, 23.1, 17.8, 23.9, 19.7, 21.9, 24.2, 26....
## $ Construction    <dbl> 8.6, 10.8, 10.8, 19.0, 13.5, 20.1, 10.3, 10.5, 11.5...
## $ Production      <dbl> 17.1, 11.2, 23.1, 23.7, 19.9, 26.4, 23.7, 20.4, 24....
## $ Drive           <dbl> 87.5, 84.7, 83.8, 83.2, 84.9, 74.9, 84.5, 85.3, 85....
## $ Carpool         <dbl> 8.8, 8.8, 10.9, 13.5, 11.2, 14.9, 12.4, 9.4, 11.9, ...
## $ Transit         <dbl> 0.1, 0.1, 0.4, 0.5, 0.4, 0.7, 0.0, 0.2, 0.2, 0.2, 0...
## $ Walk            <dbl> 0.5, 1.0, 1.8, 0.6, 0.9, 5.0, 0.8, 1.2, 0.3, 0.6, 1...
## $ OtherTransp     <dbl> 1.3, 1.4, 1.5, 1.5, 0.4, 1.7, 0.6, 1.2, 0.4, 0.7, 1...
## $ WorkAtHome      <dbl> 1.8, 3.9, 1.6, 0.7, 2.3, 2.8, 1.7, 2.7, 2.1, 2.5, 1...
## $ MeanCommute     <dbl> 26.5, 26.4, 24.1, 28.8, 34.9, 27.5, 24.6, 24.1, 25....
## $ Employed        <dbl> 23986, 85953, 8597, 8294, 22189, 3865, 7813, 47401,...
## $ PrivateWork     <dbl> 73.6, 81.5, 71.8, 76.8, 82.0, 79.5, 77.4, 74.1, 85....
## $ PublicWork      <dbl> 20.9, 12.3, 20.8, 16.1, 13.5, 15.1, 16.2, 20.8, 12....
## $ SelfEmployed    <dbl> 5.5, 5.8, 7.3, 6.7, 4.2, 5.4, 6.2, 5.0, 2.8, 7.9, 4...
## $ FamilyWork      <dbl> 0.0, 0.4, 0.1, 0.4, 0.4, 0.0, 0.2, 0.1, 0.0, 0.5, 0...
## $ Unemployment    <dbl> 7.6, 7.5, 17.6, 8.3, 7.7, 18.0, 10.9, 12.3, 8.9, 7....
## $ votes_dem       <dbl> 5908, 18409, 4848, 1874, 2150, 3530, 3716, 13197, 5...
## $ votes_gop       <dbl> 18110, 72780, 5431, 6733, 22808, 1139, 4891, 32803,...
## $ total_votes     <dbl> 24661, 94090, 10390, 8748, 25384, 4701, 8685, 47376...
## $ per_dem         <dbl> 0.23956855, 0.19565310, 0.46660250, 0.21422039, 0.0...
## $ per_gop         <dbl> 0.7343579, 0.7735147, 0.5227141, 0.7696616, 0.89851...
## $ diff            <dbl> 12202, 54371, 583, 4859, 20658, 2391, 1175, 19606, ...
## $ per_point_diff  <chr> "49.48%", "57.79%", "5.61%", "55.54%", "81.38%", "5...
## $ state_abbr      <chr> "AL", "AL", "AL", "AL", "AL", "AL", "AL", "AL", "AL...
## $ county_name     <chr> "Autauga County", "Baldwin County", "Barbour County...
```

We now have a dataset with `3144` observations and `46` variables. However,
this is two more than in the census data so there might be some missing values.

Check for missing values and remove rows including `na`s.


```r
data_joined %>% 
  filter(is.na(total_votes))
```

```
## # A tibble: 3 x 46
##   CensusId State County TotalPop   Men Women Hispanic White Black Native Asian
##      <dbl> <chr> <chr>     <dbl> <dbl> <dbl>    <dbl> <dbl> <dbl>  <dbl> <dbl>
## 1     2158 Alas~ Kusil~     7914  4200  3714      1     4.5   0.4   87.4   0.4
## 2    15005 Hawa~ Kalaw~       85    42    43      4.7  37.6   0      0    21.2
## 3    46102 Sout~ Oglal~    14153  6809  7344      1     4.8   0.5   92.1   0  
## # ... with 35 more variables: Pacific <dbl>, Citizen <dbl>, Income <dbl>,
## #   IncomeErr <dbl>, IncomePerCap <dbl>, IncomePerCapErr <dbl>, Poverty <dbl>,
## #   ChildPoverty <dbl>, Professional <dbl>, Service <dbl>, Office <dbl>,
## #   Construction <dbl>, Production <dbl>, Drive <dbl>, Carpool <dbl>,
## #   Transit <dbl>, Walk <dbl>, OtherTransp <dbl>, WorkAtHome <dbl>,
## #   MeanCommute <dbl>, Employed <dbl>, PrivateWork <dbl>, PublicWork <dbl>,
## #   SelfEmployed <dbl>, FamilyWork <dbl>, Unemployment <dbl>, votes_dem <dbl>,
## #   votes_gop <dbl>, total_votes <dbl>, per_dem <dbl>, per_gop <dbl>,
## #   diff <dbl>, per_point_diff <chr>, state_abbr <chr>, county_name <chr>
```

```r
data_joined %>% 
  filter(is.na(TotalPop))
```

```
## # A tibble: 2 x 46
##   CensusId State County TotalPop   Men Women Hispanic White Black Native Asian
##      <dbl> <chr> <chr>     <dbl> <dbl> <dbl>    <dbl> <dbl> <dbl>  <dbl> <dbl>
## 1     2270 <NA>  <NA>         NA    NA    NA       NA    NA    NA     NA    NA
## 2    46113 <NA>  <NA>         NA    NA    NA       NA    NA    NA     NA    NA
## # ... with 35 more variables: Pacific <dbl>, Citizen <dbl>, Income <dbl>,
## #   IncomeErr <dbl>, IncomePerCap <dbl>, IncomePerCapErr <dbl>, Poverty <dbl>,
## #   ChildPoverty <dbl>, Professional <dbl>, Service <dbl>, Office <dbl>,
## #   Construction <dbl>, Production <dbl>, Drive <dbl>, Carpool <dbl>,
## #   Transit <dbl>, Walk <dbl>, OtherTransp <dbl>, WorkAtHome <dbl>,
## #   MeanCommute <dbl>, Employed <dbl>, PrivateWork <dbl>, PublicWork <dbl>,
## #   SelfEmployed <dbl>, FamilyWork <dbl>, Unemployment <dbl>, votes_dem <dbl>,
## #   votes_gop <dbl>, total_votes <dbl>, per_dem <dbl>, per_gop <dbl>,
## #   diff <dbl>, per_point_diff <chr>, state_abbr <chr>, county_name <chr>
```

```r
# Remove observations with NAs
data_trimmed <- data_joined %>% 
  filter(!is.na(TotalPop)) %>% 
  filter(!is.na(total_votes))

# Check dimensions
dim(data_trimmed)
```

```
## [1] 3139   46
```

There are five observations that are specific to one dataset and which have been
removed. However, the county in South Dakota seems to be the same with similar 
name and different `CensusId`.

Let's see if we can join them!


```r
# Filter out the SD county in census
sd_census <- census_data_voting %>% 
  filter(County == "Oglala Lakota")

# Append voting data to Oglala Lakota
sd_votes <- cbind(sd_census, election_data_trimmed %>% 
        filter(county_name == "Oglala County") %>% 
          select(-CensusId))

# Append observation to the dataset
data <- rbind(data_trimmed, sd_votes)
dim(data)
```

```
## [1] 3140   46
```

I have no idea why there is one more Hawaii county in the census data. The data
from Alaska seems different between the two data sets.

## Alaska!


```r
# Filter for Alaska
data %>% 
  filter(State == "Alaska")
```

```
## # A tibble: 28 x 46
##    CensusId State County TotalPop    Men  Women Hispanic White Black Native
##       <dbl> <chr> <chr>     <dbl>  <dbl>  <dbl>    <dbl> <dbl> <dbl>  <dbl>
##  1     2013 Alas~ Aleut~     3304   2198   1106     12    15     9.2   29  
##  2     2016 Alas~ Aleut~     5684   3393   2291     11    27.8   4.6   12.9
##  3     2020 Alas~ Ancho~   299107 153122 145985      8.6  60.3   5.5    6.3
##  4     2050 Alas~ Bethe~    17776   9351   8425      1.8  11.3   0.8   80.6
##  5     2060 Alas~ Brist~      970    553    417      7.1  53.4   0.5   29  
##  6     2068 Alas~ Denal~     2060   1126    934      2.6  84.7   0.6    3.5
##  7     2070 Alas~ Dilli~     4979   2589   2390      2.9  17.7   0.3   71.7
##  8     2090 Alas~ Fairb~    99705  53477  46228      7.4  71.9   4.1    5.7
##  9     2100 Alas~ Haine~     2560   1387   1173      1.5  79.6   0      6.4
## 10     2105 Alas~ Hoona~     2128   1129    999      2.2  49.3   2.2   32.4
## # ... with 18 more rows, and 36 more variables: Asian <dbl>, Pacific <dbl>,
## #   Citizen <dbl>, Income <dbl>, IncomeErr <dbl>, IncomePerCap <dbl>,
## #   IncomePerCapErr <dbl>, Poverty <dbl>, ChildPoverty <dbl>,
## #   Professional <dbl>, Service <dbl>, Office <dbl>, Construction <dbl>,
## #   Production <dbl>, Drive <dbl>, Carpool <dbl>, Transit <dbl>, Walk <dbl>,
## #   OtherTransp <dbl>, WorkAtHome <dbl>, MeanCommute <dbl>, Employed <dbl>,
## #   PrivateWork <dbl>, PublicWork <dbl>, SelfEmployed <dbl>, FamilyWork <dbl>,
## #   Unemployment <dbl>, votes_dem <dbl>, votes_gop <dbl>, total_votes <dbl>,
## #   per_dem <dbl>, per_gop <dbl>, diff <dbl>, per_point_diff <chr>,
## #   state_abbr <chr>, county_name <chr>
```

The voting data is the same for all counties in Alaska, while the census data
is different. I either must remove all Alaska counties or count Alaska as a
state. Since much of the data is relative or an average it would be difficult
to know if all the data is correct, so I will simply remove them.


```r
# Remove Alaska observations
tidy_data <- data %>% 
  filter(State != "Alaska")
dim(tidy_data)
```

```
## [1] 3112   46
```

Our final dataset includes `50` states including District of Colombia and
`3112` observations and `46` columns. 

# Create binary column for who one each country

For later machine learning purposes.


```r
tidy_data %>% 
  mutate(won = if_else(votes_gop > votes_dem, "Trump", "Clinton"))
```

```
## # A tibble: 3,112 x 47
##    CensusId State County TotalPop   Men Women Hispanic White Black Native Asian
##       <dbl> <chr> <chr>     <dbl> <dbl> <dbl>    <dbl> <dbl> <dbl>  <dbl> <dbl>
##  1     1001 Alab~ Autau~    55221 26745 28476      2.6  75.8  18.5    0.4   1  
##  2     1003 Alab~ Baldw~   195121 95314 99807      4.5  83.1   9.5    0.6   0.7
##  3     1005 Alab~ Barbo~    26932 14497 12435      4.6  46.2  46.7    0.2   0.4
##  4     1007 Alab~ Bibb      22604 12073 10531      2.2  74.5  21.4    0.4   0.1
##  5     1009 Alab~ Blount    57710 28512 29198      8.6  87.9   1.5    0.3   0.1
##  6     1011 Alab~ Bullo~    10678  5660  5018      4.4  22.2  70.7    1.2   0.2
##  7     1013 Alab~ Butler    20354  9502 10852      1.2  53.3  43.8    0.1   0.4
##  8     1015 Alab~ Calho~   116648 56274 60374      3.5  73    20.3    0.2   0.9
##  9     1017 Alab~ Chamb~    34079 16258 17821      0.4  57.3  40.3    0.2   0.8
## 10     1019 Alab~ Chero~    26008 12975 13033      1.5  91.7   4.8    0.6   0.3
## # ... with 3,102 more rows, and 36 more variables: Pacific <dbl>,
## #   Citizen <dbl>, Income <dbl>, IncomeErr <dbl>, IncomePerCap <dbl>,
## #   IncomePerCapErr <dbl>, Poverty <dbl>, ChildPoverty <dbl>,
## #   Professional <dbl>, Service <dbl>, Office <dbl>, Construction <dbl>,
## #   Production <dbl>, Drive <dbl>, Carpool <dbl>, Transit <dbl>, Walk <dbl>,
## #   OtherTransp <dbl>, WorkAtHome <dbl>, MeanCommute <dbl>, Employed <dbl>,
## #   PrivateWork <dbl>, PublicWork <dbl>, SelfEmployed <dbl>, FamilyWork <dbl>,
## #   Unemployment <dbl>, votes_dem <dbl>, votes_gop <dbl>, total_votes <dbl>,
## #   per_dem <dbl>, per_gop <dbl>, diff <dbl>, per_point_diff <chr>,
## #   state_abbr <chr>, county_name <chr>, won <chr>
```

# Save data


```r
write_tsv(tidy_data, "data/US_2016_election_and_2015_census_data.tsv")
```





















