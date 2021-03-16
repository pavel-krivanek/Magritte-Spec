Class {
	#name : #MASpExternalEditorPresenter,
	#superclass : #MASpOneToOnePresenter,
	#instVars : [
		'referenceLabel',
		'editButton',
		'removeButton',
		'select',
		'createButton'
	],
	#category : #'Magritte-Spec'
}

{ #category : #converting }
MASpExternalEditorPresenter >> buildAsEditor [

	self value isNil
		ifTrue: [ ^ self buildAsSelectList ].

	referenceLabel := self newLabel label: (self reference toString: self value).
	
	editButton := self newButton 
		label: 'Edit';
		action: [ self edit ].
	
	removeButton := self newButton 
		label: 'Remove';
		action: [
			self remove.
			self buildAsEditor.
			self redefineLayout ]
]

{ #category : #converting }
MASpExternalEditorPresenter >> buildAsSelectList [

	select := self newDropList.
	select 
		items: self classes asOrderedCollection;
		selectItem: self selected;
		whenSelectedItemChangedDo: [ :anOption |
			self selected: anOption  ].
		
	createButton := self newButton 
		label: 'Create';
		action: [ self create ].
]

{ #category : #'instance creation' }
MASpExternalEditorPresenter >> create [
	
	| anEditor closedAsSave |
	closedAsSave := false.
	anEditor := self editorFor: self selected new.
	anEditor saveAction: [ closedAsSave := true ].
	self application 
		openModal: anEditor
		withSpecLayout: anEditor retrieveDefaultSpec.

	closedAsSave ifTrue: [
		self value: anEditor model ].
	
	self buildAsEditor.
	self redefineLayout
]

{ #category : #converting }
MASpExternalEditorPresenter >> defaultLayout [ 

	self value ifNil: [ ^ self selectListLayout ].

	^ SpBoxLayout newHorizontal
		spacing: 10;
		beNotHomogeneous;
		add: #referenceLabel;
		add: #editButton;
		add: #removeButton
]

{ #category : #'instance creation' }
MASpExternalEditorPresenter >> editorFor: anObject [
	^ anObject asMASpPresenterIn: self application
		"addValidatedForm;"
		yourself
]

{ #category : #converting }
MASpExternalEditorPresenter >> intializePresenters [ 

	self rebuild
]

{ #category : #converting }
MASpExternalEditorPresenter >> selectListLayout [

	^ SpBoxLayout newHorizontal
		spacing: 10;
		beNotHomogeneous;
		add: #select;
		add: #createButton.
]
