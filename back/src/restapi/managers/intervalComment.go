package managers

import (
	"net/http"
	m "restapi/models"
	u "restapi/utils"
)

// GetAllIntervalsComments list all comments of intervals
func GetAllIntervalsComments(w http.ResponseWriter, r *http.Request) {
	if u.CheckMethodPath("GET", u.CheckRoutes["intervalscomments"], w, r) {
		return
	}
	comments := []m.IntervalComment{}
	if u.CheckErrorCode(u.GetConnection().Set("gorm:auto_preload", true).Find(&comments).Error, w) {
		return
	}
	u.Respond(w, comments)
}
