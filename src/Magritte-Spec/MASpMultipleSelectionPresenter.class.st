Class {
	#name : #MASpMultipleSelectionPresenter,
	#superclass : #MASpOptionPresenter,
	#category : #'Magritte-Spec'
}

{ #category : #'as yet unclassified' }
MASpMultipleSelectionPresenter >> availableList [
	^ self magritteDescription allOptions
]

{ #category : #'as yet unclassified' }
MASpMultipleSelectionPresenter >> selectedList [
	^ self value
]
