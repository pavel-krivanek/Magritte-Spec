Class {
	#name : #MASpColumn,
	#superclass : #MAObject,
	#instVars : [
		'report',
		'accessor'
	],
	#category : #'Magritte-Spec'
}

{ #category : #testing }
MASpColumn class >> isAbstract [
	^ false
]

{ #category : #'accessing - settings' }
MASpColumn >> accessor [
	^ accessor
]

{ #category : #'accessing - settings' }
MASpColumn >> accessor: anAccessor [
	"Set the accessor used to get the column value for a given row object."

	accessor := anAccessor asAccessor
]

{ #category : #converting }
MASpColumn >> asSpTableColumn [

	^ SpStringTableColumn 
		title: self label
		evaluated: [ :row | (self accessor read: row) asString ]
]

{ #category : #accessing }
MASpColumn >> column [
	^ self report cache collect: [ :each | self valueFor: each ]
]

{ #category : #'accessing - settings' }
MASpColumn >> comment [
	^ self propertyAt: #comment ifAbsent: [ self defaultComment ]
]

{ #category : #'accessing - settings' }
MASpColumn >> comment: aString [
	"A descriptive comment of this column."

	self propertyAt: #comment put: aString
]

{ #category : #'accessing - defaults' }
MASpColumn >> defaultComment [
	^ nil
]

{ #category : #'accessing - defaults' }
MASpColumn >> defaultFilter [
	^ false
]

{ #category : #'accessing - defaults' }
MASpColumn >> defaultFooter [
	^ nil
]

{ #category : #'accessing - defaults' }
MASpColumn >> defaultFormatter [
	^ MessageSend receiver: self selector: #stringFor:
]

{ #category : #'accessing - defaults' }
MASpColumn >> defaultLabel [
	^ self accessor selector asCapitalizedPhrase
]

{ #category : #'accessing - defaults' }
MASpColumn >> defaultRenderer [
	^ MessageSend receiver: self selector: #renderCellContent:on:
]

{ #category : #'accessing - defaults' }
MASpColumn >> defaultSorter [
	^ [ :a :b | self sort: a and: b ]
]

{ #category : #'accessing - defaults' }
MASpColumn >> defaultVisible [
	^ true
]

{ #category : #'accessing - magritte' }
MASpColumn >> descriptionComment [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #comment;
		label: 'Comment';
		priority: 200;
		yourself
]

{ #category : #'accessing - magritte' }
MASpColumn >> descriptionTitle [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #title;
		label: 'Title';
		priority: 100;
		yourself
]

{ #category : #exporting }
MASpColumn >> exportContent: anObject index: aNumber on: aStream [
	| string |
	string := (self formatter value: anObject) collect: [ :char | 
		char isSeparator
			ifTrue: [ Character space ]
			ifFalse: [ char ] ].
	aStream nextPutAll: string
]

{ #category : #exporting }
MASpColumn >> exportHeadOn: aStream [
	self label isNil
		ifFalse: [ aStream nextPutAll: self label ]
]

{ #category : #'accessing - settings' }
MASpColumn >> filter [
	^ self propertyAt: #filter ifAbsent: [ self defaultFilter ]
]

{ #category : #'accessing - settings' }
MASpColumn >> filter: aBoolean [
	"Enable or disable filtering of this column."

	self propertyAt: #filter put: aBoolean
]

{ #category : #private }
MASpColumn >> filterBlock [
	^ self 
		propertyAt: #filterValue
		ifPresent: [ :value | [ :row | (self valueFor: row) = value ] ]
]

{ #category : #'accessing - settings' }
MASpColumn >> footer [
	^ self propertyAt: #footer ifAbsent: [ self defaultFooter ]
]

{ #category : #'accessing - settings' }
MASpColumn >> footer: aBlock [
	"A block that renders the footer of this column."
	
	self propertyAt: #footer put: aBlock
]

{ #category : #'accessing - settings' }
MASpColumn >> formatter [
	^ self propertyAt: #formatter ifAbsent: [ self defaultFormatter ]
]

{ #category : #'accessing - settings' }
MASpColumn >> formatter: aBlock [
	"A block that converts the row value to a string."
	
	self propertyAt: #formatter put: aBlock
]

{ #category : #accessing }
MASpColumn >> index [
	^ self report columns indexOf: self
]

{ #category : #initialization }
MASpColumn >> initialize [
	super initialize.
	self accessor: #yourself
]

{ #category : #testing }
MASpColumn >> isCommandColumn [

	^ false
]

{ #category : #testing }
MASpColumn >> isFiltered [
	^ self filter
]

{ #category : #testing }
MASpColumn >> isReversed [
	^ self report sortReversed
]

{ #category : #testing }
MASpColumn >> isSortable [
	^ self report sortEnabled and: [ self sorter notNil ]
]

{ #category : #testing }
MASpColumn >> isSorted [
	^ self report sortColumn == self
]

{ #category : #testing }
MASpColumn >> isVisible [
	^ self visible
]

{ #category : #'accessing - settings' }
MASpColumn >> label [
	^ self propertyAt: #label ifAbsent: [ self defaultLabel ]
]

{ #category : #'accessing - settings' }
MASpColumn >> label: aString [
	"The label of this column, also used to toggle the sort order of this column."
	
	self propertyAt: #label put: aString
]

{ #category : #actions }
MASpColumn >> refresh [
	self properties removeKey: #uniqueValues ifAbsent: [ ]
]

{ #category : #'accessing - settings' }
MASpColumn >> renderer [
	^ self propertyAt: #renderer ifAbsent: [ self defaultRenderer ]
]

{ #category : #'accessing - settings' }
MASpColumn >> renderer: aBlock [
	"A block that renders the row value to HTML."

	self propertyAt: #renderer put: aBlock
]

{ #category : #accessing }
MASpColumn >> report [
	^ report
]

{ #category : #initialization }
MASpColumn >> setReport: aReport [
	report := aReport
]

{ #category : #private }
MASpColumn >> sort: aFirstObject and: aSecondObject [
	| one two |
	one := self valueFor: aFirstObject.
	two := self valueFor: aSecondObject.
	(one respondsTo: #<=) ifFalse: [
		one := self formatter value: one.
		two := self formatter value: two ].
	^ one <= two
]

{ #category : #private }
MASpColumn >> sortRows: aCollection [
	| result |
	result := SortedCollection new: aCollection size.
	result
		sortBlock: self sorter;
		addAll: aCollection.
	^ self isReversed
		ifFalse: [ result ]
		ifTrue: [ result reverse ]
]

{ #category : #'accessing - settings' }
MASpColumn >> sorter [
	^ self propertyAt: #sorter ifAbsent: [ self defaultSorter ]
]

{ #category : #'accessing - settings' }
MASpColumn >> sorter: aBlock [
	"A sort block for this column."

	self propertyAt: #sorter put: aBlock
]

{ #category : #accessing }
MASpColumn >> sorterStyle [
	^ self isSorted
		ifTrue: [
			self isReversed
				ifTrue: [ self report sorterStyles second ]
				ifFalse: [ self report sorterStyles first ] ]
		ifFalse: [ String new ]
]

{ #category : #private }
MASpColumn >> stringFor: anObject [ 
	"Answer a string representation of the row value."
	^ anObject greaseString
]

{ #category : #accessing }
MASpColumn >> tableDataClass [
	^ nil
]

{ #category : #accessing }
MASpColumn >> tableHeadingClass [
	^ nil
]

{ #category : #private }
MASpColumn >> uniqueValues [
	"Answer the unique rows with the unique values, used for filtering."

	^ self propertyAt: #uniqueValues ifAbsentPut: [
		| uniqueValues |
		uniqueValues := Dictionary new.
		self report rows
			do: [ :row | uniqueValues at: (self valueFor: row) put: row ].
		uniqueValues := uniqueValues values asArray.
		self sorter isNil
			ifFalse: [ uniqueValues sort: self sorter ].
		uniqueValues
			collect: [ :row | self valueFor: row ] ]
]

{ #category : #actions }
MASpColumn >> valueFor: aRow [
	"Answer the column value for aRow."

	^ accessor read: aRow
]

{ #category : #'accessing - settings' }
MASpColumn >> visible [
	^ self propertyAt: #visible ifAbsent: [ self defaultVisible ]
]

{ #category : #'accessing - settings' }
MASpColumn >> visible: aBoolean [
	"Make this column visible or invisible."
	
	self propertyAt: #visible put: aBoolean
]
