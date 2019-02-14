package main

import (
	"net/http"
	a "restapi/annotation"
	i "restapi/interval"
	o "restapi/organization"
	s "restapi/signal"
	t "restapi/tag"
	u "restapi/user"
	utils "restapi/utils"

	"github.com/gorilla/mux"
)

func main() {
	db := utils.GetConnection()
	defer db.Close()

	router := mux.NewRouter()

	// Annotations
	router.HandleFunc("/annotations/{id}", a.FindAnnotationByID).Methods("GET") //Revoir le format de l'URL /annotations/{id}
	router.HandleFunc("/annotations", a.FindAnnotations).Methods("GET")
	router.HandleFunc("/annotations", a.ModifyAnnotation).Methods("PUT")
	router.HandleFunc("/annotations", a.CreateAnnotation).Methods("POST")
	router.HandleFunc("/annotations/{id}", a.DeleteAnnotation).Methods("DELETE")
	router.HandleFunc("/signal/{id}", s.CheckSignal).Methods("GET")

	// Organizations
	router.HandleFunc("/organizations", o.GetOrganizations).Methods("GET")

	// Tags
	router.HandleFunc("/tags", t.GetTags).Methods("GET")

	// Users
	router.HandleFunc("/users", u.CreateUser).Methods("POST")
	router.HandleFunc("/users", u.GetAllUsers).Methods("GET")
	router.HandleFunc("/users/{id}", u.FindUserByID).Methods("GET")
	router.HandleFunc("/users/{id}", u.DeleteUser).Methods("DELETE")
	router.HandleFunc("/users", u.ModifyUser).Methods("PUT")
	router.HandleFunc("/roles", u.GetAllRoles).Methods("GET")

	// Interval
	router.HandleFunc("/intervals", i.GetIntervals).Methods("GET")
	router.HandleFunc("/intervals", i.CreateInterval).Methods("POST")
	router.HandleFunc("/intervals/comments", i.Comments).Methods("GET")
	router.HandleFunc("/intervals/comments", i.CreateComment).Methods("POST")
	router.HandleFunc("/intervals/all", i.CreateAll).Methods("POST")

	http.ListenAndServe("0.0.0.0:8000", router)
}
