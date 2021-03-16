Class {
	#name : #MASpUndefinedPresenter,
	#superclass : #MASpElementPresenter,
	#category : #'Magritte-Spec'
}

{ #category : #converting }
MASpUndefinedPresenter >> buildAsEditor [

	element := self newLabel label: '<undefined presenter>' 
]

{ #category : #converting }
MASpUndefinedPresenter >> buildAsView [

	element := self newLabel label: '<undefined presenter>' 
]

{ #category : #converting }
MASpUndefinedPresenter >> initialize [ 

super initialize.
]
