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

First create an instance of `CovidDataLoader`. This class will help you download the latest data from the Internet, clean it and load it into your image as a [DataFrame](https://github.com/PolyMathOrg/DataFrame) object.

```Smalltalk
dataLoader := CovidDataLoader new.
```

Use the following method to download the latest data. It may take a couple of seconds. The result will be stored as a CSV inside a `data/` folder of this repository.

```Smalltalk
dataLoader downloadLatestData.
```

Now you can read the downloaded data from a CSV. This method will automatically clean and parse the values of a dataset:

```Smalltalk
covidData := dataLoader loadData.
```

The result will be a data frame that looks like this:

![DataFrame of COVID-19 data](img/covidData.png)



![DataFrame of COVID-19 data for France](img/covidDataFrance.png)
