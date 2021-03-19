Class {
	#name : #MASpMultiselectListPresenter,
	#superclass : #MASpMultipleSelectionPresenter,
	#category : #'Magritte-Spec'
}

{ #category : #converting }
MASpMultiselectListPresenter >> buildAsEditor [

	element := self newList 
		items: self availableList;
		beMultipleSelection;
		selectItems: self selectedList;
		yourself.
		
	element addStyle: 'minHeight200'.
	
	element
		whenBuiltDo: [ :w | 
			self application backend class name = #SpecGtkBackend
				ifTrue: [ | provider context |
					provider := GtkCssProvider
						newFromString: 'box * {min-height: 200px}'.
					context := w widget styleContext.
					context addProvider: provider ] ]
]
