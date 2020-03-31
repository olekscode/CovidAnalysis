Class {
	#name : #CovidDataLoader,
	#superclass : #Object,
	#category : #CovidAnalysis
}

{ #category : #'accessing-path' }
CovidDataLoader >> dataCsvFile [
	^ self dataDirectory ensureCreateDirectory / 'covidData.csv'
]

{ #category : #'accessing-path' }
CovidDataLoader >> dataCsvUrl [
	^ 'https://opendata.ecdc.europa.eu/covid19/casedistribution/csv'
]

{ #category : #'accessing-path' }
CovidDataLoader >> dataDirectory [
	^ 'pharo-local/iceberg/olekscode/CovidAnalysis/data' asFileReference
]

{ #category : #'data loading' }
CovidDataLoader >> downloadLatestData [
	| client bytes |
	client := ZnClient new
		url: self dataCsvUrl;
		yourself.
		
	client get.
	bytes := client response entity bytes.

	self dataCsvFile binaryWriteStream
		nextPutAll: bytes;
		close.
]

{ #category : #'data loading' }
CovidDataLoader >> loadData [
	| dataFrameReader covidDataFrame |
	dataFrameReader := DataFrameCsvReader new.
	dataFrameReader shouldParseTypes: false.

	covidDataFrame := DataFrame
		readFrom: self dataCsvFile
		using: dataFrameReader.

	self preprocessDataIn: covidDataFrame.
	^ covidDataFrame
]

{ #category : #'data preprocessing' }
CovidDataLoader >> parseDateAndNumberColumnsOf: aCovidDataFrame [
	aCovidDataFrame
		toColumn: 'date'
		applyElementwise: [ :each |
			Date readFrom: each pattern: 'dd/mm/yyyy' ].

	aCovidDataFrame
		toColumns: #(cases deaths)
		applyElementwise: [ :each | each asInteger ].
]

{ #category : #'data preprocessing' }
CovidDataLoader >> preprocessDataIn: aCovidDataFrame [
	self removeRedundantColumnsFrom: aCovidDataFrame.
	self renameColumnsOf: aCovidDataFrame.
	self parseDateAndNumberColumnsOf: aCovidDataFrame.
	self sortRowsOf: aCovidDataFrame.
]

{ #category : #'data preprocessing' }
CovidDataLoader >> removeRedundantColumnsFrom: aCovidDataFrame [
	"date, month, and year are already included in 'date' column. Also we don't need 'geoId' and 'countryterritoryCode', because we have unique country names"
	aCovidDataFrame removeColumns: #(day month year geoId countryterritoryCode).
]

{ #category : #'data preprocessing' }
CovidDataLoader >> renameColumnsOf: aCovidDataFrame [
	aCovidDataFrame
		renameColumn: 'dateRep' to: 'date';
		renameColumn: 'countriesAndTerritories' to: 'country';
		renameColumn: 'popData2018' to: 'population'.
]

{ #category : #'data preprocessing' }
CovidDataLoader >> sortRowsOf: aCovidDataFrame [
	aCovidDataFrame sortBy: 'date'.
]
