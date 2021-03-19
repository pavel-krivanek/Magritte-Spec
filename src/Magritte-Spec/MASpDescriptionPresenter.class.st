Class {
	#name : #MASpDescriptionPresenter,
	#superclass : #MASpPresenter,
	#instVars : [
		'memento',
		'description',
		'parent',
		'saveAction'
	],
	#category : #'Magritte-Spec'
}

{ #category : #'instance creation' }
MASpDescriptionPresenter class >> memento: aMemento [
	^ self memento: aMemento description: aMemento magritteDescription
]

{ #category : #'instance creation' }
MASpDescriptionPresenter class >> memento: aMemento description: aDescription [
	^ self memento: aMemento description: aDescription parent: nil
]

{ #category : #'instance creation' }
MASpDescriptionPresenter class >> memento: aMemento description: aDescription in: anApplication [
	^ self memento: aMemento description: aDescription parent: nil in: anApplication
]

{ #category : #'instance creation' }
MASpDescriptionPresenter class >> memento: aMemento description: aDescription parent: aComponent [
	^ self new
		setMemento: aMemento;
		setDescription: aDescription;
		setParent: aComponent;
		yourself
]

{ #category : #'instance creation' }
MASpDescriptionPresenter class >> memento: aMemento description: aDescription parent: aComponent in: anApplication [
	^ (self newApplication: anApplication)
		setMemento: aMemento;
		setDescription: aDescription;
		setParent: aComponent;
		yourself
]

{ #category : #'instance creation' }
MASpDescriptionPresenter class >> memento: aMemento in: anApplication [
	^ self memento: aMemento description: aMemento magritteDescription in: anApplication
]

{ #category : #'as yet unclassified' }
MASpDescriptionPresenter >> doValidateTo: aCollectionOfErrors [
	"Enables components to raise errors when the model is validated."
]

{ #category : #initialization }
MASpDescriptionPresenter >> initializeDialogWindow: aDialogWindowPresenter [
	
	aDialogWindowPresenter
		addButton: 'Save' do: [ :presenter | 
			self saveAction ifNotNil: [ :anAction | anAction value ].
			presenter close ];
		
		addButton: 'Cancel' do: [ :presenter | 
			presenter triggerCancelAction.
			presenter close ]	
]

{ #category : #'as yet unclassified' }
MASpDescriptionPresenter >> intializePresenters [ 

	self rebuild
]

{ #category : #accessing }
MASpDescriptionPresenter >> labelOrNil [

	self magritteDescription hasLabel ifFalse: [ ^ nil ].
	^ self magritteDescription label
]

{ #category : #accessing }
MASpDescriptionPresenter >> magritteDescription [
	^ description
]

{ #category : #accessing }
MASpDescriptionPresenter >> memento [
	^ memento
]

{ #category : #accessing }
MASpDescriptionPresenter >> model [
	^ self memento model
]

{ #category : #'as yet unclassified' }
MASpDescriptionPresenter >> onValidationError: aBlock addTo: aCollection [
	^ [ aBlock
		on: MAMultipleErrors do: [ :err | aCollection addAll: err collection ] ]
		on: MAValidationError do: [ :err | aCollection add: err ]
]

{ #category : #accessing }
MASpDescriptionPresenter >> parent [ 

	^ parent
]

{ #category : #'as yet unclassified' }
MASpDescriptionPresenter >> rebuild [ 
	
	self magritteDescription ifNil: [ ^ self ].

	self magritteDescription isReadOnly 
		ifTrue: [ self buildAsView ]
		ifFalse: [ self buildAsEditor ].
	
	self layout: self defaultLayout.	
	
]

{ #category : #'as yet unclassified' }
MASpDescriptionPresenter >> rebuildPresenters [ 
	
	self magritteDescription ifNil: [ ^ self ].

	self magritteDescription isReadonly 
		ifTrue: [ self buildAsView ]
		ifFalse: [ self buildAsEditor ].
	
]

{ #category : #accessing }
MASpDescriptionPresenter >> saveAction [

	^ saveAction
]

{ #category : #accessing }
MASpDescriptionPresenter >> saveAction: anObject [

	saveAction := anObject
]

{ #category : #initialization }
MASpDescriptionPresenter >> setDescription: aDescription [
	description := aDescription
]

{ #category : #initialization }
MASpDescriptionPresenter >> setMemento: aMemento [
	memento := aMemento
]

{ #category : #initialization }
MASpDescriptionPresenter >> setParent: aComponent [
	parent := aComponent
]
