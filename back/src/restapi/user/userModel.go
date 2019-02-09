package user

// Profile represent a user in database
type Profile struct {
	ID       uint   `gorm:"AUTO_INCREMENT" json:"id"`
	Mail     string `gorm:"type:varchar(100);unique_index" json:"mail"`
	Role     Role   `gorm:"foreignkey:RoleID" json:"role"`
	RoleID   uint   `json:"role_id"`
	IsActive bool   `json:"is_active"`
}

// TableName sets table name of the struct
func (Profile) TableName() string {
	return "userprofile"
}

// Role represent a role in database
type Role struct {
	ID       uint   `gorm:"AUTO_INCREMENT" json:"id"`
	Name     string `json:"name"`
	IsActive bool   `json:"is_active"`
}

// TableName sets table name of the struct
func (Role) TableName() string {
	return "userrole"
}
