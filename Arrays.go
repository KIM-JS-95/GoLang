package main

import "fmt"

func main() {

	//slice 는 배열의 길이를 요구 하지않음
	names := []string{"a", "b", "c"}

	fmt.Println(names)
	//slice 배열에 추가하고 싶다면
	names = append(names, "d")

	fmt.Println(names)
}
