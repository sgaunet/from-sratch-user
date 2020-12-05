package main

import (
	"fmt"
	"os/user"
	"time"
)

func main() {

	currentUser, _ := user.Current()
	user := currentUser.Username

	for {
		fmt.Println("Hello from", user)
		time.Sleep(5 * time.Second)
	}
}
