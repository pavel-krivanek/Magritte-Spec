Extension { #name : #MAContainer }

{ #category : #'*Magritte-Spec' }
MAContainer >> asComponentOn: anObject [
	^ self presenterClass
		memento: (anObject mementoClass
			model: anObject
			description: self)
]

{ #category : #'*Magritte-Spec' }
MAContainer >> asMASpPresenterOn: anObject [
	^ self presenterClass
		memento: (anObject mementoClass
			model: anObject
			description: self)
]

{ #category : #'*Magritte-Spec' }
MAContainer >> asMASpPresenterOn: anObject in: anApplication [
	^ self presenterClass
		memento: (anObject mementoClass
			model: anObject
			description: self)
		in: anApplication
]

{ #category : #'*Magritte-Spec' }
MAContainer class >> defaultPresenterClasses [
	^ Array with: MASpContainerPresenter
]
