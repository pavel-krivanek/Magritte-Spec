Class {
	#name : #MASpContainerPresenter,
	#superclass : #MASpDescriptionPresenter,
	#instVars : [
		'children',
		'actionButtonsPresenters',
		'errors',
		'showActionButtons'
	],
	#category : #'Magritte-Spec'
}

{ #category : #converting }
MASpContainerPresenter >> buildAsEditor [

	self children withIndexDo: [ :each :index | 
		self additionalSubpresentersMap at: ('child', index asString) asSymbol put: each ].
	
	actionButtonsPresenters := self showActionButtons 
		ifFalse: [ OrderedCollection new ]
		ifTrue: [ 	
			self magritteActionDescriptions collect: [ :anAction |
				SpButtonPresenter new 
					label: anAction label;
					action: [ anAction performOn: self model  ]
				 ] ]

]

{ #category : #converting }
MASpContainerPresenter >> buildChildren [
	^ Array streamContents: [ :stream |
		self magritteDescription do: [ :each |
			each isVisible ifTrue: [
				stream nextPut: (each presenterClass
					memento: self memento
					description: each
					parent: self) ] ] ]
]

{ #category : #converting }
MASpContainerPresenter >> children [ 

	^ children ifNil: [ children := self buildChildren ]
]

{ #category : #converting }
MASpContainerPresenter >> childrenDo: aBlock [ 

	^ self children do: aBlock
]

{ #category : #converting }
MASpContainerPresenter >> commit [
	self withContainersDo: [ :each | each commitMemento ]
]

{ #category : #actions }
MASpContainerPresenter >> commitMemento [
	self memento commit
]

{ #category : #converting }
MASpContainerPresenter >> defaultLayout [ 

	| grid buttonsLayout | 
	grid := SpGridLayout new.
	self children withIndexDo: [ :childPresenter :index | 
		childPresenter labelOrNil ifNotNil: [ :aLabel |
			 grid add: (SpLabelPresenter new label: aLabel, ':') at: 1@index].
		grid add: (SpBoxLayout newHorizontal add: childPresenter; yourself) at: 2@index span: 4@1].
	
	buttonsLayout := SpBoxLayout newHorizontal spacing: 15.
	actionButtonsPresenters do: [ :aPresenter |
		SpBoxLayout newHorizontal add: (
			buttonsLayout add: aPresenter); yourself ].
	
	grid add: buttonsLayout at: 1@(children size+1) span: 5@1.
	
	^ grid
]

{ #category : #converting }
MASpContainerPresenter >> doValidateTo: aCollectionOfErrors [
	self 
		onValidationError: [ self memento validate ] 
		addTo: aCollectionOfErrors.
	self children do: [ :each | 
		self 
			onValidationError: [ each doValidateTo: aCollectionOfErrors ]
			addTo: aCollectionOfErrors ]
]

{ #category : #accessing }
MASpContainerPresenter >> isMagritteContainer [
	^ true
]

{ #category : #converting }
MASpContainerPresenter >> rebuild [ 
	
	self magritteDescription ifNil: [ ^ self ].
	
	self children do: [ :each | each rebuild ].

	self magritteDescription isReadOnly 
		ifTrue: [ self buildAsView ]
		ifFalse: [ self buildAsEditor ].
		
	self layout: self defaultLayout.
]

{ #category : #converting }
MASpContainerPresenter >> rebuild2 [
	
	self rebuildPresenters.
	
	self children do: [ :child |
		child layout: child defaultLayout. ].
		
	self layout: self defaultLayout.
]

{ #category : #converting }
MASpContainerPresenter >> rebuildPresenters [
	
	self magritteDescription ifNil: [ ^ self ].
	
	self children do: [ :each | each rebuildPresenters ].

	self magritteDescription isReadonly 
		ifTrue: [ self buildAsView ]
		ifFalse: [ self buildAsEditor ].
		
]

{ #category : #converting }
MASpContainerPresenter >> save [
	self validate ifFalse: [ ^ self ].
	self commit.
	^ self model
]

{ #category : #converting }
MASpContainerPresenter >> setChildren: aCollection [
	children := aCollection
]

{ #category : #converting }
MASpContainerPresenter >> setDescription: aDescription [
	super setDescription: aDescription.
	self setChildren: self buildChildren.
	self rebuild.
]

{ #category : #accessing }
MASpContainerPresenter >> showActionButtons [

	^ showActionButtons ifNil: [ showActionButtons := false ]
]

{ #category : #accessing }
MASpContainerPresenter >> showActionButtons: anObject [

	showActionButtons := anObject
]

{ #category : #converting }
MASpContainerPresenter >> validate [
	errors := OrderedCollection new.
	self withContainersDo: [ :each | each doValidateTo: errors ].
	^ errors isEmpty
]

{ #category : #accessing }
MASpContainerPresenter >> withContainersDo: aBlock [
	"This does a depth first search through all children and evaluates a block for all container components that have their own memento."
	
	self withContainersDo: aBlock in: self
]

{ #category : #accessing }
MASpContainerPresenter >> withContainersDo: aBlock in: aComponent [
	"This does a depth first search through all children and evaluates a block for all container components that have their own memento."
	
	aComponent childrenDo: [ :each |
		self withContainersDo: aBlock in: each ].
	aComponent isMagritteContainer
		ifTrue: [ aBlock value: aComponent ]
]
