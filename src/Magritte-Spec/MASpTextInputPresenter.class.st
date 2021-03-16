Class {
	#name : #MASpTextInputPresenter,
	#superclass : #MASpElementPresenter,
	#category : #'Magritte-Spec'
}

{ #category : #'as yet unclassified' }
MASpTextInputPresenter >> buildAsEditor [

	element := self newTextInput.
	element text: self string.
	element whenTextChangedDo: [ :newText | self string: newText ].
]

{ #category : #'as yet unclassified' }
MASpTextInputPresenter >> buildAsView [

	element := self newLabel.
	element label: self string.
]
