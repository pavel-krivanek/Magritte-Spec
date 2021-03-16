Class {
	#name : #MASpSelectListPresenter,
	#superclass : #MASpSingleSelectionPresenter,
	#category : #'Magritte-Spec'
}

{ #category : #converting }
MASpSelectListPresenter >> buildAsEditor [

	element := self newDropList.
	element items: self options.
	element selectItem: self value.
	element whenSelectedItemChangedDo: [ :anOption |
		self value: anOption  ].
]
