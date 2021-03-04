package main

import "fmt"

func main() {
	nico := map[string]string{"name": "noci", "age": "12"}
	fmt.Println(nico)
	fmt.Println()

	for key, value := range nico {
		fmt.Println(key, value)
	}

}
