"
```
GtkApplication ensureRunning.
app := SpApplication new.
conf := SpGtkConfiguration new.
conf addCSSProviderFromString: '
.minHeight200 { min-height: 200px }
' withBlanksCondensed.
app useBackend: #Gtk with: conf.
editor := MASpDescriptionEditorPresenter newApplication: app.
editor description: MAStringDescription new magritteDescription.
editor openWithSpec.
```



report := MASpDescriptionEditorPresenter new.
report openWithSpec.



app := SpApplication new.
app useBackend: #Gtk.
report := MASpDescriptionEditorPresenter newApplication: app.
report openWithSpec.
"
Class {
	#name : #MASpDescriptionEditorPresenter,
	#superclass : #MASpExampleEditorPresenter,
	#instVars : [
		'report',
		'selected',
		'selectedPresenter',
		'addButton',
		'editButton',
		'previewButton',
		'example'
	],
	#category : #'Magritte-Spec'
}

{ #category : #'as yet unclassified' }
MASpDescriptionEditorPresenter >> addDescription: aDescription [

	| p | 
	p := aDescription asMASpPresenterIn: self application.
	p openModalWithSpec.
	
	p commit.
	self magritteDescription add: aDescription.
	
	report := self buildReport.
	layout := self defaultLayout.


	"self
		show: (self buildEditorFor: aDescription titled: 'Add ' , aDescription class label)
		onAnswer: [ :element | element isNil ifFalse: [ self appendDescription: element ] ]"
]

{ #category : #'as yet unclassified' }
MASpDescriptionEditorPresenter >> buildReport [
	^ (MASpReportPresenter rows: self magritteDescription children description: MAElementDescription new magritteDescription)
		addColumn: (MASpColumn new
			accessor: #( magritteDescription label );
			label: 'Kind';
			yourself);
		addColumn: (MASpCommandColumn new
			addCommandOn: self selector: #editDescription: text: 'edit';
			addCommandOn: self selector: #moveUp: text: 'up';
			addCommandOn: self selector: #moveDown: text: 'down';
			addCommandOn: self selector: #removeDescription: text: 'remove';
			yourself);
		refresh;
		yourself
]

{ #category : #'as yet unclassified' }
MASpDescriptionEditorPresenter >> defaultDescription [
	^ MAContainer new
]

{ #category : #'as yet unclassified' }
MASpDescriptionEditorPresenter >> defaultExampleInstance [
	^ MAAdaptiveModel description: self magritteDescription
]

{ #category : #accessing }
MASpDescriptionEditorPresenter >> defaultLayout [ 

	^ SpBoxLayout newVertical
		borderWidth: 15; 
		spacing: 10;
		add: #report expand: true;
		add: #selectedPresenter expand: false;
		add: (
			SpBoxLayout newHorizontal 
				spacing: 10;
					add: #addButton;
					add: #editButton;
					add: #previewButton)  expand: false
]

{ #category : #'as yet unclassified' }
MASpDescriptionEditorPresenter >> editDescription: aDescription [

	| p result closedAsSave | 

	closedAsSave := false.
	p := aDescription asMASpPresenterIn: self application.
	p saveAction: [ closedAsSave := true ].
		
	p openModalWithSpec.
	
	closedAsSave ifFalse: [ ^ self ].

	report := self buildReport.
	layout := self defaultLayout.

"	self
		show: (self
			buildEditorFor: aDescription
			titled: 'Edit ' , aDescription class label)
		onAnswer: [ self refresh ]"
]

{ #category : #'as yet unclassified' }
MASpDescriptionEditorPresenter >> example [
	^ example ifNil: [ example := self defaultExampleInstance ]
]

{ #category : #'as yet unclassified' }
MASpDescriptionEditorPresenter >> initializePresenters [ 

	super initializePresenters.
	
	selected := MADescriptionHolder new.
	selectedPresenter := selected asMASpPresenterIn: self application.

	addButton := self newButton 
		label: 'Add';
		action: [ 
			selectedPresenter save.
			selected inspect.
			selected contents isNil
				ifFalse: [ self addDescription: selected contents new ]  ].

	editButton := self newButton 
		label: 'Edit';
		action: [self show: (self
			buildEditorFor: description
			titled: 'Edit Container')].
	
	previewButton := self newButton 
		label: 'Preview';
		action: [
			self preview ].
	
	
			
	
	self refresh
]

{ #category : #'as yet unclassified' }
MASpDescriptionEditorPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.

	aWindowPresenter
		title: 'Description editor';
		initialExtent: (1023@768)
		
]

{ #category : #'as yet unclassified' }
MASpDescriptionEditorPresenter >> moveDown: aDescription [
	self magritteDescription moveDown: aDescription.
	self refresh
]

{ #category : #'as yet unclassified' }
MASpDescriptionEditorPresenter >> moveUp: aDescription [
	self magritteDescription moveUp: aDescription.
	self refresh
]

{ #category : #'as yet unclassified' }
MASpDescriptionEditorPresenter >> preview [
	| p anExample | 
	
	anExample := self example.
	p := anExample asMASpPresenterIn: self application.
	p openModalWithSpec.
	
	report := self buildReport.
	layout := self defaultLayout.

"addMessage: self magritteDescription label;"
]

{ #category : #'as yet unclassified' }
MASpDescriptionEditorPresenter >> refresh [ 
	
	report := self buildReport.
	layout := self defaultLayout.

]

{ #category : #removing }
MASpDescriptionEditorPresenter >> removeDescription: aDescription [
	self magritteDescription remove: aDescription.
	self refresh
]
