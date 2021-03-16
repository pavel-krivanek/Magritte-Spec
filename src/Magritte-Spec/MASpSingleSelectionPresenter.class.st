Class {
	#name : #MASpSingleSelectionPresenter,
	#superclass : #MASpOptionPresenter,
	#category : #'Magritte-Spec'
}

{ #category : #accessing }
MASpSingleSelectionPresenter >> options [
	^ self magritteDescription allOptionsWith: self value
]
