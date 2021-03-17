"
```
app := SpApplication new.
app useBackend: #Gtk.
editor := MASpDescriptionEditorPresenter newApplication: app.
editor description: MAStringDescription new magritteDescription.
editor openWithSpec.
```
"
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

{ #category : #accessing }
MASpExampleEditorPresenter >> description [

	^ description
]

{ #category : #accessing }
MASpExampleEditorPresenter >> description: anObject [

	description := anObject.
	self refresh.

]

{ #category : #default }
MASpExampleEditorPresenter >> magritteDescription [
	^ description ifNil: [ description := self defaultDescription ]
]

{ #category : #default }
MASpExampleEditorPresenter >> refresh [ 


]
