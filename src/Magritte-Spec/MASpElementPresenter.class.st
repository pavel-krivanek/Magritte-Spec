Class {
	#name : #MASpElementPresenter,
	#superclass : #MASpDescriptionPresenter,
	#instVars : [
		'element'
	],
	#category : #'Magritte-Spec'
}

{ #category : #accessing }
MASpElementPresenter >> defaultLayout [ 

	^ SpBoxLayout newHorizontal 
		add: #element;
		yourself
]

{ #category : #accessing }
MASpElementPresenter >> reference [
	^ self magritteDescription reference
]

{ #category : #'accessing - model' }
MASpElementPresenter >> string [

	^ self value isString
		ifTrue: [ self value ]
		ifFalse: [ self magritteDescription toString: self value ]
]

{ #category : #'accessing - model' }
MASpElementPresenter >> string: aString [
	| value |
	value := [ self magritteDescription fromString: aString ]
		on: Error do: [ :e | e return: aString ].
	self value: value
]

{ #category : #'accessing - model' }
MASpElementPresenter >> value [
	^ self memento readUsing: self magritteDescription
]

{ #category : #'accessing - model' }
MASpElementPresenter >> value: anObject [
	self memento write: anObject using: self magritteDescription
]
