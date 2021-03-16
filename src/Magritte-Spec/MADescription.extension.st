Extension { #name : #MADescription }

{ #category : #'*Magritte-Spec' }
MADescription class >> defaultPresenterClass [
	^ self defaultPresenterClasses isEmpty
		ifTrue: [ MASpUndefinedPresenter ]
		ifFalse: [ self defaultPresenterClasses first ]
]

{ #category : #'*Magritte-Spec' }
MADescription class >> defaultPresenterClasses [

	^ Array with: MASpUndefinedPresenter
]

{ #category : #'*Magritte-Spec' }
MADescription class >> defaultReportColumnClass [
	^ self defaultReportColumnClasses notEmpty
		ifTrue: [ self defaultReportColumnClasses first ]
]

{ #category : #'*Magritte-Spec' }
MADescription class >> defaultReportColumnClasses [
	^ Array with: MASpDescribedColumn
]

{ #category : #'*Magritte-Spec' }
MADescription >> presenterClass [
	^ self propertyAt: #presenterClass ifAbsent: [ self class defaultPresenterClass ]
]

{ #category : #'*Magritte-Spec' }
MADescription >> spReportColumnClass [
	^ self propertyAt: #spReportColumnClass ifAbsent: [ self class defaultReportColumnClass ]
]

{ #category : #'*Magritte-Spec' }
MADescription >> spReportColumnClass: aClass [
	self propertyAt: #spReportColumnClass put: aClass
]
