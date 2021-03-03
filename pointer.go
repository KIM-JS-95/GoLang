package main

import "fmt"

func main() {
	a := 2
	b := &a
	a = 5
	fmt.Println("&메모리 주소 출력 // * 메모리주소에 저장됨 값을 출력")
	fmt.Println(&a, *b)
}
