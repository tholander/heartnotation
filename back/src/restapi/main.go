package main

import (
	"net/http"
	m "restapi/managers"
	utils "restapi/utils"

	"github.com/gorilla/mux"
)

func main() {
	db := utils.GetConnection()
	defer db.Close()

	router := mux.NewRouter()

	router.HandleFunc("/users", m.GetAllUsers).Methods("GET")
	router.HandleFunc("/intervals", m.GetAllIntervals).Methods("GET")
	/*
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
		router.HandleFunc("/intervals", i.GetInterval).Methods("GET")
		router.HandleFunc("/intervals", i.CreateInterval).Methods("POST")
		router.HandleFunc("/intervals/tags", i.CreateIntervalTag).Methods("POST")
		router.HandleFunc("/intervals/comment/{id}", i.GetIntervalComment).Methods("GET")
		router.HandleFunc("/intervals/comment", i.CreateComment).Methods("POST")
	*/
	http.ListenAndServe("0.0.0.0:8000", router)
}
