package main

import (
	"fmt"
	"strings"
)

func lenAndUpper(name string) (lenght int, uppercase string) {

	lenght = len(name)
	uppercase = strings.ToUpper(name)
	defer fmt.Println("good")
	return
}

func main() {
	totalLenght, up := lenAndUpper("nico")
	fmt.Println(totalLenght, up)
}
