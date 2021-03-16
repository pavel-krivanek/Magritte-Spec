Class {
	#name : #MASpCommandColumn,
	#superclass : #MASpActionColumn,
	#instVars : [
		'commands'
	],
	#category : #'Magritte-Spec'
}

{ #category : #initialization }
MASpCommandColumn >> addCommand: aBlock text: aString [
	self commands add: aBlock -> aString
]

{ #category : #initialization }
MASpCommandColumn >> addCommandOn: anObject selector: aSelector [
	self addCommandOn: anObject selector: aSelector text: aSelector allButLast asCapitalizedPhrase
]

{ #category : #initialization }
MASpCommandColumn >> addCommandOn: anObject selector: aSelector text: aString [
	self addCommand: (MessageSend receiver: anObject selector: aSelector) text: aString
]

{ #category : #converting }
MASpCommandColumn >> asSpTableColumn [

	^ SpLinkTableColumn 
		title: self label
		evaluated: [ :row | (self accessor read: row) asString ]
		action: [  ].
		
]

{ #category : #initialization }
MASpCommandColumn >> commands [
	^ commands
]

{ #category : #initialization }
MASpCommandColumn >> commands: aCollection [
	commands := aCollection
]

{ #category : #initialization }
MASpCommandColumn >> initialize [
	super initialize.
	self commands: OrderedCollection new
]

{ #category : #testing }
MASpCommandColumn >> isCommandColumn [

	^ true
]
