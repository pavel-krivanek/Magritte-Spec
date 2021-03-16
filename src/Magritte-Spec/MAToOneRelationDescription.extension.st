Extension { #name : #MAToOneRelationDescription }

{ #category : #'*Magritte-Spec' }
MAToOneRelationDescription class >> defaultPresenterClasses [
	^ Array with: MASpExternalEditorPresenter with: MASpInternalEditorPresenter 
]
