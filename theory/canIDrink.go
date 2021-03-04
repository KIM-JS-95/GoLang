package main

import "fmt"

func canIDrink1(age int) bool {

	if koreanAge := age + 2; koreanAge < 18 {
		return false
	} else {
		return true
	}

}

func canIDrink2(age int) bool {

	switch {
	case age < 18:
		return false
	case age == 18:
		return true
	}
	return false
}

func main() {

	fmt.Println("가정문 if")
	fmt.Println(canIDrink1(16))
	fmt.Println()
	fmt.Println("switch문")
	fmt.Println(canIDrink1(16))
}
