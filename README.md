# COVID-19 Analysis

In this repository, I provide an initial setup for analysing the daily-updated COVID-19 dataset published by the European Centre for Disease Prevention and Control: https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide. This dataset contains the following fields: **date**, **country**, number of **cases** reported on a given day, number of **deaths** reported on a given day, and a total **population** of the country as of 2018, taken from the [World Bank Open Data](https://data.worldbank.org/).

## How to install it?

To install `CovidAnalysis`, go to the Playground (Ctrl+OW) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'CovidAnalysis';
  repository: 'github://olekscode/CovidAnalysis/src';
  load.
```

## How to use it?

Here are some examples of downloading the latest data and loading it as a cleaned DataFrame (data source: https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide):

```Smalltalk
dataLoader := CovidDataLoader new.
dataLoader downloadLatestData.
covidData := dataLoader loadData.
```

![DataFrame of COVID-19 data](img/covidData.png)

![DataFrame of COVID-19 data for France](img/covidDataFrance.png)
