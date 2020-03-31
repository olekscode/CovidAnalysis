# COVID-19 Analysis

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
