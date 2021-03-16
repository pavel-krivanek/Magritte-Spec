Class {
	#name : #MASpExampleEditorPresenter,
	#superclass : #MASpPresenter,
	#instVars : [
		'description'
	],
	#category : #'Magritte-Spec'
}

{ #category : #default }
MASpExampleEditorPresenter >> buildEditorFor: anObject titled: aString [

	^ anObject asMASpPresenterIn: self application
		"addValidatedForm;
		addMessage: aString;"
		yourself	
]

{ #category : #default }
MASpExampleEditorPresenter >> defaultDescription [
	self subclassResponsibility
]

{ #category : #default }
MASpExampleEditorPresenter >> magritteDescription [
	^ description ifNil: [ description := self defaultDescription ]
]
