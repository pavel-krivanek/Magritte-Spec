Class {
	#name : #MASpRelationPresenter,
	#superclass : #MASpElementPresenter,
	#instVars : [
		'selected'
	],
	#category : #'Magritte-Spec'
}

{ #category : #accessing }
MASpRelationPresenter >> classes [
	^ self magritteDescription classes
]

{ #category : #accessing }
MASpRelationPresenter >> editorFor: anObject [
	^ anObject asMASpPresenterIn: self application
"		addValidatedForm;"
		yourself
]

{ #category : #accessing }
MASpRelationPresenter >> selected [
	^ selected ifNil: [ selected := self classes
		ifNotEmpty: [ :cls | cls first ] ifEmpty: [ nil ] ]
]

{ #category : #accessing }
MASpRelationPresenter >> selected: aClass [
	selected := aClass
]
