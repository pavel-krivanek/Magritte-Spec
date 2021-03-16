Extension { #name : #MAMultipleOptionDescription }

{ #category : #'*Magritte-Spec' }
MAMultipleOptionDescription class >> defaultPresenterClasses [
	^ Array with: MASpMultiselectListPresenter with: MASpCheckboxGroupPresenter with: 
	MASpListCompositionPresenter 
]
