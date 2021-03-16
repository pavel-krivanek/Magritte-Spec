Class {
	#name : #MASpPresenter,
	#superclass : #SpPresenter,
	#category : #'Magritte-Spec'
}

{ #category : #'error handling' }
MASpPresenter class >> defaultErrorClass [
	^ MAError
]

{ #category : #'error handling' }
MASpPresenter class >> defaultSpec [ 

	^ SpBoxLayout newVertical
]

{ #category : #accessing }
MASpPresenter >> childrenDo: aBlock [ 

]

{ #category : #accessing }
MASpPresenter >> defaultLayout [ 

	^ SpBoxLayout newHorizontal 
		add: (self newLabel label: self class name);
		yourself
]

{ #category : #building }
MASpPresenter >> rebuild [

	self layout: self defaultLayout.
]

{ #category : #'as yet unclassified' }
MASpPresenter >> rebuildOwnersLayout [

	self owner layout: self owner defaultLayout.	
]

{ #category : #building }
MASpPresenter >> rebuildPresenters [

	
]

{ #category : #accessing }
MASpPresenter >> redefineLayout [

	self rawLayout: self defaultLayout.
	self rebuildOwnersLayout
]
