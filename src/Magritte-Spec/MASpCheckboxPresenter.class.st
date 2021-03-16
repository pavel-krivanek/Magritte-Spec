Class {
	#name : #MASpCheckboxPresenter,
	#superclass : #MASpElementPresenter,
	#category : #'Magritte-Spec'
}

{ #category : #converting }
MASpCheckboxPresenter >> buildAsEditor [

	element := self newCheckBox.
	element state: self value. 
	element whenChangedDo: [ :newState | self string: newState ].
]

{ #category : #converting }
MASpCheckboxPresenter >> labelOrNil [

	self magritteDescription hasLabel ifFalse: [ ^ nil ].
	^ self magritteDescription checkboxLabel
]
