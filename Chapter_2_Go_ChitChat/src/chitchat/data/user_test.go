package data

import (
	"database/sql"
	"testing"
)

func Test_UserCreate(t *testing.T) {
	setup()
	if err := users[0].Create(); err != nil {
		t.Error(err, "t_uc: Cannot create user.")
	}
	if users[0].Id == 0 {
		t.Errorf("t_uc: No id or created_at in user")
	}
	u, err := UserByEmail(users[0].Email)
	if err != nil {
		t.Error(err, "t_uc: User not created.")
	}
	if users[0].Email != u.Email {
		t.Errorf("User retrieved is not the same as the one created.")
	}
}

func Test_UserDelete(t *testing.T) {
	setup()
	if err := users[0].Create(); err != nil {
		t.Error(err, "t_ud: Cannot create user.")
	}
	if err := users[0].Delete(); err != nil {
		t.Error(err, "- t_ud: Cannot delete user")
	}
	_, err := UserByEmail(users[0].Email)
	if err != sql.ErrNoRows {
		t.Error(err, "- User not deleted.")
	}
}

func Test_UserUpdate(t *testing.T) {
	setup()
	if err := users[0].Create(); err != nil {
		t.Error(err, "t_uu: Cannot create user.")
	}
	users[0].Name = "Random User"
	if err := users[0].Update(); err != nil {
		t.Error(err, "- t_uu: Cannot update user")
	}
	u, err := UserByEmail(users[0].Email)
	if err != nil {
		t.Error(err, "- t_uu: Cannot get user")
	}
	if u.Name != "Random User" {
		t.Error(err, "- User not updated")
	}
}

func Test_UserByUUID(t *testing.T) {
	setup()
	if err := users[0].Create(); err != nil {
		t.Error(err, "t_uuid: Cannot create user.")
	}
	u, err := UserByUUID(users[0].Uuid)
	if err != nil {
		t.Error(err, "User not created.")
	}
	if users[0].Email != u.Email {
		t.Errorf("User retrieved is not the same as the one created.")
	}
}

func Test_Users(t *testing.T) {
	setup()
	for _, user := range users {
		if err := user.Create(); err != nil {
			t.Error(err, "t_us: Cannot create user.")
		}
	}
	u, err := Users()
	if err != nil {
		t.Error(err, "t_us: Cannot retrieve users.")
	}
	if len(u) != 2 {
		t.Error(err, "Wrong number of users retrieved")
	}
	if u[0].Email != users[0].Email {
		t.Error(u[0], users[0], "Wrong user retrieved")
	}
}

func Test_CreateSession(t *testing.T) {
	setup()
	if err := users[0].Create(); err != nil {
		t.Error(err, "t_cs: Cannot create user.")
	}
	session, err := users[0].CreateSession()
	if err != nil {
		t.Error(err, "t_cs: Cannot create session")
	}
	if session.UserId != users[0].Id {
		t.Error("User not linked with session")
	}
}

func Test_GetSession(t *testing.T) {
	setup()
	if err := users[0].Create(); err != nil {
		t.Error(err, "t_gs: Cannot create user.")
	}
	session, err := users[0].CreateSession()
	if err != nil {
		t.Error(err, "t_gs: Cannot create session")
	}

	s, err := users[0].Session()
	if err != nil {
		t.Error(err, "t_gs: Cannot get session")
	}
	if s.Id == 0 {
		t.Error("No session retrieved")
	}
	if s.Id != session.Id {
		t.Error("Different session retrieved")
	}
}

func Test_checkValidSession(t *testing.T) {
	setup()
	if err := users[0].Create(); err != nil {
		t.Error(err, "t_cvs: Cannot create user.")
	}
	session, err := users[0].CreateSession()
	if err != nil {
		t.Error(err, "t_cvs: Cannot create session")
	}

	uuid := session.Uuid

	s := Session{Uuid: uuid}
	valid, err := s.Check()
	if err != nil {
		t.Error(err, "t_cvs: Cannot check session")
	}
	if valid != true {
		t.Error(err, "Session is not valid")
	}

}

func Test_checkInvalidSession(t *testing.T) {
	setup()
	s := Session{Uuid: "123"}
	valid, err := s.Check()
	if err == nil {
		t.Error(err, "Session is not valid but is validated")
	}
	if valid == true {
		t.Error(err, "Session is valid")
	}

}

func Test_DeleteSession(t *testing.T) {
	setup()
	if err := users[0].Create(); err != nil {
		t.Error(err, "t_ds: Cannot create user.")
	}
	session, err := users[0].CreateSession()
	if err != nil {
		t.Error(err, "t_ds: Cannot create session")
	}

	err = session.DeleteByUUID()
	if err != nil {
		t.Error(err, "t_ds: Cannot delete session")
	}
	s := Session{Uuid: session.Uuid}
	valid, err := s.Check()
	if err == nil {
		t.Error(err, "Session is valid even though deleted")
	}
	if valid == true {
		t.Error(err, "Session is not deleted")
	}
}
