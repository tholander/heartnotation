package annotation

import "time"

type Annotation struct {
	IDAnnotation     int
	IDSignal         int16
	Comment          string
	CreationDate     time.Time
	EditDate         time.Time
	Status           string
	BasedAnnotation  int
	OrganizationName string
}
