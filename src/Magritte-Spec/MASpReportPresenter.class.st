Class {
	#name : #MASpReportPresenter,
	#superclass : #MASpPresenter,
	#instVars : [
		'rows',
		'cache',
		'columns',
		'properties',
		'backtracked',
		'table'
	],
	#category : #'Magritte-Spec'
}

{ #category : #'as yet unclassified' }
MASpReportPresenter class >> defaultSpec [ 

	^ SpBoxLayout newVertical add: #table
]

{ #category : #'as yet unclassified' }
MASpReportPresenter class >> isAbstract [
	^ false
]

{ #category : #'as yet unclassified' }
MASpReportPresenter class >> rows: aCollection [
	^ self new
		rows: aCollection;
		yourself
]

{ #category : #'as yet unclassified' }
MASpReportPresenter class >> rows: aCollection description: aDescription [
	| report |
	report := self rows: aCollection.
	aDescription asContainer do: [ :each |
		report addColumnDescription: each ].
	^ report
]

{ #category : #columns }
MASpReportPresenter >> addColumn: aColumn [
	columns := columns copyWith: aColumn.
	^ aColumn setReport: self; yourself
]

{ #category : #columns }
MASpReportPresenter >> addColumnCascade: anArray [
	^ (self addColumn: MASpColumn new)
		accessor: anArray;
		yourself
]

{ #category : #columns }
MASpReportPresenter >> addColumnDescription: aDescription [
	^ self addColumn: (aDescription spReportColumnClass new
		magritteDescription: aDescription;
		yourself)
]

{ #category : #columns }
MASpReportPresenter >> addColumnSelector: aSelector [
	^ (self addColumn: MASpColumn new)
		selector: aSelector;
		yourself
]

{ #category : #'private - batch' }
MASpReportPresenter >> batchEndIndex [
	^ self batchPage * self batchSize min: self cache size
]

{ #category : #'private - batch' }
MASpReportPresenter >> batchMaxPages [
	^ (self cache size / self batchSize)
		ceiling
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> batchPage [
	^ backtracked at: #batchPage ifAbsentPut: [ self defaultBatchPage ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> batchPage: anInteger [
	backtracked at: #batchPage put: anInteger
]

{ #category : #'private - batch' }
MASpReportPresenter >> batchPageRange [
	^ self batchPageRangeStart to: self batchPageRangeEnd
]

{ #category : #'private - batch' }
MASpReportPresenter >> batchPageRangeEnd [
	^ self batchMaxPages min: self batchPage + 9
]

{ #category : #'private - batch' }
MASpReportPresenter >> batchPageRangeStart [
	^ self defaultBatchPage max: self batchPage - 9
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> batchSize [
	^ properties at: #batchSize ifAbsent: [ self defaultBatchSize ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> batchSize: anInteger [
	properties at: #batchSize put: anInteger
]

{ #category : #'private - batch' }
MASpReportPresenter >> batchStartIndex [
	^ (self batchPage - 1) * self batchSize + 1
]

{ #category : #'accessing - readonly' }
MASpReportPresenter >> cache [
	"Return the cached rows of the receiver, these rows are filtered and sorted."

	cache isNil ifTrue: [
		self cache: (self
			sortRows: (self
				filterRows: self
					rows asArray)) ].
	^ cache
]

{ #category : #'accessing - readonly' }
MASpReportPresenter >> cache: aCollection [
	cache := aCollection
]

{ #category : #'accessing - readonly' }
MASpReportPresenter >> columns [
	^ columns
]

{ #category : #'accessing - readonly' }
MASpReportPresenter >> columns: aCollection [
	columns := aCollection
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultBatchPage [
	^ 1
]

{ #category : #accessing }
MASpReportPresenter >> defaultLayout [ 

	^ SpBoxLayout newVertical
		add: #table
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultRowFilter [
	^ nil
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultRowPeriod [
	^ 1
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultRowStyles [
	^ Array with: 'odd' with: 'even'
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultShowBatch [
	^ false
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultShowBatchFirstLast [
	^ false
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultShowBatchPages [
	^ true
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultShowBatchPreviousNext [
	^ true
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultShowBody [
	^ true
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultShowCaption [
	^ false
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultShowFilter [
	^ false
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultShowFooter [
	^ false
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultShowHeader [
	^ true
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultShowSummary [
	^ false
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultSortColumn [
	^ nil
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultSortEnabled [
	^ true
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultSortReversed [
	^ false
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultSorterStyles [
	^ Array with: 'ascending' with: 'descending'
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultTableCaption [
	^ nil
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultTableEmpty [
	^ 'The report is empty.'
]

{ #category : #'accessing - defaults' }
MASpReportPresenter >> defaultTableSummary [
	^ nil
]

{ #category : #exporting }
MASpReportPresenter >> export [
	^ String streamContents: [ :stream |
		self exportOn: stream ]
]

{ #category : #exporting }
MASpReportPresenter >> exportBodyOn: aStream [
	self cache keysAndValuesDo: [ :index :row |
		self visibleColumns
			do: [ :column |
				column
					exportContent: (column valueFor: row)
					index: index on: aStream ]
			separatedBy: [ aStream tab ].
		aStream nextPut: Character cr ]
]

{ #category : #exporting }
MASpReportPresenter >> exportHeaderOn: aStream [
	self visibleColumns
		do: [ :each | each exportHeadOn: aStream ]
		separatedBy: [ aStream tab ].
	aStream nextPut: Character cr
]

{ #category : #exporting }
MASpReportPresenter >> exportOn: aStream [
	self showHeader
		ifTrue: [ self exportHeaderOn: aStream ].
	self showBody
		ifTrue: [ self exportBodyOn: aStream ]
]

{ #category : #private }
MASpReportPresenter >> filterRows: aCollection [
	| filters filter |
	filters := OrderedCollection new.
	self hasRowFilter
		ifTrue: [ filters add: self rowFilter ].
	self columns do: [ :each |
		each isFiltered ifTrue: [
			filter := each filterBlock.
			filter isNil
				ifFalse: [ filters add: filter ] ] ].
	^ filters isEmpty
		ifTrue: [ aCollection ]
		ifFalse: [ aCollection select: [ :row | filters allSatisfy: [ :block | block value: row ] ] ]
]

{ #category : #testing }
MASpReportPresenter >> hasMoreThanOnePage [
	^self batchSize < self cache size
]

{ #category : #testing }
MASpReportPresenter >> hasRowFilter [
	^ self rowFilter notNil
]

{ #category : #initialization }
MASpReportPresenter >> initialize [

	rows := columns := Array new.
	properties := Dictionary new.
	backtracked := Dictionary new.
	
	super initialize.

]

{ #category : #initialization }
MASpReportPresenter >> initializePresenters [ 

	super initializePresenters.
	
	table := self newTreeTable.
	
	table
		addColumn: (SpStringTableColumn evaluated: #asString)
		"		children: [ :node | node subResults ]"
"		contextMenu: [ (self rootCommandsGroup / 'Results tools') beRoot asMenuPresenter ]"
]

{ #category : #'private - batch' }
MASpReportPresenter >> isOnFirstPage [
	^ self batchPage = 1
]

{ #category : #'private - batch' }
MASpReportPresenter >> isOnLastPage [
	^ self batchPage = self batchMaxPages
]

{ #category : #testing }
MASpReportPresenter >> isSorted [
	^ self sortColumn notNil
]

{ #category : #columns }
MASpReportPresenter >> moveDown: aColumn [
	| index |
	index := self columns indexOf: aColumn ifAbsent: [ ^ self ].
	self columns swap: index with: (index = self size
		ifFalse:[ index + 1 ]
		ifTrue: [ 1 ])
]

{ #category : #columns }
MASpReportPresenter >> moveUp: aColumn [
	| index |
	index := self columns indexOf: aColumn ifAbsent: [ ^ self ].
	self columns swap: index with: (index = 1
		ifFalse:[ index - 1 ]
		ifTrue: [ self size ])
]

{ #category : #actions }
MASpReportPresenter >> nextPage [
	self isOnLastPage
		ifFalse: [ self batchPage: self batchPage + 1 ]
]

{ #category : #actions }
MASpReportPresenter >> previousPage [
	self isOnFirstPage
		ifFalse: [ self batchPage: self batchPage - 1 ]
]

{ #category : #actions }
MASpReportPresenter >> refresh [
	
	| nonCommandColumns commandColumns menu |
	
	nonCommandColumns := self columns reject: [ :each | each isCommandColumn ].
	commandColumns := self columns select: [ :each | each isCommandColumn ].
	
	table columns: OrderedCollection new.
	table roots: self rows.
		
	nonCommandColumns do: [ :aColumn |
		table addColumn: aColumn asSpTableColumn
	].

	menu := self newMenu.
	commandColumns do: [ :aColumn  |
			aColumn commands do: [ :aCommand | 
				menu addItem: [ :anItem | 
			anItem
				name: aCommand value;
				action: [ aCommand key value: table selectedItem ] ]]].
	
	table contextMenu: menu.

	self cache: nil; batchPage: self defaultBatchPage.
	self columns do: [ :each | each refresh ]
]

{ #category : #columns }
MASpReportPresenter >> remove: aColumn [
	columns := columns copyWithout: aColumn
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> rowFilter [
	^ backtracked at: #rowFilter ifAbsent: [ self defaultRowFilter ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> rowFilter: aBlock [
	backtracked at: #rowFilter put: aBlock.
	self refresh
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> rowPeriod [
	^ properties at: #rowPeriod ifAbsent: [ self defaultRowPeriod ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> rowPeriod: aNumber [
	properties at: #rowPeriod put: aNumber
]

{ #category : #private }
MASpReportPresenter >> rowStyleForNumber: aNumber [
	^ self rowStyles
		at: ((aNumber - 1 // self rowPeriod) \\ self rowStyles size) + 1
		ifAbsent: [ String new ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> rowStyles [
	^ properties at: #rowStyles ifAbsent: [ self defaultRowStyles ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> rowStyles: aCollection [
	properties at: #rowStyles put: aCollection
]

{ #category : #acessing }
MASpReportPresenter >> rows [
	"Return the rows of the receiver."

	^ rows
]

{ #category : #acessing }
MASpReportPresenter >> rows: aCollection [
	"Set the rows of the receiver."
	
	rows := aCollection ifNil: [ Array new ].
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> showBatch [
	^ properties at: #showBatch ifAbsent: [ self defaultShowBatch ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> showBatch: aBoolean [
	properties at: #showBatch put: aBoolean
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> showBatchFirstLast [
	^ properties at: #showBatchFirstLast ifAbsent: [ self defaultShowBatchFirstLast ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> showBatchFirstLast: aBoolean [
	properties at: #showBatchFirstLast put: aBoolean
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> showBatchPages [
	^ properties at: #showBatchPages ifAbsent: [ self defaultShowBatchPages ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> showBatchPages: aBoolean [
	properties at: #showBatchPages put: aBoolean
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> showBatchPreviousNext [
	^ properties at: #showBatchPreviousNext ifAbsent: [ self defaultShowBatchPreviousNext ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> showBatchPreviousNext: aBoolean [
	properties at: #showBatchPreviousNext put: aBoolean
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> showBody [
	^ properties at: #showBody ifAbsent: [ self defaultShowBody ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> showBody: aBoolean [
	properties at: #showBody put: aBoolean
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> showCaption [
	^ properties at: #showCaption ifAbsent: [ self defaultShowCaption ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> showCaption: aBoolean [
	properties at: #showCaption put: aBoolean
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> showFilter [
	^ properties at: #showFilter ifAbsent: [ self defaultShowFilter ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> showFilter: aBoolean [
	properties at: #showFilter put: aBoolean
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> showFooter [
	^ properties at: #showFooter ifAbsent: [ self defaultShowFooter ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> showFooter: aBoolean [
	properties at: #showFooter put: aBoolean
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> showHeader [
	^ properties at: #showHeader ifAbsent: [ self defaultShowHeader ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> showHeader: aBoolean [
	properties at: #showHeader put: aBoolean
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> showSummary [
	^ properties at: #showSummary ifAbsent: [ self defaultShowSummary ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> showSummary: aBoolean [
	properties at: #showSummary put: aBoolean
]

{ #category : #actions }
MASpReportPresenter >> sort: aColumn [
	aColumn = self sortColumn
		ifTrue: [
			self sortReversed
				ifFalse: [ self sortReversed: true ]
				ifTrue: [ self sortColumn: nil; sortReversed: false ] ]
		ifFalse: [ self sortColumn: aColumn; sortReversed: false ].
	self refresh
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> sortColumn [
	^ backtracked at: #sortColumn ifAbsent: [ self defaultSortColumn ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> sortColumn: aColumn [
	backtracked at: #sortColumn put: aColumn
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> sortEnabled [
	^ properties at: #sortEnabled ifAbsent: [ self defaultSortEnabled ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> sortEnabled: aBoolean [
	properties at: #sortEnabled put: aBoolean
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> sortReversed [
	^ backtracked at: #sortReversed ifAbsent: [ self defaultSortReversed ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> sortReversed: aBoolean [
	backtracked at: #sortReversed put: aBoolean
]

{ #category : #private }
MASpReportPresenter >> sortRows: aCollection [
	^ self isSorted
		ifFalse: [ aCollection ]
		ifTrue: [ self sortColumn sortRows: aCollection ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> sorterStyles [
	^ properties at: #sorterStyles ifAbsent: [ self defaultSorterStyles ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> sorterStyles: aCollection [
	properties at: #sorterStyles put: aCollection
]

{ #category : #'accessing - readonly' }
MASpReportPresenter >> states [
	^ Array with: backtracked
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> tableCaption [
	^ properties at: #tableCaption ifAbsent: [ self defaultTableCaption ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> tableCaption: aString [
	properties at: #tableCaption put: aString
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> tableEmpty [
	^ properties at: #tableEmpty ifAbsent: [ self defaultTableEmpty ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> tableEmpty: aString [
	properties at: #tableEmpty put: aString
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> tableSummary [
	^ properties at: #tableSummary ifAbsent: [ self defaultTableSummary ]
]

{ #category : #'accessing - settings' }
MASpReportPresenter >> tableSummary: aString [
	properties at: #tableSummary put: aString
]

{ #category : #'accessing - readonly' }
MASpReportPresenter >> visible [
	^ self showBatch
		ifFalse: [ self cache ]
		ifTrue: [
			self cache
				copyFrom: self batchStartIndex
				to: self batchEndIndex ]
]

{ #category : #'accessing - readonly' }
MASpReportPresenter >> visibleColumns [
	^ self columns select: [ :each | each isVisible ]
]
