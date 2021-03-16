Class {
	#name : #MASpDescribedColumn,
	#superclass : #MASpColumn,
	#instVars : [
		'description'
	],
	#category : #'Magritte-Spec'
}

{ #category : #accessing }
MASpDescribedColumn >> magritteDescription [
	^ description
]

{ #category : #accessing }
MASpDescribedColumn >> magritteDescription: aDescription [
	description := aDescription.
	accessor := aDescription accessor
]
