Extension { #name : #MAElementDescription }

{ #category : #'*Magritte-Spec' }
MAElementDescription >> checkboxLabel [
	^ self propertyAt: #checkboxLabel ifAbsent: [ self label ]
]

{ #category : #'*Magritte-Spec' }
MAElementDescription >> checkboxLabel: aString [
	self propertyAt: #checkboxLabel put: aString
]
