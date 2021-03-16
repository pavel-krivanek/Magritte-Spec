Extension { #name : #Object }

{ #category : #'*Magritte-Spec' }
Object >> asMASpPresenterIn: anApplication [
	^ self magritteDescription asMASpPresenterOn: self in: anApplication
]
