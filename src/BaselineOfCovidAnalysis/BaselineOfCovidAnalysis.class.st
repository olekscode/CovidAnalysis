Class {
	#name : #BaselineOfCovidAnalysis,
	#superclass : #BaselineOf,
	#category : #BaselineOfCovidAnalysis
}

{ #category : #baselines }
BaselineOfCovidAnalysis >> baseline: spec [
	<baseline>
	spec for: #common do: [	
		"External dependencies"
		spec
			baseline: 'DataFrame'
			with: [ spec repository: 'github://PolyMathOrg/DataFrame/src' ].
			
		spec
			baseline: 'Roassal3'
			with: [ spec repository: 'github://ObjectProfile/Roassal3' ].
				
		"Packages"
		spec 
			package: 'CovidAnalysis' with: [ spec requires: #(DataFrame Roassal3) ];
			package: 'CovidAnalysis-Tests' with: [ spec requires: #(CovidAnalysis) ] ].
]
