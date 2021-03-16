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
]
